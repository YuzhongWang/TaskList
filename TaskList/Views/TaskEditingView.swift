//
//  TaskEditingView.swift
//  taskList
//
//  Created by YuzhongWang on 5/7/23.
//  Copyright © 2023 UTS. All rights reserved.
//

import SwiftUI

struct TaskEditingView: View {
  @Binding var task: Task
  
  var body: some View {
    Form {
      TextField("Name", text: $task.name)
      Toggle("Completed", isOn: $task.completed)
    }
  }
}

