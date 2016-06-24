//
//  ProfileDetailViewController.swift
//  Instagram
//
//  Created by Dominique Macias on 6/22/16.
//  Copyright © 2016 Dominique Macias. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ProfileDetailViewController: UIViewController {

    
    @IBOutlet weak var profileImagePost: PFImageView!
    
    @IBOutlet weak var profileTimestampPost: UILabel!
    
    @IBOutlet weak var profileCaptionPost: UILabel!
    
    var post: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(post)
        
        let caption = post["caption"] as? String
        profileCaptionPost.text = caption
        
        
        let timestamp = post.createdAt
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        formatter.timeStyle = .MediumStyle
        
        let time = formatter.stringFromDate(timestamp!)
        profileTimestampPost.text = time
        
        
        let imagePost = post["media"] as? PFFile
        profileImagePost.file = imagePost

        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
