//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage


class TweetCell: UITableViewCell {
    
    
    //Outlets
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var repliesCount: UILabel!
    @IBOutlet weak var favoritesCount: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    
    
    
    var tweet: Tweet! {
        didSet {
            
            //Setting tweet text, username, body, and date
            tweetTextLabel.text = tweet.text
            usernameLabel.text = tweet.user.name
            handleLabel.text = "@"+tweet.user.screenName
            dateLabel.text = tweet.createdAtString
            
            if tweet.user.imageURL != nil{
                profilePicture.af_setImage(withURL: tweet.user.imageURL!)
            }
            
            //Setting retweet and favorites counts
            if tweet.retweetCount == 0{
                retweetCount.text = ""
            }else{
                retweetCount.text = "\(tweet.retweetCount)"
            }
            
            if tweet.favoriteCount == 0{
                favoritesCount.text = ""
            }else{
                favoritesCount.text = "\(tweet.favoriteCount!)"
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
