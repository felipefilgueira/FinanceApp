//
//  TransactionItens.swift
//  FinanceApp
//
//  Created by Felipe Filgueira on 21/09/25.
//

import Foundation

enum TransactionKind: Int { case expense = 0, income = 1}

struct TransactionItem {
    let amount: Decimal
    let note: String
    let date: Date
    let kind: TransactionKind
}
