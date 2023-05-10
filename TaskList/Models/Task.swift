//
//  Task.swift
//  taskList
//
//  Created by YuzhongWang on 5/7/23.
//  Copyright © 2023 UTS. All rights reserved.
//

import Foundation

struct Task: Identifiable {
  var id = UUID()
  
  var name: String
  var completed = false
}
