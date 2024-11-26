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
        showAlert(nil)
    }
    
    private func showAlert(_ index: Int?) {
        let alert = UIAlertController(title: "Enter item name", message: nil, preferredStyle: .alert)
        
        alert.addTextField { [weak self] textField in
            textField.placeholder = "Name"
            
            if let index = index {
                textField.text = self?.itemsData[index]
            }
        }
        
        let submitAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            if let itemName = alert.textFields?.first?.text,
               !itemName.isEmpty {
                
                if let index = index {
                    self?.itemsData[index] = itemName
                } else {
                    self?.itemsData.append(itemName)
                }
                
                self?.shopTableView.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(submitAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    private func onTapTableLine(_ index: Int) {
        showAlert(index)
    }
}

extension ShoppingListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onTapTableLine(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completionHandler in
            self?.itemsData.remove(at: indexPath.row)

            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = .red
        deleteAction.image = UIImage(systemName: "trash")
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
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
