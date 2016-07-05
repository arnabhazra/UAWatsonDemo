//
//  ViewController.swift
//  UADemo
//
//  Created by Arnab Hazra on 6/17/16.
//  Copyright © 2016 Arnab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //outlet
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var imageName = UIImage(named:"homepage-Sentio.png")
    var secondImage = "progress_Sentio_1.png"
    var thirdImage = "progress_Sentio_2.png"

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let frameWidth = view.frame.size.width
        let frameHeight = view.frame.size.height
        let imageView = UIImageView(image: imageName) // home screen image
        scrollView.contentSize.width = frameWidth
        //scrollView.backgroundColor = UIColor.redColor()
        scrollView.contentSize.height = self.imageName!.size.height * 1.9
        imageView.frame = CGRect(x: 0, y:0, width:frameWidth, height: self.imageName!.size.height) //setting width and height for image
        imageView.contentMode = .ScaleAspectFill // fixing aspect ratio for iPhone 6
        scrollView.addSubview(imageView)
        
        let frameForButton = CGRect(x:(frameWidth*(0.36)), y: 290, width:100, height: 90)
        let buttonForMental = UIButton(frame: frameForButton)
        //  buttonForMental.titleLabel?.text = "Testing"
         // buttonForMental.backgroundColor = UIColor.redColor() // to test position of button on UI
        scrollView.addSubview(buttonForMental)
       // let secondImageView = UIImageView(image: secondImage)
       // secondImageView.frame = CGRect(x: 0, y: 500, width: frameWidth, height:500)
        //scrollView.addSubview(secondImageView)
        loadSecondStatImage(frameWidth, imageName: self.secondImage)
        buttonForMental.addTarget(self, action:#selector(ViewController.showMyMindScreen(_:)), forControlEvents:UIControlEvents.TouchUpInside) // event handler
        
        //mental icon click button
        let frameForMentalIconButton = CGRect(x: (frameWidth * 0.45), y: 1030, width: 30, height: 30)
        let mentalIconButton = UIButton(frame: frameForMentalIconButton)
        //mentalIconButton.backgroundColor = UIColor.redColor()
        scrollView.addSubview(mentalIconButton)
        mentalIconButton.addTarget(self, action:#selector(ViewController.mentalStat(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        // Log mental button
        
        let frameForLogMentalButton = CGRect(x: (frameWidth * 0.45), y: 490, width: 35, height: 35)
        let logMentalButton = UIButton(frame: frameForLogMentalButton)
        logMentalButton.backgroundColor = UIColor.redColor()
        scrollView.addSubview(logMentalButton)
        logMentalButton.addTarget(self, action: #selector(ViewController.showLogMentalScreen(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        
    }
    
    func loadSecondStatImage(frameWidth : CGFloat, imageName : String)
    {
        
        let secondImage = UIImage(named: imageName)
        let secondImageView = UIImageView(image: secondImage)
        secondImageView.frame = CGRect(x: 0, y: self.imageName!.size.height, width: frameWidth, height:500)
        secondImageView.contentMode = .ScaleAspectFill
        scrollView.addSubview(secondImageView)
        
    }
    
    // Loads MyMind screen
    
    func showMyMindScreen(sender: UIButton){
        
       // let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
      //  let nextVC = storyBoard.instantiateViewControllerWithIdentifier("MyMindController") as! MyMindController
       // self.presentViewController(nextVC, animated: true, completion: nil)
        
        self.performSegueWithIdentifier("homeToMyMind", sender: nil)

        
    }
    
    // loads mental stat
    
    func mentalStat(sender: UIButton) {
        
        loadSecondStatImage(view.frame.size.width, imageName: self.thirdImage)
        
    }
    
    //Loads LohMental Screen
    
    func showLogMentalScreen(sender: UIButton)  {
        
        self.performSegueWithIdentifier("homeToLogMental", sender: nil)
        
    }
    
    
    
}

