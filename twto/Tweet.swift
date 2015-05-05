//
//  Tweet.swift
//  twto
//
//  Created by Vaibhav Krishna on 5/3/15.
//  Copyright (c) 2015 Vaibhav Krishna. All rights reserved.
//

import UIKit


class Tweet: NSObject {
   
    var author : User?
    var text : String?
    var createdAtStr : String?
    var createdAt: NSDate?
    var ago: String?
    
    init(dictionary: NSDictionary){
        author = User(dict: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtStr = dictionary["created_at"] as? String
        var formatter = NSDateFormatter()
        formatter.dateFormat  = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtStr!)
        ago = NSDate.timeAgo(createdAt!)()
        
    }

    class func tweetsWithArr(twarray: NSArray) -> [Tweet]{
        var tws = [Tweet]()
        for tw in twarray{
            tws.append(Tweet(dictionary: tw as! NSDictionary))
        }
        return tws
    }
}
