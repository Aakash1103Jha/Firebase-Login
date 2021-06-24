//
//  RegisterViewController.swift
//  Firebase-Login
//
//  Created by Aakash Jha on 22/06/21.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class RegisterViewController: UIViewController {

    @IBOutlet weak var regFirstNameField: UITextField!
    @IBOutlet weak var regLastNameField: UITextField!
    @IBOutlet weak var regEmailField: UITextField!
    @IBOutlet weak var regPasswordField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var errorField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // hide error message on load
        errorField.alpha = 0
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Validations
    // show error message
    func showError(_ message: String) {
        errorField.text = message
        errorField.alpha = 1
    }
    // validate fields
    func checkFields() -> String? {
        // check if fields are filled
        if (regFirstNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            regLastNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            regEmailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            regPasswordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "") {
            return "Please fill in all fields"
        }
        //TODO: -Implement RegEx for password validation
        // check if password is valid
//        let cleanPassword = regPasswordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//        if Utilities.isPasswordValid(cleanPassword) == false {
//            return "Password must contain at least 8 characters, one uppercase, one nuber and a special character."
//        }
        return nil
    }
    
    //MARK: - Transition
    func transitionToHome() {
        let HomeVC = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        view.window?.rootViewController = HomeVC
        view.window?.makeKeyAndVisible()
    }
    
    func transitionToLogin() {
        let LoginVC = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.loginViewController) as? LoginViewController
        view.window?.rootViewController = LoginVC
        view.window?.makeKeyAndVisible()
    }
    
    //MARK: - User Action
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        // validate fields
        let error = checkFields()
        if error != nil {
            showError(error!)
        } else {
            // clean input data
            let firstName = self.regFirstNameField.text!.trimmingCharacters(in: .whitespacesAndNewlines),
                lastName = self.regLastNameField.text!.trimmingCharacters(in: .whitespacesAndNewlines),
                email = self.regEmailField.text!.trimmingCharacters(in: .whitespacesAndNewlines),
                password = self.regPasswordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // create a new user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                // check for error whicle creating a new user
                if err != nil {
                    self.showError("Something went wrong while creating a new user :(")
                } else {
                    // finally create user
                    let db = Firestore.firestore()
                    if let results = result {
                        db.collection("users").addDocument(data: ["fname": firstName, "lname": lastName, "uid": results.user.uid]) {error in
                            if error != nil {
                                self.showError("User data could not be saved :(")
                            }
                        }
                    }
                    
                    // transition to homepage
                    self.transitionToLogin()
                    
                    }
                }
            }
        }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
