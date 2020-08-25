//
//  Service.swift
//  NotePad
//
//  Created by Kurs on 28/07/2020.
//  Copyright © 2020 Kurs. All rights reserved.
//

import UIKit
import CoreData

struct CRUDService {
    let context = CoreDataStack.sharedManager.persistentContainer.viewContext

    func saveNote() {
        do {
            try context.save()
            
        } catch {
            print("Error with saving data. Try again! \(error)" )
        }
    }

    func loadNotesFromSearch(predicate: NSPredicate? = nil) -> [Note] {
        var notes = [Note]()
        let request: NSFetchRequest<Note> = Note.fetchRequest()

        if let searchPredicate = predicate {
            request.predicate = searchPredicate
        }
        request.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

        do {
            try notes = context.fetch(request)
        } catch {
            print("Error with loading data \(error)")
        }
        return notes
    }

    func deleteNote(note: Note) {
        context.delete(note)
        saveNote()
    }
}
