//
//  ContentView.swift
//  Notes
//
//  Created by Shirley Averette on 6/7/24.
//

import SwiftUI

struct ContentView: View {
   
    @StateObject var noteApp = NoteViewModel()
    @State var note = NoteModel(title: "", notesdata: "")
    
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
    ContentView()
}
