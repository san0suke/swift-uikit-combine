//
//  ShoppingListViewController.swift
//  SwiftUIKitCombineWithTests
//
//  Created by Robson Cesar de Siqueira on 26/11/24.
//

import UIKit

class ShoppingListViewController: UIViewController {
    
    let cellKey = "cell"
    
    var itemsData: [String] = []
    
    private let shopTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        title = "Shopping List"
        
        view.addSubview(shopTableView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(onTapAddButton)
        )
        
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
    
    @objc private func onTapAddButton() {
        let alert = UIAlertController(title: "Enter item name", message: nil, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Name"
        }
        
        let submitAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            if let itemName = alert.textFields?.first?.text,
               !itemName.isEmpty {
                self?.itemsData.append(itemName)
                self?.shopTableView.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(submitAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}

extension ShoppingListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

extension ShoppingListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = shopTableView.dequeueReusableCell(withIdentifier: cellKey, for: indexPath)
        cell.textLabel?.text = itemsData[indexPath.row]
        
        return cell
    }
}
