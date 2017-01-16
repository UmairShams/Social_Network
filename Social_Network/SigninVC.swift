//
//  SigninVC.swift
//  Social_Network
//
//  Created by Umair Ahmad on 14/01/2017.
//  Copyright © 2017 Umair Ahmad. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

class SigninVC: UIViewController {
    
    
    @IBOutlet weak var emailField: FancyField!
    

    @IBOutlet weak var PasswordField: FancyField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    @IBAction func facebookbtnPressed(_ sender: Any) {
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, err) in
            
            if err != nil{
                print("Failed to login with facebook... \(err)")
            }else if result?.isCancelled == true{
                print("User cancelled the facebook authentication :(")
            }else{
                print("Successfully login with facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.FirebaseAuth(credential)
            }
            
        }
    }
    
    func FirebaseAuth(_ credential:FIRAuthCredential){
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil{
                print("Oh...Unable to Authenticate with Firebase")
            }
            print("Successfully Authentication with Firebase Login")
            
            
        })
        
    }
    
    
    
    @IBAction func signInPressed(_ sender: Any) {
        
        if let email = emailField.text, let password = PasswordField.text{
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, err) in
                if err == nil {
                    print("Email User Authenticated with Firebase")
                }else{
                    FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, err) in
                        if err != nil{
                            print(":( Failed to Authenticate with Firebase using email")
                        }else{
                            print("Successfully Authenticated with Firebase")
                        }
                        
                    })
                }
                
            })
        }
    }
    
    
    
    
    
    

}

