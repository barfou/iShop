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
    
    enum SortState {
        case ascending
        case descending
    }
    var state = SortState.ascending
    
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
    
    // MARK: - Actions
    
    @IBAction func Sort(_ sender: UIBarButtonItem) {
        
        switch state {
            case SortState.ascending:
                loadTableView(false)
            case SortState.descending:
                loadTableView()
        }
    }
    
    // MARK: - Functions
    
    private func loadTableView(_ ascending: Bool = true) {
        if let items = dataManager.loadItems(ascending) {
            switch state {
                case SortState.ascending:
                        state = SortState.descending
                case SortState.descending:
                    state = SortState.ascending
            }
            self.items = items
            tableView.reloadData()
        }
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

