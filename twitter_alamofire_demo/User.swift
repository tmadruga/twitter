//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/17/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation

class User {
    
    var name: String
    var screenName: String
    var image: String?
    var imageURL: URL?
    private static var _current: User?
    var dictionary: [String: Any]?
    var bio: String?
    var followers: String?
    var following: String?
    var backgroundimageURL: URL?
    var bannerImageURL: URL?
    
    
    init(dictionary: [String: Any]) {
        name = dictionary["name"] as! String
        screenName = (dictionary["screen_name"] as? String)!
        var longimage = dictionary["profile_image_url_https"] as! String
        let wordToRemove = "_normal"
        if let range = longimage.range(of: wordToRemove) {
            longimage.removeSubrange(range)
            image = longimage
        }
        imageURL = URL(string: image!)
        bio = dictionary["description"] as? String
        followers = "\(dictionary["followers_count"]!)"
        following = "\(dictionary["friends_count"]!)"
        let backgroundImage = dictionary["profile_background_image_url_https"] as? String
        backgroundimageURL = URL(string: backgroundImage!)
        let bannerImage = dictionary["profile_banner_url"] as? String
        bannerImageURL = URL(string: bannerImage!)
        
        
        self.dictionary = dictionary
    }
    
    static var current: User? {
        get {
            if _current == nil {
                let defaults = UserDefaults.standard
                if let userData = defaults.data(forKey: "currentUserData") {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! [String: Any]
                    _current = User(dictionary: dictionary)
                }
            }
            return _current
        }
        set (user) {
            _current = user
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
        }
    }
}
