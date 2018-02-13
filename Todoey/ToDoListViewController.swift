//
//  ViewController.swift
//  Todoey
//
//  Created by Shah, Raj Kumar-CW on 2/2/18.
//  Copyright © 2018 Shah, Raj Kumar-CW. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift

class ToDoListViewController: UITableViewController {

    var toDoItem: Results<Item>?
    var selectedCategory : Category?
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        loadItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        if let item = toDoItem?[indexPath.row]{
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        }else {
            cell.textLabel?.text = "No Item Added."
        }
       
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItem?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = toDoItem?[indexPath.row] {
            do{
                try realm.write {
                    item.done = !item.done
                }
            }catch{
                print("Error saving the done list, \(error)")
            }
        }
       
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var alertTextField : UITextField = UITextField()
        let alert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if let currentCategoty = self.selectedCategory {
                do{
                    try self.realm.write {
                        let newitem = Item()
                        newitem.title = alertTextField.text!
                        newitem.done = false
                        newitem.dateCreated = Date()
                        currentCategoty.items.append(newitem)
                    }
                }catch{
                    print("Unable to save new item \(error)")
                }
            }
            self.tableView.reloadData()
        }
        alert.addTextField { (textField) in
            alertTextField = textField
            textField.placeholder = "Create New Item"
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    func loadItems() {
        toDoItem = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
    }
    
   
}

extension ToDoListViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        toDoItem = toDoItem?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.characters.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()

            }
        }
    }
    
}
