//
//  ViewController.swift
//  ToDoAD
//
//  Created by Arek on 18/03/2018.
//  Copyright © 2018 Arek. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    @IBOutlet weak var searchBar: UISearchBar!
 
    
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let context = (UIApplication.shared.delegate as! AppDelegate).presistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        

      
        loadItems()
        
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items
//        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    //MARK - tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
        
        }
        
        //MARK - tableView Delegate Methds
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
//            itemArray.remove(at: indexPath.row)
//            context.delete(itemArray[indexPath.row])
            
  itemArray[indexPath.row].done = !itemArray[indexPath.row].done
            
            saveItems()
        
            
            tableView.deselectRow(at: indexPath, animated: true)
        
        }
        
        //MARk - Add New Items
        
        @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todo Item", message: "",
        preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
  
        
        let newItem = Item(context: self.context)
            
        newItem.title = textField.text!
        newItem.done = false
        
        self.itemArray.append(newItem)
        
        self.saveItems()
            }
       
        
        alert.addTextField {(alertTextField) in
        alertTextField.placeholder = "Create new item"
        textField = alertTextField
        }
        
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    
    //MARK - Model Manupulation Methods
    func saveItems() {
        
        do {
            try context.save()
            
        } catch {
           print("error saving context \(error)")
        }
        
        //  self.defaults.set(self.itemArray, forKey: "TodoListArray")
        
        self.tableView.reloadData()
        
            }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
      //  let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
            itemArray = try context.fetch(request)
            
        } catch {
            print("Error fetching data from context \(error)")
            
        }
    }
}
        
        //MARK: - Search Bar methods
        
        extension TodoListViewController: UISearchBarDelegate {
            
            func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
                let request: NSFetchRequest<Item> = Item.fetchRequest()
             
                request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
                
    
                
                request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
       
                loadItems(with: request)
                
                
// above is replacaement of below we just use leadItems and with request going to loadItem func
//                do {
//                    itemArray = try context.fetch(request)
//
//                } catch {
//                    print("Error fetching data from context \(error)")
//
//                }
//                tableView.reloadData()
            }
        }





