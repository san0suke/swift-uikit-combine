//
//  ShoppingListViewController.swift
//  SwiftUIKitCombineWithTests
//
//  Created by Robson Cesar de Siqueira on 26/11/24.
//

import UIKit

class ShoppingListViewController: UIViewController {
    
    let cellKey = "cell"
    
    private let shopTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        title = "Shopping List"
        
        view.addSubview(shopTableView)
        
        NSLayoutConstraint.activate([
            shopTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            shopTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            shopTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            shopTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        shopTableView.dataSource = self
        shopTableView.delegate = self
        shopTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellKey)
    }
}

extension ShoppingListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

extension ShoppingListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
