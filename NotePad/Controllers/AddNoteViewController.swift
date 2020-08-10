//
//  AddNoteViewController.swift
//  NotePad
//
//  Created by Kurs on 28/07/2020.
//  Copyright © 2020 Kurs. All rights reserved.
//

import UIKit
import CoreData

class AddNoteViewController: UIViewController, UITextViewDelegate {

    let crudService = CRUDService()

    @IBOutlet weak var titleLabel: UITextView!
    @IBOutlet weak var contentLabel: UITextView!

    override func loadView() {
        super.loadView()
    }

    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        let newNote = Note(context: crudService.context)
        newNote.title = titleLabel.text.isEmpty ? "Title" : titleLabel.text
        newNote.content = contentLabel.text.isEmpty ? "Content is empty" : contentLabel.text
        newNote.creationDate =  Date()
        crudService.saveNote()
        self.navigationController?.popViewController(animated: true)
    }
}
