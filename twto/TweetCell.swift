//
//  TweetCell.swift
//  twto
//
//  Created by Vaibhav Krishna on 5/4/15.
//  Copyright (c) 2015 Vaibhav Krishna. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var twImgView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var twTextLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var twHandle: UILabel!
    
    
    var tw: Tweet! {
        didSet{
            userNameLabel.text = tw.author!.name!
            timeLabel.text = tw.ago!
            twHandle.text = "@" + tw.author!.screenName!
            twTextLabel.text = tw.text
            twImgView.setImageWithURL(NSURL(string: tw.author!.profileImgUrl!))
        }
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
