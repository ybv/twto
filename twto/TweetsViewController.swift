//
//  TweetsViewController.swift
//  twto
//
//  Created by Vaibhav Krishna on 5/4/15.
//  Copyright (c) 2015 Vaibhav Krishna. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tweetTableView: UITableView!
    var refreshControl: UIRefreshControl!
    var tweets : [Tweet]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tweetTableView.dataSource = self
        self.tweetTableView.delegate = self
        self.tweetTableView.rowHeight = UITableViewAutomaticDimension
        self.tweetTableView.estimatedRowHeight = 120
        refreshControl = UIRefreshControl()
        self.fetchTweets()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        // Do any additional setup after loading the view.
        tweetTableView.insertSubview(refreshControl, atIndex: 0)
        
    }
    func onRefresh(){
        self.refreshControl?.endRefreshing()
    }
    func fetchTweets(){
        TwitterClient.sharedInstance.homeTimeLine(nil, completion:{(tweets, err )-> () in
            self.tweets = tweets
            println(tweets![0].text)
            self.tweetTableView.reloadData()
        } )
    }

    @IBAction func logOut(sender: AnyObject) {
        User.currentUser?.logOut()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tweetTableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        cell.tw = self.tweets![indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tw = tweets {
            return tw.count
        }
        else{
            return 0
        }
        
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if sender is UITableViewCell {
            let cell = sender as! TweetCell
            let index = tweetTableView.indexPathForCell(cell)!
            
            let twatRow = tweets![index.row]
            let twDetailVC = segue.destinationViewController as!TweetDetailViewController
            
            twDetailVC.tw = twatRow

        }
        else{
            let nav = segue.destinationViewController as!UINavigationController
            let filterVC = nav.topViewController as! ComposerViewController
            println(filterVC.description)
        }
        
        
        
    }


}
