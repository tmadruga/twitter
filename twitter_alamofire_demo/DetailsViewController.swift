//
//  DetailsViewController.swift
//  twitter_alamofire_demo
//
//  Created by Tiffany Madruga on 7/6/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit


class DetailsViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    var tweet: Tweet!

    @IBOutlet weak var tweetText: UILabel!
    
    @IBOutlet weak var handleLabel: UILabel!
    
    @IBOutlet weak var retweetCount: UILabel!
    
    @IBOutlet weak var favoriteCount: UILabel!
    @IBOutlet weak var retweetsLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var likeButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let tweet = tweet{
            usernameLabel.text = tweet.user.name
            tweetText.text = tweet.text
            handleLabel.text = "@"+tweet.user.screenName
            
            if tweet.user.imageURL != nil{
                self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2
                profilePicture.af_setImage(withURL: tweet.user.imageURL!)
            }
    
            
            if tweet.retweetCount != 0 {
                retweetCount.text = "\(tweet.retweetCount)"
            }else {
                
                retweetCount.text = ""
                retweetsLabel.text = ""
            }
            
            if tweet.favoriteCount != 0{
                favoriteCount.text = "\(tweet.favoriteCount)"
            } else {
                favoriteCount.text = ""
                likesLabel.text = ""
                
            }
            
            
            
            if tweet.retweetCount == 1 {
                retweetsLabel.text = "Retweet"
            }
            
            if tweet.favoriteCount == 1 {
                likesLabel.text = "Like"
            
            }
            
        
        }
        
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        refreshData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    
    func refreshData(){
        if tweet.retweetCount <= 0{
            tweet.retweetCount = 0
            retweetCount.text = ""
            retweetsLabel.text = ""
        }else{
            retweetCount.text = "\(tweet.retweetCount)"
            if tweet.retweetCount == 1{
                retweetsLabel.text = "Retweet"
            } else {
                retweetsLabel.text = "Retweets"
            }
            
        }
        
        if tweet.favoriteCount <= 0{
            tweet.favoriteCount = 0
            favoriteCount.text = ""
            likesLabel.text = ""
        }else{
            favoriteCount.text = "\(tweet.favoriteCount)"
            if tweet.favoriteCount == 1{
                likesLabel.text = "Like"
            } else {
                likesLabel.text = "Likes"
            }
            
        }
    }

    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
