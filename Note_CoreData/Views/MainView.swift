//
//  ContentView.swift
//  Note_CoreData
//
//  Created by Mehdi on 2024-03-10.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel = NoteViewModel()
    @State private var searchText = ""
    @State private var selectedCategory = "All notes" // Default category
    
    var categories = ["All notes", "General", "Work", "School", "Family"] // Include "All notes" option
    
    var filteredNotes: [Note] {
        if selectedCategory == "All notes" {
            return viewModel.filteredNotes(searchText: searchText)
        } else {
            return viewModel.filteredNotes(searchText: searchText).filter { $0.category == selectedCategory }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                
                Picker("Category", selection: $selectedCategory) {
                    ForEach(categories, id: \.self) { category in
                        Text(category)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                .padding(.bottom)
                
                List {
                    ForEach(filteredNotes) { entity in
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
            .navigationTitle("My Notes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Button(action: {
                            viewModel.toggleSortType()
                        }) {
                            Image(systemName: viewModel.sortType == .ascending ? "arrow.up" : "arrow.down")
                                .font(.headline)
                        }
                        .padding()
                        NavigationLink(destination: EditNoteView(entity: nil, viewModel: viewModel)) {
                            Image(systemName: "plus")
                                .font(.headline)
                        }
                    }
                    .padding(30)
                }
            }
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
    MainView()
}
