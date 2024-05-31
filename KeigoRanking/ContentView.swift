//
//  ContentView.swift
//  KeigoRanking
//
//  Created by 保坂篤志 on 2024/05/16.
//
import SwiftUI
import SwiftData
import Firebase
import FirebaseFirestore

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query private var user: [User]
    
    var body: some View {
        if user.isEmpty {
            AuthView()
        } else {
            RankingView()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: User.self)
}
