//
//  SettingsViewController.swift
//  InstagramClone
//
//  Created by İbrahim Şahan on 4.05.2024.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logOutClicked(_ sender: Any) {
        performSegue(withIdentifier: "toViewController", sender: nil)
    }
    
}
