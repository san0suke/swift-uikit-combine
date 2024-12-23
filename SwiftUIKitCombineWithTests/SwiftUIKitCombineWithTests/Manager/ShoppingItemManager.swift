//
//  ShoppingItemManager.swift
//  SwiftUIKitCombineWithTests
//
//  Created by Robson Cesar de Siqueira on 26/11/24.
//

import CoreData
import UIKit
import Combine

class ShoppingItemManager {

    static var shared: ShoppingItemManager = ShoppingItemManager()
    
    private let context: NSManagedObjectContext
    
    private var saveCompletedSubject = PassthroughSubject<Void, Never>()
    var saveCompletedPublisher: AnyPublisher<Void, Never> {
        saveCompletedSubject.eraseToAnyPublisher()
    }
    
    private init(context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext) {
        self.context = context
    }
    
    // MARK: - CRUD Operations
    
    func createItem(name: String) -> ShoppingItem? {
        let newItem = ShoppingItem(context: context)
        newItem.id = UUID()
        newItem.name = name
        
        do {
            try context.save()
            saveCompletedSubject.send(())
            
            return newItem
        } catch {
            print("Failed to create item: \(error)")
            return nil
        }
    }
    
    func fetchAllItems() -> [ShoppingItem] {
        let fetchRequest: NSFetchRequest<ShoppingItem> = ShoppingItem.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch items: \(error)")
            return []
        }
    }
    
    func updateItem(item: ShoppingItem, newName: String) -> Bool {
        item.name = newName
        
        do {
            try context.save()
            saveCompletedSubject.send(())
            
            return true
        } catch {
            print("Failed to update item: \(error)")
            return false
        }
    }
    
    func deleteItem(item: ShoppingItem) -> Bool {
        context.delete(item)
        
        do {
            try context.save()
            saveCompletedSubject.send(())
            
            return true
        } catch {
            print("Failed to delete item: \(error)")
            return false
        }
    }
}
