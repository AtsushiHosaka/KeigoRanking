//
//  User.swift
//  KeigoRanking
//
//  Created by 保坂篤志 on 2024/05/29.
//

import SwiftUI
import SwiftData

@Model
class User: ObservableObject {
    var name: String
    var lastVote: Date = Date.init(timeIntervalSince1970: 0)
    
    init(name: String) {
        self.name = name
    }
}
