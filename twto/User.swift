//
//  User.swift
//  twto
//
//  Created by Vaibhav Krishna on 5/3/15.
//  Copyright (c) 2015 Vaibhav Krishna. All rights reserved.
//

import UIKit

var _cu : User?
let cuKey = "twcuKey"
let udloginn = "udloginn"
let udlogoutn = "udloginn"

class User: NSObject {
    var name: String?
    var screenName: String?
    var profileImgUrl: String?
    var tagline: String?
    var dict: NSDictionary?
    
    init(dict: NSDictionary){
        self.dict = dict 
        name = dict["name"] as? String
        screenName = dict["screen_name"] as? String
        if let img_url = dict["profile_image_url"]{
            profileImgUrl = img_url as! String 
        }else{
            profileImgUrl = "https://abs.twimg.com/sticky/default_profile_images/default_profile_2_400x400.png"
        }
        tagline = dict["description"] as? String
    }
    func logOut(){
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        NSNotificationCenter.defaultCenter().postNotificationName(udlogoutn, object: nil)
    }
    
    class var currentUser: User?{
        get{
            if _cu == nil{
                var data = NSUserDefaults.standardUserDefaults().objectForKey(cuKey) as? NSData
                if data != nil{
                    var dict = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as! NSDictionary
                    _cu = User(dict: dict)
                }
            }
            return _cu
        }
        set(user){
            _cu = user
            if _cu != nil{
                var data = NSJSONSerialization.dataWithJSONObject(user!.dict!, options: nil, error: nil)
                NSUserDefaults.standardUserDefaults().setObject(data , forKey: cuKey)
            }
            else{
                 NSUserDefaults.standardUserDefaults().setObject(nil , forKey: cuKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}
