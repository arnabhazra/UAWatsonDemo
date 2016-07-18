//
//  LogMentalViewController.swift
//  UADemo
//
//  Created by Arnab Hazra on 6/27/16.
//  Copyright © 2016 Arnab. All rights reserved.
//

import UIKit
import AVFoundation
import SpeechToTextV1
//import ToneAnalyzerV3

class LogMentalViewController: UIViewController, AVAudioRecorderDelegate {
    
    var logMentalImage = UIImage(named: "LogMentalNew.png")
    var recordingButtonImage = UIImage(named: "Mic-Circle_Button.png")
    var toneNameArray = [String]()
    var toneScoreArray = [Double]()
    var audioRecorder: AVAudioRecorder!
    //let rectForTextView = CGRect(x: 0, y: 400, width: 100, height: 100)
    let textView = UITextView(frame: CGRect(x: 0, y: 400, width: 100, height: 100))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let frameWidth = self.view.frame.size.width
        let frameheight = self.view.frame.size.height - (self.navigationController?.navigationBar.frame.size.height)!
        let imageView = UIImageView(image: logMentalImage)
        self.navigationController?.navigationBarHidden = true // hiding navigation bar in Log mental Screen
       // imageView.frame = CGRect(x: 0, y: (self.navigationController?.navigationBar.frame.size.height)! + 15, width: frameWidth, height: frameheight)
        imageView.frame = CGRect(x: 0, y:10, width: frameWidth, height: self.logMentalImage!.size.height)
        imageView.contentMode = .ScaleAspectFill
        self.view.addSubview(imageView)
        let frameForRecordingButton = CGRect(x: frameWidth * 0.23, y: frameheight * 0.3, width:200, height:200)
        let recordingButton = UIButton(frame: frameForRecordingButton)
     //   recordingButton.backgroundColor = UIColor.redColor()
        recordingButton.setBackgroundImage(recordingButtonImage, forState: .Normal)
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
        sender.enabled = false
      
    //    textView.text = "Hey watson how are you doing today!"
       // textView.backgroundColor = UIColor.redColor()
        self.view.addSubview(textView)
       // callToneAnalyzer() // without SDK
        // service call for recording
        audioRecorderFunc()
        
    }
    
    
    func callWatsonService(){
        let username = "4acb8d94-bd6a-4559-9193-6d4b354300be"
        let password = "KV58PdLri0E1"
        let speechToText = SpeechToText(username: username, password: password)
        var settings = TranscriptionSettings(contentType: .L16(rate: 44100, channels: 1))
        settings.continuous = true
        settings.interimResults = true
        let failure = {(error : NSError) in print(error)}
        let stopStreaming = speechToText.transcribe(settings, failure: failure){ results in
            print(results.last?.alternatives.last?.transcript)
            self.textView.text = "success"
        }
        
    }
    
    
    
    // function for recording audio
    
    func audioRecorderFunc(){
        
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatLinearPCM),
            AVSampleRateKey: 16000.0,
            AVNumberOfChannelsKey: 1 as NSNumber,
            AVEncoderAudioQualityKey: AVAudioQuality.High.rawValue
        ]
        
        let directoryPath = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)[0] as String
        let recordingName = "recorded.wav"
        let pathArray = [directoryPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
       // let session = AVAudioSession.sharedInstance()
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryRecord)
      /*  AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
            if granted {
                print("Permission Granted.")
            } else {
                print("Permission to record not granted")
            }
        }) */
        
        do {
            
            try! audioRecorder = AVAudioRecorder(URL: filePath!, settings:settings)
            audioRecorder.delegate = self
            audioRecorder.meteringEnabled = true
            audioRecorder.prepareToRecord()
            audioRecorder.record()
            
        } catch let error as NSError{
            print(error.localizedDescription)
            stopRecording()
        }
        

    }
    
    func stopRecording()
    {
     audioRecorder.stop()
     self.textView.text = "error"
        
        
    }
    
    
    func callToneAnalyzer()-> Void{
        let endpoint = "https://gateway.watsonplatform.net/tone-analyzer/api/v3/tone?version=2016-05-19&text="
        
        
        let sampleText = "I am really excited to be working with Watson!" // text for analyzing
        let username = "c2d4e690-0387-4111-b360-1794538ce708";
        let password = "nolOT6wpZ44w"
        // let version = "2016-05-19"
        let authString = username + ":" + password
        let authData = authString.dataUsingEncoding(NSASCIIStringEncoding)
        let authValue = "Basic " + authData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        
        let toneUrl = endpoint + sampleText.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
        let url = NSURL(string: toneUrl)
        //  let url = NSMutableURLRequest(string : toneUrl)
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        config.HTTPAdditionalHeaders = ["Authorization" : authValue]
        //  config.HTTPAdditionalHeaders = ["Content-Type" : "application/json"]
        let session = NSURLSession(configuration: config)
        var json : AnyObject = ""
        var taskIsRunning = true;
        
        var task = session.dataTaskWithURL(url!) {
            (let data, let response, let error) in
            if let httpResponse = response as? NSHTTPURLResponse {
                
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments)
                    //  print(json) -- raw JSON for services
                    if let jsonDict = json as? NSDictionary{
                        for(key,value) in jsonDict {
                            
                            
                            if let jsonDictInner = value as? NSDictionary{
                                
                                for toneCategory in jsonDictInner["tone_categories"] as! [Dictionary<String,AnyObject>]{
                                    
                                    
                                    print(toneCategory["category_name"]!)
                                    // print(toneCategory.values.count)
                                    // print(toneCategory["tones"]!)
                                    
                                    for toneName in toneCategory["tones"] as! [Dictionary<String,AnyObject>]{
                                        
                                        
                                        print(toneName["tone_name"]!)
                                        print(toneName["score"]!)
                                        
                                        // populating array
                                        self.toneNameArray.append(toneName["tone_name"] as! String)
                                        self.toneScoreArray.append(toneName["score"] as! Double)
                                        
                                        
                                    }
                                    
                                    
                                    
                                }
                                
                            }
                            
                        }
                        taskIsRunning = false // for disabling thread
                        
                    }
                    
                } catch{
                    print("Problem serialising JSON object")
                    
                }
            }
        }
        if(taskIsRunning){
            task.resume()
        }
        while (taskIsRunning) {
            sleep(1)
        }
        
        //print("success")
        
    }
    

}
