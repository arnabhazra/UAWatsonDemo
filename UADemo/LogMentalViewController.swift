//
//  LogMentalViewController.swift
//  UADemo
//
//  Created by Arnab Hazra on 6/27/16.
//  Copyright © 2016 Arnab. All rights reserved.
//

import UIKit

class LogMentalViewController: UIViewController {
    
    var logMentalImage = UIImage(named: "Log_Mental_Submission.png")
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let frameWidth = self.view.frame.size.width
        let frameheight = self.view.frame.size.height - (self.navigationController?.navigationBar.frame.size.height)!
        let imageView = UIImageView(image: logMentalImage)
        imageView.frame = CGRect(x: 0, y: (self.navigationController?.navigationBar.frame.size.height)! + 15, width: frameWidth, height: frameheight)
        self.view.addSubview(imageView)
        let frameForRecordingButton = CGRect(x: frameWidth * 0.45, y: frameheight * 0.51, width: 30, height: 30)
        let recordingButton = UIButton(frame: frameForRecordingButton)
        recordingButton.backgroundColor = UIColor.redColor()
        self.view.addSubview(recordingButton)
        recordingButton.addTarget(self, action: #selector(LogMentalViewController.startRecording(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
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
    
    // MARK: -Event Handler
    
    func startRecording(sender : UIButton) {
        
        
        
    }

}
