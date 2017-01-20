//
//  Post.swift
//  Social_Network
//
//  Created by Umair Ahmad on 21/01/2017.
//  Copyright © 2017 Umair Ahmad. All rights reserved.
//

import Foundation

class Post{
    
    private var _captian:String!
    private var _ImageUrl:String!
    private var _likes:Int!
    private var _postKey:String!
    
    
    var captian:String{
        return _captian
    }
    var ImageUrl:String{
        return _ImageUrl
    }
    var likes:Int{
        return _likes
    }
    var postKey:String{
        return _postKey
    }
    init(captian:String,ImageUrl:String,likes:Int){
        self._captian = captian
        self._ImageUrl = ImageUrl
        self._likes = likes
    }
    init(postKey:String,postData:Dictionary<String,AnyObject>){
        self._postKey = postKey
        
        if let captian = postData["captian"] as? String{
            self._captian = captian
        }
        if let ImageUrl = postData["ImageUrl"] as? String{
            self._ImageUrl = ImageUrl
        }
        if let likes = postData["likes"] as? Int{
            self._likes = likes
        }
        
    }
}
