//
//  AuthViewModel.swift
//  Notes
//
//  Created by Shirley Averette on 6/11/24.
//

import Foundation
import FirebaseAuth
import SwiftUI

class AuthViewModel : ObservableObject {
    
    @Published var session: User? = nil
    
    init() {
        // Initilaize user with the currently signed on user if there is one.
        // This is a safe call, so it cannot fail and break the program
        // @return - Returns a user or nil of value User?
        self.session = Auth.auth().currentUser
        Auth.auth().addStateDidChangeListener { auth, user in
            // update user property when the sign in state changes
            self.session = user
        }
    }
    
    
    func RegisterUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Registration Error: \(error.localizedDescription)")
                return
            }
            // Assign user
            self.session = authResult?.user
            // Navigate to new view
        }
    }
    
    func SignIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
            // sign in user
            self?.session = authResult?.user
        }
    }
    
    func SignOut() {
        do {
            try Auth.auth().signOut()
            self.session = nil
        } catch let error {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
    
    func isValidEmail(email : String) -> Bool {
        let emailRegexPattern = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegexPattern)
        
        
        return emailPredicate.evaluate(with: email)
    }
    
    func isValidPassword(password: String) -> Bool {
    
        // Minimum 8 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet and 1 Number
        let passwordRegexPattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d\\$@\\$!%*?&#])[A-Za-z\\d\\$@\\$!%*?&#]{8,}"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegexPattern)
        
        return passwordPredicate.evaluate(with: password)
    }
    
    func validateBoth(email: Bool, password: Bool) -> String {
        if !email {return "Invalid email Address"}
        
        if !password {return "Invalid password, please use 1 uppercase, 1 lowercase, 1 number, 1 special character required"}
        return "SignUpView()"
    }
    
    
}
