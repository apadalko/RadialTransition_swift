//
//  FirstViewController.swift
//  RadialTransitionExample
//
//  Created by Alex Padalko on 9/24/14.
//  Copyright (c) 2014 Alex Padalko. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
self.navigationController?.enableRadialSwipe()
    
        self.title="First ViewController"
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func simplePush(sender: UIButton) {
        
        self.navigationController?.radialPushViewController(SecondViewController(nibName: "SecondViewController", bundle: nil),transitionCompletion: { () -> Void in
            
            
            
            })
        
    }
    
    @IBAction func customFrame1(sender: UIButton) {
        
        
        self.navigationController?.radialPushViewController(SecondViewController(nibName: "SecondViewController", bundle: nil),startFrame: sender.frame,duration:0.9,transitionCompletion: { () -> Void in
            
            
            
        })
    }

    @IBAction func customFrame2(sender: UIButton) {
        
        self.navigationController?.radialPushViewController(SecondViewController(nibName: "SecondViewController", bundle: nil),startFrame: CGRectMake(self.view.frame.size.width, 0, 0, 0),duration:0.9,transitionCompletion: { () -> Void in
            
            
            
        })
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
