//
//  SecondViewController.swift
//  RadialTransitionExample
//
//  Created by Alex Padalko on 9/24/14.
//  Copyright (c) 2014 Alex Padalko. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "back", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("simplePop:"))
      self.title="Second ViewController"
   
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func simplePop(sender: UIButton) {
        
        self.navigationController?.radialPopViewController()
        
    }

    @IBAction func cutimFrame1(sender: UIButton) {
        self.navigationController?.radialPopViewController(startFrame:CGRectZero,duration: 0.9)
    }
    @IBAction func customFrame2(sender: UIButton) {
        
        self.navigationController?.radialPopViewController(startFrame:CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height, 0, 0),duration: 0.9,transitionCompletion: { () -> Void in
            
            
            
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
