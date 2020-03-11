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
    @IBOutlet weak var searchBar: UITableView!
    
    enum SortState {
        case ascending
        case descending
    }
    
    var state = SortState.descending
    
    var dataManager: CoreDataManager {
        get {
            return CoreDataManager.shared
        }
    }
    
    var items: [Item]!
    var itemsFiltered: [Item]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loadTableView()
    }
    
    // MARK: - Actions
    
    @IBAction func Sort(_ sender: UIBarButtonItem) {
        
        switch state {
        case SortState.ascending:
            loadTableView(ascending: false)
        case SortState.descending:
            loadTableView()
        }
    }
    
    // MARK: - Functions
    
    private func loadTableView(ascending: Bool = true) {
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
        
        let item = items[indexPath.row]
        
        item.isFavorite = !item.isFavorite
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        let item = items[indexPath.row]
        cell.textLabel?.text = item.name
        
        if (item.isFavorite) {
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        } else {
            cell.accessoryType = UITableViewCell.AccessoryType.none
        }
        
        return cell
    }
}

extension ViewController: UISearchBarDelegate, UISearchDisplayDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if let items = dataManager.loadItemsWithFilter(filter: searchBar.text!) {
            self.items = items
            tableView.reloadData()
        }
    }
}

