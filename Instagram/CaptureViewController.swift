//
//  CaptureViewController.swift
//  Instagram
//
//  Created by Dominique Macias on 6/20/16.
//  Copyright © 2016 Dominique Macias. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD


class CaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {


    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var captionText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        let vc = UIImagePickerController()
//        vc.delegate = self
//        vc.allowsEditing = true
//        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
//        
//        self.presentViewController(vc, animated: true, completion: nil)
//        

        //Do any additional setup after loading the view.
    }
    
    func imagePickerController(picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
//        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        photoImageView.image = originalImage
        // Dismiss UIImagePickerController to go back to your original view controller
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func selectPhoto(sender: AnyObject) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)
        

    }
    
    
    @IBAction func postImage(sender: AnyObject) {
        //let Size = 10MB as! CGSize
        //let Image = resize(photoImageView.image!, newSize: Size)
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        Post.postUserImage(photoImageView.image!, withCaption: captionText.text) { (success: Bool, error: NSError?) -> Void in
            
            if success {
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                self.tabBarController?.selectedIndex = 0
            } else {
                print("error: \(error?.localizedDescription)")
            }
        }
    
        
    }
    
//    
//    @IBAction func takePhoto(sender: AnyObject) {
//        self.performSegueWithIdentifier("captureSegue", sender: nil)
//    }
    

    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
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
