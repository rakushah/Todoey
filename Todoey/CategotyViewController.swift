//
//  CategotyViewController.swift
//  Todoey
//
//  Created by Shah, Raj Kumar-CW on 2/6/18.
//  Copyright © 2018 Shah, Raj Kumar-CW. All rights reserved.
//

import UIKit
import RealmSwift
class CategotyViewController: UITableViewController {

    let realm = try! Realm()
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! ToDoListViewController
        
        if let index = tableView.indexPathForSelectedRow {
            destVC.selectedCategory = categories?[index.row]
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategotyCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories added yet"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var alertTextField : UITextField = UITextField()
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            //            print(alertTextField.text!)
            let newitem = Category()
            newitem.name = alertTextField.text!
            self.saveItems(category: newitem)
            
        }
        alert.addTextField { (textField) in
            alertTextField = textField
            textField.placeholder = "Create New Category"
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)

    }
    
    func saveItems(category : Category) {
        do{
            try realm.write {
                realm.add(category)
            }
        }catch{
            print("Error saving the core data : \(error)")
        }
        self.tableView.reloadData()
        
    }
    
    func loadCategories(){
        categories = realm.objects(Category.self)

    }
    
}
