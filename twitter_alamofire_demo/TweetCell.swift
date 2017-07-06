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
import DateToolsSwift
import TTTAttributedLabel

class TweetCell: UITableViewCell {
    
    
    //Outlets
   
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var repliesCount: UILabel!
    @IBOutlet weak var favoritesCount: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var tweetText: TTTAttributedLabel!
    
    
    
    
    var tweet: Tweet! {
        didSet {
            
            //Setting tweet text, username, body, and date
//            tweetText.enabledTextCheckingTypes = NSTextCheckingTypes
            tweetText.text = tweet.text
            
            usernameLabel.text = tweet.user.name
            handleLabel.text = "@"+tweet.user.screenName
            dateLabel.text = tweet.twitterDateString
            
            if tweet.user.imageURL != nil{
                self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2
                profilePicture.af_setImage(withURL: tweet.user.imageURL!)
            }
            
            if tweet.favorited == true{
                likeButton.isSelected = true
            
            }
            
            if tweet.retweeted == true{
                retweetButton.isSelected = true
            
            
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
                favoritesCount.text = "\(tweet.favoriteCount)"
            }
            
            

            
            }
            
        }
    
    
    //Implementing the liking feature:
    
    @IBAction func didTapLike(_ sender: Any) {
        
        if likeButton.isSelected == false{
            tweet.favorited = true
            tweet.favoriteCount += 1
            likeButton.isSelected = true
            refreshData()
            
            
            //call to favorite the tweet
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
            
            
        }else{
            likeButton.isSelected = false
            tweet.favorited = false
            tweet.favoriteCount -= 1
            refreshData()
            
            APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                }
            }
    
        }
        
        
    }
    
    
    @IBAction func didTapRetweet(_ sender: Any) {
        if retweetButton.isSelected == false{
            tweet.retweeted = true
            tweet.retweetCount += 1
            retweetButton.isSelected = true
            refreshData()
            
            
            //call to retweet the tweet
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
            
            
        }else{
            retweetButton.isSelected = false
            tweet.retweeted = false
            tweet.retweetCount -= 1
            refreshData()
            
            
            //call to unretweet
            APIManager.shared.unretweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                }
            }
            
        }
        
        
    }
    
    
    
    
    
    
    
    
    func refreshData(){
        if tweet.retweetCount == 0{
            retweetCount.text = ""
        }else{
            retweetCount.text = "\(tweet.retweetCount)"
        }
        
        if tweet.favoriteCount <= 0{
            favoritesCount.text = ""
        }else{
            favoritesCount.text = "\(tweet.favoriteCount)"
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
