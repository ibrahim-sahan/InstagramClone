//
//  SignUpViewController.swift
//  InstagramClone
//
//  Created by İbrahim Şahan on 4.05.2024.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var upEmailText: UITextField!
    @IBOutlet weak var upPasswordText: UITextField!
    @IBOutlet weak var upPasswordAgainText: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let authService = AuthenticationService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
    }
    
    @IBAction func pageSignUpClicked(_ sender: Any) {
        guard let email = upEmailText.text, let password = upPasswordText.text, let passwordAgain = upPasswordAgainText.text else {
            presentAlert(title: "Incomplete Information", message: "Please fill in both email and password fields.", actionTitle: "OK", actionHandler: nil)
            return
        }
        
        guard !email.isEmpty, !password.isEmpty, !passwordAgain.isEmpty else {
            presentAlert(title: "Incomplete Information", message: "Please fill in both email and password fields.", actionTitle: "OK", actionHandler: nil)
            return
        }
        
        guard password == passwordAgain else {
            presentAlert(title: "Passwords Mismatch", message: "Please make sure both passwords are the same.", actionTitle: "OK", actionHandler: nil)
            return
        }
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        authService.signUp(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                
                switch result {
                case .success(_):
                    self.presentAlert(title: "Success!", message: "You have successfully registered. Please log in with your new account.", actionTitle: "OK") {
                        self.navigationController?.popViewController(animated: true)
                    }
                case .failure(let error):
                    self.presentAlert(title: "Error", message: "Error creating user: " + error.localizedDescription, actionTitle: "Try Again", actionHandler: nil)
                }
            }
        }
    }
}
