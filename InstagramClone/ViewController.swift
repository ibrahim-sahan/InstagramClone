//
//  ViewController.swift
//  InstagramClone
//
//  Created by İbrahim Şahan on 4.05.2024.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let authService = AuthenticationService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
    }
    
    @IBAction func signInClicked(_ sender: Any) {
        guard let email = emailText.text, let password = passwordText.text else {
            presentAlert(title: "Incomplete Information", message: "Please fill in both email and password fields.", actionTitle: "OK", actionHandler: nil)
            return
        }
        
        guard !email.isEmpty, !password.isEmpty else {
            presentAlert(title: "Incomplete Information", message: "Please fill in both email and password fields.", actionTitle: "OK", actionHandler: nil)
            return
        }
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        authService.signIn(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                
                switch result {
                case .success(_):
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                case .failure(let error):
                    self.presentAlert(title: "Error", message: "User information not found or incorrect: " + error.localizedDescription, actionTitle: "Try Again", actionHandler: nil)
                }
            }
        }
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        performSegue(withIdentifier: "toSignUpVC", sender: nil)
    }
}
