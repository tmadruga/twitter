//
//  profileCell.swift
//  twitter_alamofire_demo
//
//  Created by Tiffany Madruga on 7/6/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import DateToolsSwift
import TTTAttributedLabel

class profileCell: UITableViewCell {

    
    //Outlets
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var handle: UILabel!
    @IBOutlet weak var createdAt: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var likesCount: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    
    var tweet: Tweet! {
        didSet {
            tweetText.text = tweet.text
            username.text = tweet.user.name
            handle.text = "@"+tweet.user.screenName
            createdAt.text = tweet.twitterDateString
            
            if tweet.user.imageURL != nil{
                self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2
                profilePicture.af_setImage(withURL: tweet.user.imageURL!)
            }
            
            likeButton.isSelected = tweet.favorited
            retweetButton.isSelected = tweet.retweeted
            

            
            
            //Setting retweet and favorites counts
            if tweet.retweetCount == 0{
                retweetCount.text = ""
            }else{
                retweetCount.text = "\(tweet.retweetCount)"
            }
            
            if tweet.favoriteCount == 0{
                likesCount.text = ""
            }else{
                likesCount.text = "\(tweet.favoriteCount)"
            }


            
            
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
