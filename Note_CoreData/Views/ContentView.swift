//
//  ContentView.swift
//  Note_CoreData
//
//  Created by Mehdi on 2024-03-10.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = NoteViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(viewModel.notes) { entity in
                        VStack {
                            NavigationLink(destination: EditNoteView(entity: entity, viewModel: viewModel)) {
                                VStack(alignment: .leading) {
                                    Text(entity.title ?? "no title")
                                        .font(.headline)
                                    Text(entity.content ?? "no content")
                                        .font(.subheadline)
                                        .lineLimit(1) // Limiting to one line for content
                                    Text("Modified at: \(viewModel.dateFormatter().string(from: entity.date ?? Date()))")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                    .onDelete { indexSet in
                        viewModel.deleteNote(indexSet: indexSet)
                    }
                }
                .listStyle(.plain)
                .toolbar {
                    NavigationLink(destination: EditNoteView(entity: nil, viewModel: viewModel)) {
                        Label("Add Note", systemImage: "plus")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
