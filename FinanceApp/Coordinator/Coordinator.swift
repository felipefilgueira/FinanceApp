//
//  Coordinator.swift
//  FinanceApp
//
//  Created by Felipe Filgueira on 21/09/25.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigation: UINavigationController { get }
    func start()
}
