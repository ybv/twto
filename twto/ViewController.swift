//
//  ViewController.swift
//  twto
//
//  Created by Vaibhav Krishna on 5/2/15.
//  Copyright (c) 2015 Vaibhav Krishna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(sender: AnyObject) {
        TwitterClient.sharedInstance.loginWithCompletion(){
            (user: User? , err : NSError?) in
            if user != nil {
        self.performSegueWithIdentifier("loginSegue", sender: self)
                
            }
            else{
                //login err
            }
        }
    }

}

