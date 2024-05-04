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

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func pageSignUpClicked(_ sender: Any) {
        
         if upEmailText.text == "" || upPasswordText.text == "" || upPasswordAgainText.text == "" {
             
             let emptyAlert = UIAlertController(title: "Incomplete Information", message: "Please fill in both email and password fields.", preferredStyle: UIAlertController.Style.alert)
             let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
             emptyAlert.addAction(okButton)
             self.present(emptyAlert, animated: true, completion: nil)
          
         } else if upPasswordText.text != upPasswordAgainText.text {
             
             let notMatchAlert = UIAlertController(title: "Passwords Mismatch", message: "Please make sure both passwords are the same.", preferredStyle: UIAlertController.Style.alert)
             let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
             notMatchAlert.addAction(okButton)
             self.present(notMatchAlert, animated: true, completion: nil)
             
         } else {
           
             Auth.auth().createUser(withEmail: upEmailText.text!, password: upPasswordText.text!) { (authData, error) in
                 
                 if error != nil {
                     
                 } else {
                     
                     let successAlert = UIAlertController(title: "Success!", message: "You have successfully logged in. Please return to the main page to log in again.", preferredStyle: UIAlertController.Style.alert)
                     let returnButton = UIAlertAction(title: "Return", style: .default) { (action) in
                         self.navigationController?.popViewController(animated: true)
                     }
                     successAlert.addAction(returnButton)
                     self.present(successAlert, animated: true, completion: nil)
                     
                 }
             }
         }
    }
}
