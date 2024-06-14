//
//  NotesView.swift
//  Notes
//
//  Created by Shirley Averette on 6/13/24.
//

import SwiftUI



struct NotesView: View {
    
    @StateObject var noteApp = NoteViewModel()
    @State var note = NoteModel(ownerID: "", title: "", notesdata: "")
    @ObservedObject var appAuth = AuthViewModel()
    
    var body: some View {
        NavigationStack() {
            List {
                ForEach($noteApp.notes){ $note in
                    NavigationLink {
                        NoteDetail(note: $note)
                    } label: {
                        Text(note.title)
                    }
                }
                Section{
                    NavigationLink {
                        NoteDetail(note: $note)
                    } label: {
                        Text("New Note")
                            .foregroundColor(Color.gray)
                            .font(.system(size: 15))
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Sign Out") {
                        appAuth.SignOut()
                    }
                }
            }
            .onAppear() {
                noteApp.fetchData()
            }
            .refreshable {
                noteApp.fetchData()
            }
        }
    }
}

#Preview {
    NotesView()
}
