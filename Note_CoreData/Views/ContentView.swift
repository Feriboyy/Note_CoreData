//
//  ContentView.swift
//  Note_CoreData
//
//  Created by Mehdi on 2024-03-10.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = NoteViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                
                List {
                    ForEach(viewModel.filteredNotes(searchText: searchText)) { entity in
                        VStack {
                            NavigationLink(destination: EditNoteView(entity: entity, viewModel: viewModel)) {
                                VStack(alignment: .leading) {
                                    Text(entity.title ?? "no title")
                                        .font(.headline)
                                    Text(entity.content ?? "no content")
                                        .font(.subheadline)
                                        .lineLimit(1)
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
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: EditNoteView(entity: nil, viewModel: viewModel)) {
                        Label("Add Note", systemImage: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.toggleSortType()
                    }) {
                        Image(systemName: viewModel.sortType == .ascending ? "arrow.up" : "arrow.down")
                    }
                }
                
                
            }
            .navigationTitle("My Notes")
        }
    }
}

// Add a SearchBar component
struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 8)
                .onTapGesture {
                    // Clear text when tapped
                    text = ""
                }
            Spacer()
        }
        .padding(.top, 8)
    }
}

#Preview {
    ContentView()
}
