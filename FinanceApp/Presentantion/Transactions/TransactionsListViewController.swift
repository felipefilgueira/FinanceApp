//
//  TransactionsListViewController.swift
//  FinanceApp
//
//  Created by Felipe Filgueira on 21/09/25.
//

import UIKit

final class TransactionsListViewController: UITableViewController {
    
    private var items: [TransactionItem] = []

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
        let item1 = TransactionItem(amount: 100, note: "Mercado", date: Date.now, kind: .expense)
        let item2 = TransactionItem(amount: 10, note: "Uber", date: Date.now, kind: .expense)
        let item3 = TransactionItem(amount: 5000, note: "Salario", date: Date.now - 10, kind: .income)
        items.append(item1)
        items.append(item2)
        items.append(item3)
        tableView.reloadData()
    }
    
    @objc private func didTapAdd() {
        let form = EditTransactionViewController()
        form.onSave = { [weak self] newItem in
            guard let self else { return }
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
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var cfg = cell.defaultContentConfiguration()
        
        cfg.text = item.note.isEmpty ? (item.kind == .income ? "Receita" : "Despesa") : item.note
        
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .none
        
        cfg.secondaryText = df.string(from: item.date)

        let nf = NumberFormatter(); nf.numberStyle = .currency; nf.locale = Locale(identifier: "pt_BR")
        let amountLabel = UILabel()
        amountLabel.text = nf.string(from: item.amount as NSDecimalNumber) ?? "—"
        amountLabel.textAlignment = .right
        amountLabel.font = .preferredFont(forTextStyle: .body)
        amountLabel.setContentHuggingPriority(.required, for: .horizontal)
        amountLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        amountLabel.textColor = (item.kind == .income) ? .systemGreen : .label

        amountLabel.sizeToFit()
        cell.accessoryView = amountLabel
        
        cfg.textProperties.color = (item.kind == .income) ? .label : .label
        cell.contentConfiguration = cfg
        cell.accessoryType = .disclosureIndicator
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
