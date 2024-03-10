//
//  NoteViewModel.swift
//  Note_CoreData
//
//  Created by Mehdi on 2024-03-10.
//

import Foundation
import CoreData

class NoteViewModel: ObservableObject {
    
    @Published var notes: [Note] = []
    
    var container = Persistence.shared.container
    
    init(){
        self.fetchNotes()
    }
    
    func fetchNotes(){
        let request = NSFetchRequest<Note>(entityName: "Note")
      
        
        do{
            notes = try container.viewContext.fetch(request)
            print("fetch sucsess")
        } catch let error{
            print("error fetching: \(error)")
        }
        
        
    }
    
    func addNote(title: String, content: String, date: Date){
       
        let newNote = Note(context: container.viewContext)
        newNote.title = title
        newNote.content = content
        newNote.date = date
       
        saveData()
        
    }
    
    func updateNote(entity: Note, newTitle: String, newContent: String, newDate: Date){
        entity.title = newTitle
        entity.content = newContent
        entity.date = newDate
        
        saveData()
    }
    
    func deleteNote(indexSet: IndexSet){
        guard let index = indexSet.first else {return}
        let entity = notes[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    
    func saveData(){
        do {
           try container.viewContext.save()
        } catch let error{
            print("error adding person \(error)")
        }
        fetchNotes()
    }
    
    func dateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
    
    func filteredNotes(searchText: String) -> [Note] {
        if searchText.isEmpty {
            return notes // Return all notes if search text is empty
        } else {
            return notes.filter { note in
                return (note.title?.lowercased() ?? "").contains(searchText.lowercased()) ||
                       (note.content?.lowercased() ?? "").contains(searchText.lowercased())
            }
        }
    }

    
}
