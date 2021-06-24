//
//  HomeViewController.swift
//  Firebase-Login
//
//  Created by Aakash Jha on 22/06/21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class HomeViewController: UIViewController {

    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var userEmailField: UITextField!
    
    let db = Firestore.firestore()
    let loggedUser = Auth.auth().currentUser

    
    func getUserDetails() {
        // get user uid
        if let LoggedUser = loggedUser {
            let uid = LoggedUser.uid
            print(uid)
            
            // get details from USERS collection for uid
            db.collection("users").whereField("uid", isEqualTo: uid).getDocuments { querySnapshot, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    if let snapshot = querySnapshot {
                        let documents = snapshot.documents
                        for doc in documents {
                            let userData = doc.data()   // holds document related to uid
                            print(userData)
                            if let fname = userData["fname"], let lname = userData["lname"], let email = LoggedUser.email {
                                self.firstNameField.text = fname as? String
                                self.lastNameField.text = lname as? String
                                self.userEmailField.text = email
                            } else {
                                print("Data not found")     // error message if userData is nil
                            }
                        }
                    } else {
                        print("Nothing could be found for the user")    // error message if snapshot is nil
                    }
                }
            }
        } else {
            print("User could not be found")    // error message if LoggedUser is nil
        }
    }
    
    func transitionToLogin() {
        let LoginVC = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.loginViewController) as? LoginViewController
        view.window?.rootViewController = LoginVC
        view.window?.makeKeyAndVisible()
    }
    
    @objc func signoutUser() {
        do {
            try Auth.auth().signOut()
            self.transitionToLogin()
            
        } catch {
            print("Could not sign out")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get details from user collection for logged in user based on uid
        getUserDetails()
        
        // embed in NavigationController
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(signoutUser))
        navigationItem.title = "My Profile"
        
    }
    
   
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        self.signoutUser()
    }
    
    
    
}
