//
//  DetailViewController.swift
//  Instagram
//
//  Created by Dominique Macias on 6/22/16.
//  Copyright © 2016 Dominique Macias. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class DetailViewController: UIViewController {

    
    @IBOutlet weak var detailImageView: PFImageView!
    
    @IBOutlet weak var detailTimestampLabel: UILabel!
    
    @IBOutlet weak var detailCaptionLabel: UILabel!
    
    var post: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(post)
        
        let caption = post["caption"] as? String
        detailCaptionLabel.text = caption
        
        let timestamp = post.createdAt
        print(timestamp)
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        formatter.timeStyle = .MediumStyle
        
        let time = formatter.stringFromDate(timestamp!)
        detailTimestampLabel.text = time
        
        
        let imagePost = post["media"] as? PFFile
        detailImageView.file = imagePost

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
