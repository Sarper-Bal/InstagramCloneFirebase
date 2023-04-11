//
//  ViewController.swift
//  InstagramCloneFirebase
//
//  Created by Sarper Bal on 11.04.2023.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }

    @IBAction func signInClick(_ sender: Any) {
        
        if emailText.text != "" && passwordText.text != "" {
            
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { authdata, error in
                if error != nil {
                    self.makeAlert(titleI: "Error", messageI: error?.localizedDescription ?? "Error")

                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        } else {
            makeAlert(titleI: "error", messageI: "usarname/password")
        }
        
    }
    
    @IBAction func signUpClik(_ sender: Any) {
        
        if emailText.text != "" && passwordText.text != "" {
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { authdata, error in
               
                if error != nil {
                    self.makeAlert(titleI: "Error", messageI: error?.localizedDescription ?? "Error")
                }else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        }else {
            makeAlert(titleI: "Error", messageI: "Usarname/Password")
        }
        
        
    }
    func makeAlert(titleI : String, messageI : String) {
        let alert = UIAlertController(title: titleI, message: messageI, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title:  "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
}

