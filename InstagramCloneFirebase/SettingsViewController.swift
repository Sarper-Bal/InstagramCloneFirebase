//
//  SettingsViewController.swift
//  InstagramCloneFirebase
//
//  Created by Sarper Bal on 12.04.2023.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func loguthClicked(_ sender: Any) {
        do{
           try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toViewController", sender: nil)
        } catch {
            print("error")
        }
        
    }
    
}
