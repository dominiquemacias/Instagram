//
//  SnapshotViewController.swift
//  Instagram
//
//  Created by Dominique Macias on 6/23/16.
//  Copyright © 2016 Dominique Macias. All rights reserved.
//

import UIKit
import AVFoundation
import Parse
import ParseUI

class SnapshotViewController: UIViewController {

    
    @IBOutlet weak var previewView: UIView!
    
    
    @IBOutlet weak var captureImageView: UIImageView!
    
    var session: AVCaptureSession?
    
    var stillImageOutput: AVCaptureStillImageOutput?
    
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        videoPreviewLayer!.frame = previewView.bounds
    }

    
    
    @IBAction func didTakePhoto(sender: AnyObject) {
        if let videoConnection = stillImageOutput!.connectionWithMediaType(AVMediaTypeVideo) {
            // ...
            // Code for photo capture goes here...
            stillImageOutput?.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler: { (sampleBuffer, error) -> Void in
                // ...
                // Process the image data (sampleBuffer) here to get an image file we can put in our captureImageView
                if sampleBuffer != nil {
                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                    let dataProvider = CGDataProviderCreateWithCFData(imageData)
                    let cgImageRef = CGImageCreateWithJPEGDataProvider(dataProvider, nil, true, CGColorRenderingIntent.RenderingIntentDefault)
                    let image = UIImage(CGImage: cgImageRef!, scale: 1.0, orientation: UIImageOrientation.Right)
                    // ...
                    // Add the image to captureImageView here...
                    self.captureImageView.image = image
                }
            })
        }

    }
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
    
    @IBAction func usePhoto(sender: AnyObject) {
        if captureImageView != nil {
            
        }
    }
    
    
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // Setup your camera here...
        
        
        // Not sure where this goes
        session = AVCaptureSession()
        session!.sessionPreset = AVCaptureSessionPresetHigh
        let backCamera = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        var error: NSError?
        var input: AVCaptureDeviceInput!
        do {
            input = try AVCaptureDeviceInput(device: backCamera)
        } catch let error1 as NSError {
            error = error1
            input = nil
            print(error!.localizedDescription)
        }
        if error == nil && session!.canAddInput(input) {
            session!.addInput(input)
            // ...
            // The remainder of the session setup will go here...
        }
        
        
        stillImageOutput = AVCaptureStillImageOutput()
        stillImageOutput?.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
        
        
        if session!.canAddOutput(stillImageOutput) {
            session!.addOutput(stillImageOutput)
            // ...
            // Configure the Live Preview here...
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
            videoPreviewLayer!.videoGravity = AVLayerVideoGravityResizeAspect
            videoPreviewLayer!.connection?.videoOrientation = AVCaptureVideoOrientation.Portrait
            previewView.layer.addSublayer(videoPreviewLayer!)
            session!.startRunning()
            
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
