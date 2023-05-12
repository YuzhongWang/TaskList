//
//  SectionView.swift
//  taskList
//
//  Created by YuzhongWang on 5/7/23.
//  Copyright © 2023 UTS. All rights reserved.
//

import SwiftUI

struct SectionView: View {
  @Binding var prioritizedTasks: TodoViewModel.PrioritizedTasks
  @Binding var itemStatusFilter: ItemStatusFilter
  
  func shouldShowItem(item: Task) -> Bool {
    switch itemStatusFilter {
    case .all: return true
    case .active: return !item.completed
    case .completed: return item.completed
    }
  }
  
  var body: some View {
    
    Section(
      header: Text(
        "\(prioritizedTasks.priority.rawValue.capitalized) Priority"
      )
    ) {
      
      
      ForEach(prioritizedTasks.tasks.filter { self.shouldShowItem(item: $0) }) { index in
        RowView(task: self.$prioritizedTasks.tasks.filter { item in self.shouldShowItem(item: item.wrappedValue) }[index])
      }
      .onMove { sourceIndices, destinationIndex in
        self.prioritizedTasks.tasks.move(
          fromOffsets: sourceIndices,
          toOffset: destinationIndex
        )
      }
      .onDelete { indexSet in
        self.prioritizedTasks.tasks.remove(atOffsets: indexSet)
      }
    }
  }
}

