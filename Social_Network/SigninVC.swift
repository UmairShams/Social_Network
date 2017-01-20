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
import SwiftKeychainWrapper

class SigninVC: UIViewController {
    
    
    @IBOutlet weak var emailField: FancyField!
    

    @IBOutlet weak var PasswordField: FancyField!
    override func viewDidLoad() {
        super.viewDidLoad()
        }
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: Key_UID){
            print("Id found in keychain")
            performSegue(withIdentifier: "goToFeed", sender: nil)
    }
        
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
            
            if let user = user{
                let userData = ["provider":credential.provider]
                self.CompleteSignIn(id: user.uid, userData:userData)
            }
            
            
            
        })
        
    }
    
    
    
    @IBAction func signInPressed(_ sender: Any) {
        
        if let email = emailField.text, let password = PasswordField.text{
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, err) in
                if err == nil {
                    print("Email User Authenticated with Firebase")
                    if let user = user{
                        let userData = ["privider":user.providerID]
                        self.CompleteSignIn(id:user.uid, userData: userData)
                    }
                    
                }else{
                    FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, err) in
                        if err != nil{
                            print(":( Failed to Authenticate with Firebase using email")
                        }else{
                            print("Successfully Authenticated with Firebase")
                            if let user = user{
                                let userData = ["provider":user.providerID]
                                 self.CompleteSignIn(id:user.uid,userData: userData)
                            }
                           
                        }
                        
                    })
                }
                
            })
        }
    }
    
    
    func CompleteSignIn(id:String, userData: Dictionary<String,String>){
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        let keychainResult = KeychainWrapper.standard.set(id, forKey: Key_UID)
        print("Data saved to key chain \(keychainResult)")
        performSegue(withIdentifier: "goToFeed", sender: nil)
    }
    
    
    
    
    

}

