//
//  MentorView.swift
//  KeigoRanking
//
//  Created by 保坂篤志 on 2024/05/16.
//

import SwiftUI

struct MentorView: View {
    var mentor: Mentor
    
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                Rectangle()
                    .frame(width: min(CGFloat(mentor.count) * 5, 300), height: 30)
                    .foregroundColor(.blue)
                    .opacity(0.5)
                    .cornerRadius(5)
            }
            
            HStack {
                Image(uiImage: mentor.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                Text(mentor.name)
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                    .padding(.leading, 10)
                Spacer()
                
                Text("\(mentor.count)")
                    .fontWeight(.bold)
                    .font(.system(size: 20))
            }
        }
        .padding(.horizontal)  // 水平方向のパディング
        .padding(.vertical, 8)  // 垂直方向のパディングを追加
    }
}


#Preview {
    MentorView(mentor: Mentor(count: 100, name: "えーえす", image: UIImage(systemName: "person.fill")!))
}
