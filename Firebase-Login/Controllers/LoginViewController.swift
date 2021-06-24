//
//  LoginViewController.swift
//  Firebase-Login
//
//  Created by Aakash Jha on 22/06/21.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class LoginViewController: UIViewController {

    @IBOutlet weak var loginEmailField: UITextField!
    @IBOutlet weak var loginPasswordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
    }
    //MARK: - Validation
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func checkFields() -> String? {
        // check if email and password exists
        if (loginEmailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                loginPasswordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "") {
            return "Please fill in all fields"
        }
        return nil
    }
    
    //MARK: - Transition to Homepage
    func transitionToHome() {
        let HomeVC = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        if let homeVC = HomeVC {
            let navigationController = UINavigationController(rootViewController: homeVC)
            view.window?.rootViewController = navigationController
            view.window?.makeKeyAndVisible()
        }
        
       
    }

    //MARK: - User Action - Login
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        // validate text fields
        let error = checkFields()
        if error != nil {
            showError(error!)
        } else {
            // clean user input
            let email = self.loginEmailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = self.loginPasswordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // signing in the user
            Auth.auth().signIn(withEmail: email, password: password) { result, err in
                if err != nil {
                    self.showError(err!.localizedDescription)
                } else {
                    //finally login user
                    self.transitionToHome()
                }
            }
        }
        
    }
    

}
