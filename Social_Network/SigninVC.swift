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
    
    
    
    
    
    
    
    
    

}

