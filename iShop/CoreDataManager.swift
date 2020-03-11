//
//  CoreDataManager.swift
//  iShop
//
//  Created by lpiem on 11/03/2020.
//  Copyright © 2020 lpiem. All rights reserved.
//

import CoreData

class CoreDataManager{
    
    static let shared = CoreDataManager()
    
    var context: NSManagedObjectContext {
        get {
            return persistentContainer.viewContext
        }
    }
    
    init() {
        
        createRandomItems()
    }
    
    // MARK: - Items Manager
    
    func createRandomItems() {
        
        if let items = loadItems(), items.count == 0 {
        
            let randomData = ["Veste", "Chaussures", "Pantalon", "Slip"]
            
            for name in randomData {
                
                let _ = createItemWithName(name, price: 0.0)
            }
            
            saveContext()
        }
    }
    
    func createItemWithName(_ name: String, price: Double) -> Item {
        
        let item = Item(context: context)
        item.name = name
        item.price = price
        return item
    }
    
    func loadItems(_ ascending: Bool = true) -> [Item]? {
        
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: ascending)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            return nil
        }
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "iShop")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

