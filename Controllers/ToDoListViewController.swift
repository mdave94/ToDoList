//
//  ViewController.swift
//  ToDo
//
//  Created by Molnár Dávid on 2019. 10. 21..
//  Copyright © 2019. Molnár Dávid. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {

    var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
   // let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: //.userDomainMask).first?.appendingPathComponent("Items.plist")
        

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
      loadItems()
        
        
        
    }
     //MARK: - override tableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        // one line if statement
        cell.accessoryType = item.done  ? .checkmark : .none
        
        
        
        return cell
    }
    
    // MARK: -delegate method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   
        //itemArray[indexPath.row].setValue(true, forKey: "done")
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
       
        saveItems()
        
     
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    //MARK: add new element to a list
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var inputText = UITextField()
        
        
        let alert   = UIAlertController(title: "Új elem felvétele", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Elem hozzáadása", style: .default) { (action) in
                        
            
           
            let newItem = Item(context: self.context)
            newItem.title = inputText.text!
            newItem.done = false
            
            self.itemArray.append(newItem)
            
            self.saveItems()
            
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "új elem felvétele"
            inputText = alertTextField
        }
        
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
        
    }
    //MARK: - save Data method
    
    func saveItems(){
      
                   
                   do {
                    try context.save()
                      
                   }catch{
                       
                       print("error saving context : \(error)")
                   }
        
    }
    
    func loadItems(){
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
           itemArray =  try context.fetch(request)
            
        }catch {
            print("Error in reading the DataModel: \(error)")
        }
        
    }
    
    
    
    
    
    
    
    
    
    
}

