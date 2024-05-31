import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftData

struct RankingView: View {
    @State private var mentors = [Mentor]()
    @State private var isLoading = true
    @State private var listener: ListenerRegistration?
    @State private var showAlert = false
    
    @Query var users: [User]
    
    var body: some View {
        NavigationView {
            List {
                if isLoading {
                    ProgressView()
                } else {
                    ForEach(mentors) { mentor in
                        MentorView(mentor: mentor)
                            .alert("連打すんな！！！！", isPresented: $showAlert, actions: {
                                Button("反省します", role: .none) {
                                    showAlert = false
                                }
                            }, message: {
                                Text("") // メッセージ部分を空にする
                            })
                            .onTapGesture {
                                voted(mentor: mentor)
                            }
                    }
                }
            }
            .navigationTitle("敬語ランキング")
            .onAppear {
                loadMentorsFromFirestore()
            }
            .onDisappear {
                listener?.remove() // リスナーを削除
            }
        }
    }
    
    func voted(mentor: Mentor) {
        let user = users.first!
        
        if user.lastVote.timeIntervalSinceNow > -60 {
            showAlert = true
            return
        }
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        user.lastVote = Date.now
        
        updateMentorCount(mentor: mentor)
        addVoteLog(to: mentor)
    }
    
    func loadMentorsFromFirestore() {
        let db = Firestore.firestore()
        let mentorsCollection = db.collection("mentors")
        listener = mentorsCollection.addSnapshotListener { snapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                guard let documents = snapshot?.documents else { return }
                self.mentors = documents.map { document in
                    let data = document.data()
                    let id = document.documentID
                    let count = data["count"] as? Int ?? 0
                    let name = data["name"] as? String ?? "Unknown"
                    let imageString = data["image"] as? String ?? "person.fill"
                    let image = UIImage(named: imageString) ?? UIImage(systemName: "person.fill")!
                    return Mentor(id: id, count: count, name: name, image: image)
                }
                self.isLoading = false
            }
        }
    }
    
    func updateMentorCount(mentor: Mentor) {
        let db = Firestore.firestore()
        db.collection("mentors").document(mentor.id).updateData(["count": mentor.count + 1]) { error in
            if let error = error {
                print("Error updating document: \(error)")
            }
        }
    }
    
    func addVoteLog(to mentor: Mentor) {
        guard let user = users.first else {
            print("No user available")
            return
        }
        
        let db = Firestore.firestore()
        
        db.collection("log").addDocument(data: [
            "from": user.name,
            "to": mentor.name
        ])
    }
}

#Preview {
    RankingView()
        .modelContainer(for: User.self)
}
