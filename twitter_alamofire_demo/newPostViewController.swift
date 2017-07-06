//
//  newPostViewController.swift
//  twitter_alamofire_demo
//
//  Created by Tiffany Madruga on 7/5/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import RSKPlaceholderTextView


protocol newPostViewControllerDelegate: class {
    func did(post: Tweet)
}

class newPostViewController: UIViewController {
    
    @IBOutlet weak var textBox: UITextView!
    weak var delegate: newPostViewControllerDelegate?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissCompose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }

    @IBAction func onPost(_ sender: Any) {
        
        APIManager.shared.composeTweet(with: textBox.text ) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
            }
            
        }
        
        self.dismiss(animated: true, completion: nil)
    
    }
    
    
    
    
    
    

}
