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

class newPostViewController: UIViewController, UITextViewDelegate {
    
    
    @IBOutlet weak var tweetButton: UIButton!
    @IBOutlet weak var textBox: UITextView!
    weak var delegate: newPostViewControllerDelegate?

    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var textCount: UILabel!
    
    func updateCharacterCount(){
        if textBox.text.characters.count > 140{
            textCount.textColor = UIColor.red
            textCount.text = "-\(textBox.text.characters.count - 140 )"
            
        }else{
            textCount.textColor = UIColor.gray
            textCount.text = "\(textBox.text.characters.count)/140"
        }
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textBox.text = ""
        textBox.textColor = UIColor.black

    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        updateCharacterCount()
        if textBox.text.characters.count > 140 {
            tweetButton.isEnabled = false
            tweetButton.backgroundColor = UIColor.lightGray
            
        }else{
            tweetButton.isEnabled = true
            tweetButton.backgroundColor = UIColor(red: 0, green: 170, blue: 238, alpha: 1)
        
        }
        
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textBox.text.characters.count > 140 {
            tweetButton.isEnabled = false
        
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textBox.text = "What's Happening"
        textBox.delegate = self


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
