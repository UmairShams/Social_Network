//
//  PostCell.swift
//  Social_Network
//
//  Created by Umair Ahmad on 18/01/2017.
//  Copyright © 2017 Umair Ahmad. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    var post:Post!
    
    @IBOutlet weak var profileImage:UIImageView!
    @IBOutlet weak var usernameLbl:UILabel!
    @IBOutlet weak var postImage:UIImageView!
    @IBOutlet weak var caption:UITextView!
    @IBOutlet weak var likesLbl:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func ConfigureCell(post:Post){
        self.post = post
        self.caption.text = post.captian
        self.likesLbl.text = "\(post.likes)"
    }


}
