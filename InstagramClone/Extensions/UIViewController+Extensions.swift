//
//  UIViewController+Extensions.swift
//  InstagramClone
//
//  Created by İbrahim Şahan on 6.05.2024.
//

import UIKit

extension UIViewController {
    func presentAlert(title: String, message: String, actionTitle: String, actionHandler: (() -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default) { _ in
            actionHandler?()
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
}
