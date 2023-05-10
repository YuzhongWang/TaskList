//
//  Binding.swift
//  taskList
//
//  Created by YuzhongWang on 5/7/23.
//  Copyright © 2023 UTS. All rights reserved.
//

import SwiftUI

public extension Binding where Value: CaseIterable & Equatable {
  var caseIndex: Binding<Value.AllCases.Index> {
    Binding<Value.AllCases.Index>(
      get: { Value.allCases.firstIndex(of: self.wrappedValue)! },
      set: { self.wrappedValue = Value.allCases[$0] }
    )
  }
}
