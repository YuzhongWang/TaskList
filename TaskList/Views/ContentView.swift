//
//  ContentView.swift
//  taskList
//
//  Created by YuzhongWang on 5/7/23.
//  Copyright © 2023 UTS. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  
  /// view model
  @ObservedObject var viewModel = TodoViewModel()
  
  @State var modalIsPresented = false
  
  @State private var view: ItemStatusFilter = .all
  
  /// bottom button
  var filterControls: some View {
    
    VStack(alignment: .center, spacing: 16) {
      Picker(selection: self.$view, label: Text("Status")) {
        Text("All").tag(ItemStatusFilter.all)
        Text("Active").tag(ItemStatusFilter.active)
        Text("Completed").tag(ItemStatusFilter.completed)
      }
      .pickerStyle(SegmentedPickerStyle())

      HStack {
        Text("\(self.viewModel.incompleteCount) item\(self.viewModel.incompleteCount == 1 ? "" : "s") left\(self.viewModel.completeCount > 0 ? "." : "")")
          .foregroundColor(Color.gray)
        if self.viewModel.completeCount > 0 {
          Button("Clear completed.", action: {
            self.viewModel.clearCompleted()
          })
        }
      }
      .font(Font.caption)
      .animation(nil)
    }
    .padding(.horizontal)
  }
  
  var body: some View {
    NavigationView {
      ZStack {
        VStack {
          
          // listView
          List {
            ForEach(viewModel.prioritizedTasks) { index in
              SectionView(prioritizedTasks: self.$viewModel.prioritizedTasks[index], itemStatusFilter: self.$view)
            }
          }
          .listStyle(.grouped)
          .navigationBarTitle("ToDoList")
          .navigationBarItems(
            leading: EditButton(),
            trailing:
              Button(
                action: { self.modalIsPresented = true }
              ) {
                Image(systemName: "plus")
              }
          )
          
          // bottom view
          filterControls
          
        }
      }
    }
    .sheet(isPresented: $modalIsPresented) {
      NewTaskView(viewModel: self.viewModel)
    }

  }
}

