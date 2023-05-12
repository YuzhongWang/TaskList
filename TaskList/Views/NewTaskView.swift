//
//  NewTaskView.swift
//  taskList
//
//  Created by YuzhongWang on 5/7/23.
//  Copyright © 2023 UTS. All rights reserved.
//

import SwiftUI

struct NewTaskView: View {
  
  var viewModel: TodoViewModel
  
  @Environment(\.presentationMode) var presentationMode
  
  @State var text = ""
  @State var priority: Task.Priority = .no
  
  var body: some View {
    
    ZStack {
      NavigationView {
        VStack(spacing: 32.0) {
          TextField("Task Name", text: $text)
          VStack {
            Text("Priority")
            Picker("Priority", selection: $priority.caseIndex) {
              ForEach(Task.Priority.allCases.indices) { priorityIndex in
                Text(
                  Task.Priority.allCases[priorityIndex].rawValue.capitalized)
                    .tag(priorityIndex)
                  }
                }
                .pickerStyle( SegmentedPickerStyle() )
              }
          Spacer()
        }
        .padding()
        .navigationBarTitle("Create Task")
        .navigationBarItems(
          leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
          }) {
            Image(systemName: "xmark")
              .imageScale(.large)
          },
          trailing: Button(action: {
            self.viewModel.createTodo(priority: self.priority, title: self.text)
            self.presentationMode.wrappedValue.dismiss()
          }) {
            Text("Save")
          }
          .disabled(text.isEmpty)
        )
        .navigationViewStyle(StackNavigationViewStyle())

      }
    }
  }
}

