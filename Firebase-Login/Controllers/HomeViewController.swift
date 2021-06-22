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

    override func viewDidLoad() {
        super.viewDidLoad()
        getUserDetails()
    }

    func getUserDetails() {
        let db = Firestore.firestore()
        db.collection("users").getDocuments() { result, err in
            if err != nil {
                print(err!.localizedDescription)
            } else {
                if let result = result {
                    for document in result.documents {
                        print("\(document.documentID) => \(document.data().keys)")
                    }
                }
            }
        }
    }
    
}
