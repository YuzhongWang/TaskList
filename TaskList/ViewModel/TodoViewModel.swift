//
//  TodoViewModel.swift
//  taskList
//
//  Created by YuzhongWang on 5/7/23.
//  Copyright © 2023 UTS. All rights reserved.
//

import Foundation
import Combine

final class TodoViewModel: ObservableObject {
  
  init () {
    prioritizedTasks = [
      PrioritizedTasks(
        priority: .high,
        names: [
          "Go to basketball match",
          "Walk the dog",
          "Grocery shopping",
          "Buy concert tickets"
        ]
      ),
      PrioritizedTasks(
        priority: .medium,
        names: [
          "Get netflix membership",
          "Visit neighbor"
        ]
      ),
      PrioritizedTasks(
        priority: .low,
        names: [
          "Get new basketball shoes"
        ]
      ),
      PrioritizedTasks(
        priority: .no,
        names: [
          "Go to Melbourne",
          "Go to London",
          "Get 4090 graphics card"
        ]
      )
    ]
  }
  
  @Published var prioritizedTasks: [PrioritizedTasks] = [] {
    didSet {
      incompleteCount = prioritizedTasks.flatMap { $0.tasks }.filter { !$0.completed }.count
      completeCount = prioritizedTasks.flatMap { $0.tasks }.count - incompleteCount
    }
  }

  var incompleteCount: Int = 0
  var completeCount: Int = 0


  func createTodo(priority: Task.Priority, title: String) {
    let index = getIndex(for: priority)
    prioritizedTasks[index].tasks.append(Task(name: title))
  }

  func clearCompleted() {
    var temp: [PrioritizedTasks] = []
    for var item in prioritizedTasks {
      item.tasks.removeAll { $0.completed }
      temp.append(item)
    }
    prioritizedTasks = temp
  }
  
  func getIndex(for priority: Task.Priority) -> Int {
    prioritizedTasks.firstIndex { $0.priority == priority }!
  }
  
}

extension TodoViewModel {
  struct PrioritizedTasks {
    let priority: Task.Priority
    var tasks: [Task]
  }
}

extension TodoViewModel.PrioritizedTasks: Identifiable {
  var id: Task.Priority { priority }
}

private extension TodoViewModel.PrioritizedTasks {
  init(priority: Task.Priority, names: [String]) {
    self.init(
      priority: priority,
      tasks: names.map { Task(name: $0) }
    )
  }
}
