//
//  FeedVC.swift
//  Social_Network
//
//  Created by Umair Ahmad on 17/01/2017.
//  Copyright © 2017 Umair Ahmad. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func sigoutPressed(_ sender: Any) {
        let keychainResult = KeychainWrapper.standard.remove(key: Key_UID)
        print("ID removed from keyChain\(keychainResult)")
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: "goToSignin", sender: nil)
    }

}
