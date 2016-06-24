//
//  LoginViewController.swift
//  Instagram
//
//  Created by Dominique Macias on 6/20/16.
//  Copyright © 2016 Dominique Macias. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    @IBAction func onSignIn(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                print("you're logged in")
                self.username = self.usernameField.text
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            } else {
                let alertController = UIAlertController(title: "Error", message: "Incorrect username or password", preferredStyle: .Alert)
                // create a cancel action
                let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
                    // handle cancel response here. Doing nothing will dismiss the view.
                }
                // add the cancel action to the alertController
                alertController.addAction(cancelAction)
                
                // create an OK action
                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                    // handle response here.
                }
                // add the OK action to the alert controller
                alertController.addAction(OKAction)
                
                self.presentViewController(alertController, animated: true) {
                     //optional code for what happens after the alert controller has finished presenting
                }

            }
        }
    }
    
    @IBAction func onSignUp(sender: AnyObject) {
        let newUser = PFUser()
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if success {
                print("Created a User")
                self.username = self.usernameField.text
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            } else {
                print(error?.localizedDescription)
                if error?.code == 202 {
                    print("Username is taken")
                    let alertController = UIAlertController(title: "Error", message: "Username is already taken", preferredStyle: .Alert)
                    // create a cancel action
                    let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
                        // handle cancel response here. Doing nothing will dismiss the view.
                    }
                    // add the cancel action to the alertController
                    alertController.addAction(cancelAction)
                    
                    // create an OK action
                    let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                        // handle response here.
                    }
                    // add the OK action to the alert controller
                    alertController.addAction(OKAction)
                    
                    self.presentViewController(alertController, animated: true) {
                        //optional code for what happens after the alert controller has finished presenting
                    }

                }
            }
        }
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
