//
//  Persistence.swift
//  NotePadCoreData
//
//  Created by Mehdi on 2024-03-08.
//

import Foundation
import CoreData

struct Persistence{
    static let shared = Persistence()
    
    let container: NSPersistentContainer
    init() {
        container = NSPersistentContainer(name: "NoteModel")
        
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading core data: \(error)")
            } else {
                print("Loading successful!")
            }
        }
    }
}
