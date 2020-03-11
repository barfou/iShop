//
//  ViewController.swift
//  iShop
//
//  Created by lpiem on 11/03/2020.
//  Copyright © 2020 lpiem. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataManager: CoreDataManager {
        get {
            return CoreDataManager.shared
        }
    }
    var items: [Item]!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let items = dataManager.loadItems() {
            
            self.items = items
            tableView.reloadData()
        }
    }
    
    // MARK
    
    @IBAction func Sort(_ sender: UIBarButtonItem) {
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        let item = items[indexPath.row]
        cell.textLabel?.text = item.name
        return cell
    }
}

