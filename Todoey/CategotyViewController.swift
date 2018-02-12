//
//  CategotyViewController.swift
//  Todoey
//
//  Created by Shah, Raj Kumar-CW on 2/6/18.
//  Copyright © 2018 Shah, Raj Kumar-CW. All rights reserved.
//

import UIKit
import CoreData
class CategotyViewController: UITableViewController {

    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
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
            destVC.selectedCategory = categoryArray[index.row]
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategotyCell", for: indexPath)
        
        cell.textLabel?.text = categoryArray[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var alertTextField : UITextField = UITextField()
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            //            print(alertTextField.text!)
            let newitem = Category(context: self.context)
            newitem.name = alertTextField.text!
            self.categoryArray.append(newitem)
            self.saveItems()
            
        }
        alert.addTextField { (textField) in
            alertTextField = textField
            textField.placeholder = "Create New Category"
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)

    }
    
    func saveItems() {
        do{
            try self.context.save()
        }catch{
            print("Error saving the core data : \(error)")
        }
        self.tableView.reloadData()
        
    }
    
    func loadCategories(with request : NSFetchRequest<Category> = Category.fetchRequest()){
        
        do{
            try categoryArray = context.fetch(request)
        }catch{
            print("Unable to get Catagery form context : \(error)")
        }
        self.tableView.reloadData()

    }
    
}
