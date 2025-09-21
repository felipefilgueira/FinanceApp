//
//  EditTransactionViewController.swift
//  FinanceApp
//
//  Created by Felipe Filgueira on 21/09/25.
//

import UIKit

final class EditTransactionViewController: UIViewController {
    
    var onSave: ((TransactionItem) -> Void)?
    var onCancel: (() -> Void)?
    
    private let amountField = UITextField()
    private let noteField = UITextField()
    private let typeControl = UISegmentedControl(items: ["Despesa", "Receita"])
    private let datePicker = UIDatePicker()
    private let stack = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNavigation()
        configureFields()
        layout()
    }
    
    private func configureUI() {
        title = "Nova Transação"
        view.backgroundColor = .systemBackground
    }
    
    private func configureNavigation() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Salvar",
                                                            style: .prominent,
                                                            target: self,
                                                            action: #selector(didTapSave))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancelar",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(didTapCancel))
    }
    
    private func configureFields() {
        amountField.placeholder = "Valor (ex 200.0)"
        amountField.keyboardType = .numberPad
        amountField.borderStyle = .roundedRect
        
        noteField.placeholder = "Nota (ex: Mercado, Uber...)"
        noteField.borderStyle = .roundedRect
        
        typeControl.selectedSegmentIndex = 0
        
        datePicker.date = .now
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.addArrangedSubview(amountField)
        stack.addArrangedSubview(noteField)
        stack.addArrangedSubview(typeControl)
        stack.addArrangedSubview(datePicker)
    }
    
    private func layout() {
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
    }
    
    // MARK: Actions
    @objc private func didTapSave() {
        let valuesText = amountField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard let amount = Decimal(string: valuesText) else { return presentAlert("Informe um valor") }
        
        let noteText = noteField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard !noteText.isEmpty else { return presentAlert("Informe o nome da transação") }

        let kind = TransactionKind(rawValue: typeControl.selectedSegmentIndex) ?? .expense
        let item = TransactionItem(amount: amount,
                                   note: noteText,
                                   date: datePicker.date,
                                   kind: kind)
        
        onSave?(item)
    }
    
    @objc private func didTapCancel() { onCancel?() }
    
    // MARK: Helpers
    
    private func presentAlert(_ message: String) {
        let alert = UIAlertController(title: "Atenção", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
