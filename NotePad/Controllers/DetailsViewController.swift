//
//  DetailsViewController.swift
//  NotePad
//
//  Created by Kurs on 27/07/2020.
//  Copyright © 2020 Kurs. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UITextViewDelegate, UIGestureRecognizerDelegate {

    let crudService = CRUDService()

    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var updateButton: UIBarButtonItem!

    var note: Note?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateButton.isEnabled = false
        titleTextView.delegate = self
        contentTextView.delegate = self
        titleTextView.text = note?.title
        contentTextView.text = note?.content
    }

    @IBAction func updateButtonPressed(_ sender: UIBarButtonItem) {
        note?.title = titleTextView.text
        note?.content = contentTextView.text
        note?.creationDate =  Date()
        crudService.saveNote()
        updateButton.isEnabled = false
        titleTextView.isEditable = false
        contentTextView.isEditable = false
        editTextViews()
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        updateButton.isEnabled = true
    }

    func editTextViews() {
        titleTextView.isEditable = true
        contentTextView.isEditable = true
    }
}
