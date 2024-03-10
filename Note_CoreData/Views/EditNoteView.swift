//
//  EditNoteView.swift
//  Note_CoreData
//
//  Created by Mehdi on 2024-03-10.
//

import SwiftUI

struct EditNoteView: View {
    
    var entity: Note? // Make entity optional
    
    @ObservedObject var viewModel: NoteViewModel
    
    @State var title: String = ""
    @State var content: String = ""
    
    
    var body: some View {
        Form {
            Section("Title") {
                TextField("Write a title", text: $title)
            }
            Section("Content") {
                TextField("Write your content here", text: $content)
            }
        }
        .onAppear {
            if let note = entity {
                // If entity exists, populate fields with its data
                title = note.title ?? ""
                content = note.content ?? ""
            }
        }
        .onDisappear {
            // Apply changes when the view disappears
            if let note = entity {
                viewModel.updateNote(entity: note, newTitle: title, newContent: content, newDate: Date())
            }
            // Add new note if entity is nil and both title and content are not empty
            else if entity == nil, !title.isEmpty, !content.isEmpty {
                viewModel.addNote(title: title, content: content, date: Date())
            }
        }
    }
}

//#Preview {
//    EditNoteView(entity: Note, viewModel: <#NoteViewModel#>)
//}
