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

class profileCell: UITableViewCell, TTTAttributedLabelDelegate {

    
    //Outlets
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var handle: UILabel!
    @IBOutlet weak var createdAt: UILabel!
    
    @IBOutlet weak var tweetText: TTTAttributedLabel!
    
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var likesCount: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    
    var tweet: Tweet! {
        didSet {
            tweetText.enabledTextCheckingTypes = NSTextCheckingResult.CheckingType.link.rawValue
            
            tweetText.isUserInteractionEnabled = true
            tweetText.delegate = self

            
            
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
    
    
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        UIApplication.shared.open(url, options: [ : ]) { (Bool) in
            print(url)
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
            likesCount.text = ""
        }else{
            likesCount.text = "\(tweet.favoriteCount)"
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
