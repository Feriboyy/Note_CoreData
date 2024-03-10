//
//  ContentView.swift
//  Note_CoreData
//
//  Created by Mehdi on 2024-03-10.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = NoteViewModel()
    
    @State var title: String = ""
    @State var content: String = ""
    
    var body: some View {
        NavigationView{
            VStack {
                TextField("title", text: $title)
                    .padding()
                
                TextField("content", text: $content)
                    .padding()
                Button("Save"){
                    addNote()
                }
                .padding()
                .background(.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
                
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
                                    if let date = entity.date {
                                                Text(date, style: .date)
                                                    .font(.caption)
                                                    .foregroundColor(.gray)
                                            }
                                }
                            }
                            
                        
                        }
                        .padding()
                        .cornerRadius(10)
                            
                            
                    
                    }
                    .onDelete( perform: { indexSet in
                        viewModel.deleteNote(indexSet: indexSet)
                    }

                    )
                }
                .listStyle(.plain)
               
            }
            .padding()
        }
        
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
