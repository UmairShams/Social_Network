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

class FeedVC: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableview:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableview.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
    }
    
    @IBAction func sigoutPressed(_ sender: Any) {
        let keychainResult = KeychainWrapper.standard.remove(key: Key_UID)
        print("ID removed from keyChain\(keychainResult)")
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: "goToSignin", sender: nil)
    }

}
