//
//  NotesViewController.swift
//  notedNotables
//
//  Created by jp on 2019-03-13.
//  Copyright © 2019 Jordan Perrella. All rights reserved.
//

import UIKit
import CoreData


class NotesViewController: UITableViewController {
  
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  var notes = [Note]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.rowHeight = 80.0
  }
  
  @IBAction func addNoteButtonTapped(_ sender: UIBarButtonItem) {
    // we need this in order to access the text field data outside of the 'addTextField' scope below
    var tempTextField = UITextField()
    
    // create a UIAlertController object
    let alertController = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
    
    // create a UIAlertAction object
    let alertAction = UIAlertAction(title: "Done", style: .default) { (action) in
      // create a new item from our Item core data entity (we pass it the context)
      let newNote = Note(context: self.context)
      
      // if the text field text is not nil
      if let text = tempTextField.text {
        // set the item attributes
        newNote.title = text
        
        // append the item to our notes array
        self.notes.append(newNote)
        
        // call our savenotes() method which saves our context and reloads the table
        self.saveNotes()
      }
    }
    
    alertController.addTextField { (textField) in
      textField.placeholder = "Title"
      tempTextField = textField
    }
    
    // Add the action we created above to our alert controller
    alertController.addAction(alertAction)
    // show our alert on screen
    present(alertController, animated: true, completion: nil)
    
  }
  
  func saveNotes(){
    do{
      try context.save()
    }catch{
      print("Error Saving Note \(error)")
    }
    tableView.reloadData()
  }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notes.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
      let note = notes[indexPath.row]
      cell.textLabel?.text = note.title
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
