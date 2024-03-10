//
//  ContentView.swift
//  Note_CoreData
//
//  Created by Mehdi on 2024-03-10.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = NoteViewModel()
    
    @State private var sortOrder = [SortDescriptor(\Note.date)]
    @State private var searchText = ""
    
    @State var title: String = ""
    @State var content: String = ""
    
    var body: some View {
        NavigationStack{
            
            VStack {
                
                List{
                    ForEach(viewModel.notes){ entity in
                        
                        VStack{
                            NavigationLink{
                                EditNoteView(entity: entity, viewModel: viewModel)

                            }label :{
                                VStack(alignment: .leading) {
                                    Text(entity.title ?? "no title")
                                        .font(.headline)
                                    Text(entity.content ?? "no content")
                                        .font(.subheadline)
                                        .lineLimit(1) // Limiting to one line for content
                                    
                                    Text("Modified: \(viewModel.dateFormatter().string(from: entity.date ?? Date()))")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    
                                }
                            }
                            
                        
                        }
                        .cornerRadius(10)
                            
                            
                    
                    }
                    .onDelete( perform: { indexSet in
                        viewModel.deleteNote(indexSet: indexSet)
                    }

                    )
                }
                .listStyle(.plain)
                .toolbar {
                    NavigationLink(destination: EditNoteView(entity: nil, viewModel: viewModel)) {
                        Label("Add Note", systemImage: "plus")
                    }
                }
               
            }
            .padding()
        }
        .navigationTitle("My Notes")
        
    }
    
    func addNote(){
        if title.isEmpty || content.isEmpty {
            return
        }
        viewModel.addNote(title: title, content: content, date: Date())
        title = ""
        content = ""
    }
}


#Preview {
    ContentView()
}
