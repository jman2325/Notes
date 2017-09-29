//
//  ViewController.swift
//  Notes
//
//  Created by Jacob Bailey on 6/23/17.
//  Copyright © 2017 Jacob Bailey. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    
    var tableData:[String] = []
    let saveKey = "notes"
    let segueKey = "detail"
    var file: String!
    var selectedRow: Int = -1
    var newRowText: String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Notes"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        self.navigationItem.rightBarButtonItem = addButton
        self.navigationItem.leftBarButtonItem = editButtonItem
        
        let docsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
        file = docsDirectory[0].appending("notes.txt")
        
        load()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if selectedRow == -1 {
            return
        }
        tableData[selectedRow] = newRowText
        if newRowText == "" {
            tableData.remove(at: selectedRow)
        }
        table.reloadData()
        save()
        
    }
    
    @objc func addNote() {
        if(table.isEditing) {
            return
        }
        let name: String = ""
        tableData.insert(name, at: 0)
        let indexPath: IndexPath = IndexPath(row: 0, section: 0)
        table.insertRows(at: [indexPath], with: .automatic)
        table.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        self.performSegue(withIdentifier: segueKey, sender: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = tableData[indexPath.row]
        return cell
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        table.setEditing(editing, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        tableData.remove(at: indexPath.row)
        table.deleteRows(at: [indexPath], with: .fade)
        save()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: segueKey, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailView: DetailViewController = segue.destination as! DetailViewController
        selectedRow = table.indexPathForSelectedRow!.row
        detailView.masterView = self
        detailView.setText(text: tableData[selectedRow])
    }
    
    func save() {
        //UserDefaults.standard.set(tableData, forKey: saveKey)
        //UserDefaults.standard.synchronize()
        
        let newData: NSArray = NSArray(array: tableData)
        newData.write(toFile: file, atomically: true)
        
    }

    func load() {
        if let loadedData = NSArray(contentsOfFile: file) as? [String] {
            tableData = loadedData
            table.reloadData()
        }
    }

}


































































