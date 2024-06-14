//
//  NoteModel.swift
//  Notes
//
//  Created by Shirley Averette on 6/7/24.
//

import Foundation
import FirebaseFirestoreSwift

struct NoteModel : Codable, Identifiable {
    @DocumentID var id: String?
    var ownerID: String
    var title: String
    var notesdata: String
}
