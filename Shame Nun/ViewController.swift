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
        configureGestures()
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

        let image = UIImage(named: "shake.jpg", inBundle: NSBundle.mainBundle(), compatibleWithTraitCollection: nil)

        iconView = UIImageView(image: image)

        iconView.layer.anchorPoint = CGPointMake(0.5, 1)
        iconView.center = CGPointMake(view.center.x, (view.bounds.height / 2) + (iconView.bounds.height / 2))
        iconView.transform = CGAffineTransformMakeScale(0.1, 0.1)
        
        view.addSubview(iconView)
        
        UIView.animateWithDuration(0.2, animations: {
            self.iconView.transform = CGAffineTransformMakeScale(1, 1)
        })

        shakeIconView()
    }

    func configureGestures() {
        let gesture = UITapGestureRecognizer(target: self, action: "shame")
        view.addGestureRecognizer(gesture)
    }

    func shakeIconView() {
        // Ewww. There's a nicer way to do this, right? RIGHT?
        UIView.animateWithDuration(0.2, animations: {
            self.iconView.transform = CGAffineTransformRotate(self.iconView.transform, 0.1)
        }, completion: {
            (value: Bool) in

            UIView.animateWithDuration(0.2, animations: {
                self.iconView.transform = CGAffineTransformRotate(self.iconView.transform, -0.2)
            }, completion: {
                (value: Bool) in

                UIView.animateWithDuration(0.2, animations: {
                    self.iconView.transform = CGAffineTransformRotate(self.iconView.transform, 0.1)
                })
            })
        })
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

