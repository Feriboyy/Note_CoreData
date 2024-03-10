//
//  EditNoteView.swift
//  Note_CoreData
//
//  Created by Mehdi on 2024-03-10.
//

import SwiftUI

struct EditNoteView: View {
    
    var entity: Note
    @ObservedObject var viewModel: NoteViewModel
    
    @State var title: String = ""
    @State var content: String = ""
    
    
    var body: some View {
        Form{
            Section("Title"){
                TextField("Write a title", text: $title)
            }
            Section("Content"){
                TextField("Write your content here", text: $content)
            }
            Button("Save Changes") {
                
                if title.isEmpty || content.isEmpty {
                    return
                }
                viewModel.updateNote(entity: entity, newTitle: title, newContent: content, newDate: Date())
            }
        }
        
    }
}

//#Preview {
//    EditNoteView(entity: Note, viewModel: <#NoteViewModel#>)
//}
