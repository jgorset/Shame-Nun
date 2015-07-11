//
//  ViewController.swift
//  Shame Nun
//
//  Created by Johannes on 11/07/15.
//  Copyright (c) 2015 Johannes Gorset. All rights reserved.
//

import UIKit
import AVFoundation
import QuartzCore

class ViewController: UIViewController {
    var player: AVAudioPlayer!
    var iconView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAudioSession()
        configureAudioPlayer()
        configureView()
    }
    
    func shame() {
        player.play()
        shakeIconView()
    }
    
    func configureAudioPlayer() {
        let musicPath = NSBundle.mainBundle().pathForResource("shame", ofType: "mp3")
        let musicURL = NSURL.fileURLWithPath(musicPath!)
        
        player = AVAudioPlayer(contentsOfURL: musicURL, error: nil)
    }
    
    func configureAudioSession() {
        let session  = AVAudioSession.sharedInstance()

        session.setCategory(AVAudioSessionCategoryPlayback, error: nil)
    }
    
    func configureView() {
        self.view.backgroundColor = UIColor.blackColor()

        let image     = UIImage(named: "shake.jpg", inBundle: NSBundle.mainBundle(), compatibleWithTraitCollection: nil)

        iconView = UIImageView(image: image)

        iconView.center = view.center
        iconView.transform = CGAffineTransformMakeScale(0.1, 0.1)
        
        view.addSubview(iconView)
        
        UIView.animateWithDuration(0.2, animations: {
            self.iconView.transform = CGAffineTransformMakeScale(1, 1)
        })

        shakeIconView()
    }

    func shakeIconView() {
        var shake:CABasicAnimation = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        var fromPoint:CGPoint = CGPointMake(iconView.center.x - 15, iconView.center.y)
        var fromValue:NSValue = NSValue(CGPoint: fromPoint)
        
        var toPoint:CGPoint = CGPointMake(iconView.center.x + 15, iconView.center.y)
        var toValue:NSValue = NSValue(CGPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        iconView.layer.addAnimation(shake, forKey: "position")

    }

    override func canBecomeFirstResponder() -> Bool {
        return true
    }

    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent) {
        if motion == .MotionShake {
            shame()
        }
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

