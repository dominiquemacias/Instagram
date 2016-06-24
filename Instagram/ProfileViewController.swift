//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Dominique Macias on 6/20/16.
//  Copyright © 2016 Dominique Macias. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ProfileViewController: UIViewController, UITableViewDataSource,UITableViewDelegate, UIScrollViewDelegate {
    
    
    @IBOutlet weak var profileTableView: UITableView!
    
    var postArray = []
    let refreshControl = UIRefreshControl()
    var isMoreDataLoading = false
    var loadedPostNumber = 20
   // var user: PFUser
    //var userArray = []
    var author: String!

    
    @IBAction func signOut(sender: AnyObject?) {
        PFUser.logOutInBackgroundWithBlock { (error: NSError?) in
            // PFUser.currentUser() will now be nil
        self.performSegueWithIdentifier("logoutSegue", sender: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        print("viewDidLoad Called")
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.profileTableView.insertSubview(refreshControl, atIndex: 0)
        
        
        profileTableView.delegate = self
        profileTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // Handle scroll behavior here
        if (!isMoreDataLoading) {
            
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = profileTableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - profileTableView.bounds.size.height
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && profileTableView.dragging) {
                isMoreDataLoading = true
                print("print2")
                // Code to load more results
                loadedPostNumber += 10
                fetchPosts()
            }
            
        }
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("View will appear called")
        fetchPosts()
    }


    func refreshControlAction(refreshControl: UIRefreshControl) {
        fetchPosts()
        // Tell the refreshControl to stop spinning
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ProfileCell", forIndexPath: indexPath) as! ProfileCell
        //print(postArray)
        let post = postArray[indexPath.row] as! PFObject
//        author = post["author"] as! String
        cell.profileCaptionPost.text = post["caption"] as? String
        cell.profileImagePost.file = post["media"] as? PFFile
        cell.profileImagePost.loadInBackground()
        //self.postArray = posts
        //self.postTableView.reloadData()
        
        
        let timestamp = post.createdAt
        print(timestamp)
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        formatter.timeStyle = .MediumStyle
        
        
//        let user = PFUser.currentUser()?.username
//        cell.profileUsernamePost.text = user
        
        let time = formatter.stringFromDate(timestamp!)
        cell.profileTimestampPost.text = time

        let user = post["author"]
        cell.profileUsernamePost.text = user.username
        
        return cell
    }
    
    
    func fetchPosts() {
        print("fetchPosts called")


        let query = PFQuery(className: "Post")
        let user = PFUser.currentUser()
        query.includeKey("author")
        print("user is:" + "\(user)")
        print("author is:" + "\(author)")
        
        query.whereKey("author", equalTo: user!)

        query.orderByDescending("createdAt")
        
        query.includeKey("author")
        query.limit = loadedPostNumber

        
        
        //fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            let posts = posts
            self.postArray = posts!
            self.profileTableView.reloadData()
            self.refreshControl.endRefreshing()
            self.isMoreDataLoading = false
        }
    }
    
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "profileViewSegue" {
            let cell = sender as! UITableViewCell
            let indexPath = profileTableView.indexPathForCell(cell)
            let post = postArray[indexPath!.row]
            
            let profileDetailViewController = segue.destinationViewController as! ProfileDetailViewController
            profileDetailViewController.post = post as! PFObject
            
//        } else if segue.identifier == "logoutSegue"{
//            
        }
        

        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
