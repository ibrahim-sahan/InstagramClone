//
//  SettingsViewController.swift
//  InstagramClone
//
//  Created by İbrahim Şahan on 4.05.2024.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let authService = AuthenticationService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logOutClicked(_ sender: Any) {
        authService.signOut { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success():
                self.presentAlert(title: "Signed Out", message: "You have been successfully signed out.", actionTitle: "OK") {
                    self.performSegue(withIdentifier: "toViewController", sender: nil)
                }
            case .failure(let error):
                self.presentAlert(title: "Error", message: "Failed to sign out: \(error.localizedDescription)", actionTitle: "OK", actionHandler: nil)
            }
        }
    }
}
