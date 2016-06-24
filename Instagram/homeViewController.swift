//
//  HomeViewController.swift
//  Instagram
//
//  Created by Dominique Macias on 6/20/16.
//  Copyright © 2016 Dominique Macias. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class HomeViewController: UIViewController, UITableViewDataSource,UITableViewDelegate, UIScrollViewDelegate {
    
    
    
    @IBOutlet weak var postTableView: UITableView!
    
    var postArray = []
    let refreshControl = UIRefreshControl()
    var isMoreDataLoading = false
    var loadedPostNumber = 20
    //var author: String

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("viewDidLoad Called")
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.postTableView.insertSubview(refreshControl, atIndex: 0)
        
        
        postTableView.delegate = self
        postTableView.dataSource = self
        
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // Handle scroll behavior here
        if (!isMoreDataLoading) {
            
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = postTableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - postTableView.bounds.size.height
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && postTableView.dragging) {
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func refreshControlAction(refreshControl: UIRefreshControl) {
        fetchPosts()
        // Tell the refreshControl to stop spinning

    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
        
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell", forIndexPath: indexPath) as! PostCell
        //print(postArray)
        let post = postArray[indexPath.row] as! PFObject
        
        let timestamp = post.createdAt
        print(timestamp)
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        formatter.timeStyle = .MediumStyle
        
        let user = post["author"]
        cell.usernamePost.text = user.username
        
        let time = formatter.stringFromDate(timestamp!)
        cell.timestampPost.text = time
        cell.captionPost.text = post["caption"] as? String
        cell.imagePost.file = post["media"] as? PFFile
        cell.imagePost.loadInBackground()
        //self.postArray = posts
        //self.postTableView.reloadData()
        
        return cell
    }
    
    func fetchPosts() {
        let query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = loadedPostNumber
        
        
        //fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            let posts = posts
            self.postArray = posts!
            self.postTableView.reloadData()
            self.refreshControl.endRefreshing()
        self.isMoreDataLoading = false
//        let username = PFUser.currentUser()!.username as! String!
//        print(username)
        }
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! UITableViewCell
        let indexPath = postTableView.indexPathForCell(cell)
        let post = postArray[indexPath!.row]
        
        let detailViewController = segue.destinationViewController as! DetailViewController
        detailViewController.post = post as! PFObject
        
        
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
    
    
}
