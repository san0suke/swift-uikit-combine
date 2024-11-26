//
//  ViewController.swift
//  SwiftUIKitCombineWithTests
//
//  Created by Robson Cesar de Siqueira on 26/11/24.
//

import UIKit

class MainViewController: UIViewController {
    
    var shoppingListButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        
        var configuration = UIButton.Configuration.filled()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = .systemBlue
        
        button.configuration = configuration
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
    }

    private func setupUI() {
        view.backgroundColor = .white
        
        shoppingListButton.setTitle("Shopping list: #", for: .normal)
        
        view.addSubview(shoppingListButton)
        
        NSLayoutConstraint.activate([
            shoppingListButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shoppingListButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        shoppingListButton.addTarget(self, action: #selector(goToShoppingList), for: .touchUpInside)
    }

    private func setupBindings() {
        
    }
    
    @objc private func goToShoppingList() {
        let viewController = ShoppingListViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
