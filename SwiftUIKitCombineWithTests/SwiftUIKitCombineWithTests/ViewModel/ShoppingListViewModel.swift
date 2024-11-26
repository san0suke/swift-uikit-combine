//
//  ShoppingListViewModel.swift
//  SwiftUIKitCombineWithTests
//
//  Created by Robson Cesar de Siqueira on 26/11/24.
//

import Combine

class ShoppingListViewModel {
    
    @Published private(set) var items: [ShoppingItem] = []
    
    private let shoppingItemManager: ShoppingItemManager
    private var cancellables = Set<AnyCancellable>()
    
    init(shoppingItemManager: ShoppingItemManager = ShoppingItemManager()) {
        self.shoppingItemManager = shoppingItemManager
        fetchAllItems()
    }
    
    func fetchAllItems() {
        items = shoppingItemManager.fetchAllItems()
    }
    
    func addOrUpdate(name: String, _ index: Int?) {
        if let index = index,
           items.indices.contains(index) {
            let item = items[index]
            
            if shoppingItemManager.updateItem(item: item, newName: name) {
                items[index].name = name
            }
        } else {
            if let item = shoppingItemManager.createItem(name: name) {
                items.append(item)
            }
        }
    }
    
    func delete(_ index: Int?) {
        if let index = index,
           items.indices.contains(index) {
            
            if shoppingItemManager.deleteItem(item: items[index]) {
                items.remove(at: index)
            }
        }
    }
}
