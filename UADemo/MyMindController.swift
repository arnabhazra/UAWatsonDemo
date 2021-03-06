//
//  MyMindController.swift
//  UADemo
//
//  Created by Arnab Hazra on 6/21/16.
//  Copyright © 2016 Arnab. All rights reserved.
//

import UIKit

class MyMindController: UIViewController {
    
    
    @IBOutlet weak var scrollViewForMental: UIScrollView!
    
    var imageMentalStat = UIImage(named: "MentalStatus1.png")
    var imageMentalStatSecond = UIImage(named: "MentalStat2.png")
  


    override func viewDidLoad() {
        super.viewDidLoad()
        let frameWidth = view.frame.size.width
        let frameHeight = view.frame.size.height
        scrollViewForMental.contentSize.width = frameWidth
        scrollViewForMental.contentSize.height = (self.imageMentalStat?.size.height)! * 1.9
        let imageViewMentalStat = UIImageView(image: imageMentalStat)
        imageViewMentalStat.frame = CGRect(x: 0, y: 0, width: frameWidth, height: self.imageMentalStat!.size.height)
        imageViewMentalStat.contentMode = .ScaleAspectFill
        scrollViewForMental.addSubview(imageViewMentalStat)
        let imageViewMentalStatSecond = UIImageView(image: imageMentalStatSecond)
        imageViewMentalStatSecond.frame = CGRect(x: 0, y: self.imageMentalStat!.size.height, width: frameWidth, height: 500)
        imageViewMentalStatSecond.contentMode = .ScaleAspectFill
        scrollViewForMental.addSubview(imageViewMentalStatSecond)
       


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
