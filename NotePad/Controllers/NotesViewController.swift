//
//  ViewController.swift
//  NotePad
//
//  Created by Kurs on 27/07/2020.
//  Copyright © 2020 Kurs. All rights reserved.
//

import UIKit
import CoreData

class NotesViewController: UITableViewController {

    let crudService = CRUDService()
    var formatter = DataFormatterHelper()
    
    @IBOutlet weak private var searchBar: UISearchBar!
    
    var notes = [Note]()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        searchBar.delegate = self
        notes = crudService.loadNotesFromSearch()
        tableView.reloadData()
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: Constants.noteSaveSegue, sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow, let detailsVC = segue.destination as? DetailsViewController {
            detailsVC.note = notes[indexPath.row]
        }
    }
}
//MARK: - Data Source
extension NotesViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: Constants.notesCell)
        cell.textLabel?.text = notes[indexPath.row].title
        cell.detailTextLabel?.text = formatter.dateFormatter(with: notes[indexPath.row].creationDate!)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.noteDetailsSegue, sender: self)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            crudService.deleteNote(note: notes[indexPath.row])
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
//MARK: - SearchBar Delegate
extension NotesViewController: UISearchBarDelegate {

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if let value = searchBar.text?.count {
            switch value {

            case 0:
                notes = crudService.loadNotesFromSearch()
                tableView.reloadData()
                DispatchQueue.main.async {
                    searchBar.resignFirstResponder()
                }

            case 1... :
                let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
                notes = crudService.loadNotesFromSearch(predicate: predicate)
                tableView.reloadData()

            default:
                print("Error searchBar")
            }
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.text = ""
        searchBar.showsCancelButton = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
