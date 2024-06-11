//
//  NoteDetail.swift
//  Notes
//
//  Created by Shirley Averette on 6/7/24.
//

import SwiftUI

struct NoteDetail: View {
    
   @Binding var note : NoteModel
    @StateObject var noteApp = NoteViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Note Title", text: $note.title)
                .font(.system(size: 25))
                .fontWeight(.bold)
            TextEditor(text: $note.notesdata)
                .font(.system(size: 25))
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                Button {
                    noteApp.saveData(note: note)
                    note.title = ""
                    note.notesdata = ""
                } label: {
                    Text("Save")
                }
            }
        }
    }
}

#Preview {
    NoteDetail(note: .constant(NoteModel(title: "one", notesdata: "one")))
}
