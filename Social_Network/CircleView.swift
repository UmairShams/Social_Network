//
//  CircleView.swift
//  Social_Network
//
//  Created by Umair Ahmad on 18/01/2017.
//  Copyright © 2017 Umair Ahmad. All rights reserved.
//

import UIKit

class CircleView: UIImageView {
    
    override func layoutSubviews() {
        layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true
    }

}
