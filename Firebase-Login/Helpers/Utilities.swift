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
//        let format = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
//        let format = "^.{8,}$"
        let format = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z]).{8,}$")
        return format.evaluate(with: password)
    }
}
