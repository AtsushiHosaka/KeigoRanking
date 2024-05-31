//
//  AuthView.swift
//  KeigoRanking
//
//  Created by 保坂篤志 on 2024/05/29.
//

import SwiftUI
import SwiftData

struct AuthView: View {
    @State var inputText: String = ""
    @Query var user: [User]
    @Environment(\.modelContext) var context
    
    var body: some View {
        VStack {
            TextField("Enter your name", text: $inputText)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .multilineTextAlignment(.center)
            
            Button(action: {
                if !inputText.isEmpty {
                    
                    if user.isEmpty {
                        context.insert(User(name: inputText))
                    }
                }
            }) {
                Text("Confirm")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    AuthView()
        .modelContainer(for: User.self)
}
