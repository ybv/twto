//
//  TweetDetailViewController.swift
//  twto
//
//  Created by Vaibhav Krishna on 5/4/15.
//  Copyright (c) 2015 Vaibhav Krishna. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {

    @IBOutlet weak var twimg: UIImageView!
    @IBOutlet weak var twscreen: UILabel!
    @IBOutlet weak var twuser: UILabel!
    @IBOutlet weak var twtext: UILabel!
    @IBOutlet weak var twtime: UILabel!
    
    var tw: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        twuser.text = tw!.author!.name!
        twtime.text = tw!.ago!
        twscreen.text = "@" + tw!.author!.screenName!
        twtext.text = tw!.text
        twimg.setImageWithURL(NSURL(string: tw!.author!.profileImgUrl!))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
