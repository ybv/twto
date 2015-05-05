//
//  ComposerViewController.swift
//  twto
//
//  Created by Vaibhav Krishna on 5/5/15.
//  Copyright (c) 2015 Vaibhav Krishna. All rights reserved.
//

import UIKit

class ComposerViewController: UIViewController {

    //@IBOutlet weak var ttextView: UITextView!
    
    @IBAction func onTw(sender: AnyObject) {
        
//        let tw:[String:String] = ["status": ttextView.text ]
//        TwitterClient.sharedInstance.postTweet(tw, completion: { (resp, err) -> () in
//            println(resp)
//        } )
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func onCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}

}


