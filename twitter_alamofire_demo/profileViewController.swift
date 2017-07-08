//
//  profileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Tiffany Madruga on 7/6/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class profileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var user = User.current
    var tweets: [Tweet] = []
    var tweet: Tweet?
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var bio: UILabel!
    @IBOutlet weak var handle: UILabel!
    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var following: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        username.text = user?.name
        handle.text = "@"+(user?.screenName)!
        bio.text = user?.bio
        followers.text = user?.followers
        following.text = user?.following
        
        
        
        //formatting tableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100

        
        
        if user?.bannerImageURL != nil{
            backgroundImage.af_setImage(withURL: (user?.bannerImageURL)!)
        }
        
        //profile picture setup
        if user?.imageURL != nil{
            profilePicture.af_setImage(withURL: (user?.imageURL!)!)
        }
        profilePicture.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        profilePicture.layer.borderWidth = 3
        self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2
        // Do any additional setup after loading the view.
        
        fetchUserTimeline()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as! profileCell
        
        cell.tweet = tweets[indexPath.row]
        tweet = cell.tweet
        
        return cell
    }
    
    func fetchUserTimeline(){
        APIManager.shared.getUserTimeLine { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
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
