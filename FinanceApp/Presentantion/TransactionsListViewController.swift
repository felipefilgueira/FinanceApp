//
//  TransactionsListViewController.swift
//  FinanceApp
//
//  Created by Felipe Filgueira on 21/09/25.
//

import UIKit

final class TransactionsListViewController: UITableViewController {
    
    private var items: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureTable()
        configureNavigation()
        loadInitialValues()
    }
    
    private func configureUI() {
        title = "Transações"
        view.backgroundColor = .systemBackground
    }
    
    private func configureNavigation() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didTapAdd)
        )
    }
    
    private func configureTable() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func loadInitialValues() {
        items = ["Mercado - R$ 120,00", "Salário - R$ 5.000,00", "Uber - R$ 28,90"]
        tableView.reloadData()
    }
    
    @objc private func didTapAdd() {
        let form = EditTransactionViewController()
        form.onSave = { newItem in
            self.items.insert(newItem, at: 0)
            self.tableView.reloadData()
            self.navigationController?.popViewController(animated: true)
        }
        
        form.onCancel = {
            self.navigationController?.popViewController(animated: true)
        }
        
        navigationController?.pushViewController(form, animated: true)
    }
}

//MARK: UITableViewDataSource
extension TransactionsListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var cfg = cell.defaultContentConfiguration()
        cfg.text = items[indexPath.row]
        cell.contentConfiguration = cfg
        return cell
    }
}

//MARK: UITableViewDelegate
extension TransactionsListViewController {
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Excluir") {
            [weak self] (_, _, completionHandler) in
            self?.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
