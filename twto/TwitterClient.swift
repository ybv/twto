//
//  TwitterClient.swift
//  twto
//
//  Created by Vaibhav Krishna on 5/2/15.
//  Copyright (c) 2015 Vaibhav Krishna. All rights reserved.
//

import UIKit

let twConsumerKey = "SlQadflkj9ei7Ket1sdfsdfsdfeeMzicaXsdfdf67lsfGyw1"
let twConsumerSecret = "zw2RL7Cn1dsfdsfXLlQgBOn5RofGTTsdfsdfsdfS2Ck3nzGEwj'sdkfcNP0OSjVUN5UXgsSq"
let twBaseUrl = NSURL(string: "https://api.twitter.com")



class TwitterClient: BDBOAuth1RequestOperationManager {
    
    var loginCompletion : ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance : TwitterClient {
        struct Static{
            static let instance = TwitterClient(baseURL: twBaseUrl,
                consumerKey: twConsumerKey, consumerSecret: twConsumerSecret)
        }
        
        return Static.instance
    }
    
    func homeTimeLine(params: NSDictionary?, completion: (tweets: [Tweet]?, err: NSError?) -> () ) {
        GET("1.1/statuses/home_timeline.json", parameters: params,
            success: { (operation: AFHTTPRequestOperation!, resp: AnyObject!) -> Void in
                println(resp)
                var tws = Tweet.tweetsWithArr(resp as! [NSDictionary])
                completion(tweets: tws, err: nil)
            },
            failure: { (operation: AFHTTPRequestOperation!, err: NSError!) -> Void in
                println(err)
                completion(tweets: nil, err: err)
        })
    }
    
    func postTweet(params: NSDictionary?, completion: (resp: AnyObject?, err: NSError?) -> () ){
        
        POST("1.1/statuses/update.json", parameters: params,
            success: { (operation: AFHTTPRequestOperation!, resp: AnyObject!) -> Void in
                println(resp)
 
            },
            failure: { (operation: AFHTTPRequestOperation!, err: NSError!) -> Void in
                println(err)
        })
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()){
        loginCompletion = completion
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "ybvcp://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            var authUrl = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authUrl!)
            println("GOTtoken, \(requestToken)")
            }) { (error: NSError!) -> Void in
                println("error \(error)")
                self.loginCompletion?(user: nil, error: error)
        }

    }

    func openUrl(url: NSURL){
        
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query),
            
            success: { (accessToken :BDBOAuth1Credential!) -> Void in
                println("Got access token")
                TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
                
                TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil,
                    success: { (operation: AFHTTPRequestOperation!, resp: AnyObject!) -> Void in
                        println(resp)
                        var user = User(dict: resp as! NSDictionary)
                        User.currentUser = user
                        self.loginCompletion?(user: user, error: nil)
                    },
                    failure: { (operation: AFHTTPRequestOperation!, err: NSError!) -> Void in
                        println(err)
                        self.loginCompletion?(user: nil, error: err)
                })
                
            })
            {
                (err : NSError!) -> Void in
                println("err while getting access token")
                self.loginCompletion?(user: nil, error: err)
        }

        
    }
}
