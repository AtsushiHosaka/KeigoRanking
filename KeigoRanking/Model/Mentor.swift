//
//  Mentor.swift
//  KeigoRanking
//
//  Created by 保坂篤志 on 2024/05/16.
//

import SwiftUI

struct Mentor: Identifiable {
    var id: String = UUID().uuidString
    var count: Int
    var name: String
    var image: UIImage
}
