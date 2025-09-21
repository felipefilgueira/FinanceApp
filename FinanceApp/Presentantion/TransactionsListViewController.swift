//
//  TransactionsListViewController.swift
//  FinanceApp
//
//  Created by Felipe Filgueira on 21/09/25.
//

import UIKit

final class TransactionsListViewController: UITableViewController {
    
    private var items: [String] = ["Mercado - R$ 120,00", "Salário - R$ 5.000,00", "Uber - R$ 28,90"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Transações"
        view.backgroundColor = .systemBackground
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didTapAdd)
        )
    }
    
    @objc private func didTapAdd() {
        let alert = UIAlertController(title: "Novo",
                                      message: "Aqui vai abrir a criação de transações",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    //MARK: UITableView DataSource
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
