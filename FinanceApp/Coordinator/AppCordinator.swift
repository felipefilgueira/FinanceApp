//
//  AppCordinator.swift
//  FinanceApp
//
//  Created by Felipe Filgueira on 21/09/25.
//

import UIKit

final class AppCoordinator: Coordinator {
    var navigation: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func start() {
        let vc = TransactionsListViewController()
        navigation.setViewControllers([vc], animated: false)

    }
}
