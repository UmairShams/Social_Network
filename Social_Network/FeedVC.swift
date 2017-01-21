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

class FeedVC: UIViewController, UITableViewDelegate,UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var AddImage: CircleView!
    var posts = [Post]()
    var ImagePicker:UIImagePickerController!
    
    @IBOutlet weak var tableview:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        ImagePicker = UIImagePickerController()
        ImagePicker.allowsEditing = true
        ImagePicker.delegate = self
        
        
        
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot]{
                for snap in snapshots{
                    print("SNAP:\(snap)")
                    
                    if let postDict = snap.value as? Dictionary<String,AnyObject>{
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                        
                    }
                }
            }
            self.tableview.reloadData()
            
        })
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        if let cell = tableview.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell{
            cell.ConfigureCell(post: post)
            return cell
        }else{
            return PostCell()
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage{
            AddImage.image = image
        }else{
            print("A valid Image Wasn't selected")
        }
        ImagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func ImagePickerTapped(_ sender: Any) {
        present(ImagePicker, animated: true, completion: nil)
    }
    
    @IBAction func sigoutPressed(_ sender: Any) {
        let keychainResult = KeychainWrapper.standard.remove(key: Key_UID)
        print("ID removed from keyChain\(keychainResult)")
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: "goToSignin", sender: nil)
    }

}
