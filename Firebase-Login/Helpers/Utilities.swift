//
//  Utilities.swift
//  Firebase-Login
//
//  Created by Aakash Jha on 22/06/21.
//

import Foundation
import UIKit

// regex for password validation: "^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$"
class Utilities {

    static func isPasswordValid(_ password: String) -> Bool {
        // return error message if password is not valid
//        let password = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}$")
        let password = NSPredicate(format: "SELF MATCHES %@", "^{8,}$")
        return password.evaluate(with: password)
    }

}
