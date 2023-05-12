//
//  RowView.swift
//  taskList
//
//  Created by YuzhongWang on 5/7/23.
//  Copyright © 2023 UTS. All rights reserved.
//

import SwiftUI

struct CompleteButton: View {
  let isCompleted: Bool
  let action: () -> Void

  var body: some View {
      Button(action: self.action) {
        ZStack {
          Circle()
            .stroke(isCompleted ? Color.green : Color.gray, lineWidth: 1.5)
            .frame(width: 20, height: 20)

          if isCompleted {
            Circle()
              .fill(Color.green)
              .frame(width: 12.5, height: 12.5)
          }
        }
      }
      
  }
}

struct RowView: View {
  @Binding var task: Task
  
  var body: some View {
    
    NavigationLink(
      destination: TaskEditingView(task: $task)
    ) {
      HStack {
        CompleteButton(isCompleted: task.completed) {
          print("button clicked..")
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))

        Text(task.name)
          .strikethrough(task.completed)
      }

    }
  }
}
