//
//  ViewController.swift
//  Todoey
//
//  Created by Shah, Raj Kumar-CW on 2/2/18.
//  Copyright © 2018 Shah, Raj Kumar-CW. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = [Items]()
    
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let item = Items()
        item.title = "Raj"
        itemArray.append(item)
        
        
        let item2 = Items()
        item2.title = "Kapil"
        itemArray.append(item2)
        
        let item3 = Items()
        item3.title = "Annie"
        itemArray.append(item3)
        
        let item4 = Items()
        item4.title = "Raj4"
        itemArray.append(item4)
        
        
        let item24 = Items()
        item24.title = "Kapil4"
        itemArray.append(item24)
        
        let item34 = Items()
        item34.title = "Annie4"
        itemArray.append(item34)
        
        if let items = defaults.array(forKey: "ToDoListObject") as? [Items] {
            itemArray = items
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var alertTextField : UITextField = UITextField()
        let alert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
//            print(alertTextField.text!)
            let newitem = Items()
            newitem.title = alertTextField.text!
            self.itemArray.append(newitem)
            self.defaults.set(self.itemArray, forKey: "ToDoListObject")
            self.tableView.reloadData()
            
        }
        alert.addTextField { (textField) in
            alertTextField = textField
            textField.placeholder = "Create New Item"
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
}

