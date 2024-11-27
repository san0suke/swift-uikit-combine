//
//  MainViewModel.swift
//  SwiftUIKitCombineWithTests
//
//  Created by Robson Cesar de Siqueira on 26/11/24.
//

import Combine
import UIKit

class MainViewModel {
    
    @Published var shoppingItemCount: Int = 0
    
    private let shoppingItemManager: ShoppingItemManager
    private var cancellables = Set<AnyCancellable>()
    
    init(shoppingItemManager: ShoppingItemManager = .shared) {
        self.shoppingItemManager = shoppingItemManager
        self.shoppingItemCount = shoppingItemManager.fetchAllItems().count
        setupBindings()
    }
    
    func setupBindings() {
        shoppingItemManager.saveCompletedPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.shoppingItemCount = self?.shoppingItemManager.fetchAllItems().count ?? 0
            }
            .store(in: &cancellables)
    }
}
