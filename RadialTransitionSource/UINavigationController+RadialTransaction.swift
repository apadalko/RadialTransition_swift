//
//  UINavigationController+RadialTransaction.swift
//  AAPRadialTransaction_swift
//
//  Created by Alex Padalko on 9/23/14.
//  Copyright (c) 2014 Alex Padalko. All rights reserved.
//

import UIKit
let abc=AAPTransactionDirector();

var defaultRadialDuration:CGFloat = 0.5

extension UINavigationController {

  
    
    
    func getLeftRect()->CGRect{
        
        return CGRectZero
        
    }
//MARK: PUSH
    /**
    * radial pushing view controller
    *
    * @param startFrame where circle start
    */
    func radialPushViewController(viewController: UIViewController, duration: CGFloat = 0.33 ,startFrame:CGRect = CGRectNull, transitionCompletion: (() -> Void)? = nil ){
        
        var rect = startFrame
        if(rect == CGRectNull){
            
            rect = CGRectMake(self.visibleViewController.view.frame.size.width, self.visibleViewController.view.frame.size.height/2, 0, 0)
        }
        
      
       var animatorDirector:AAPTransactionDirector?=AAPTransactionDirector();
        animatorDirector?.duration=duration
        
    
        self.delegate=animatorDirector;
        animatorDirector?.animationBlock={(transactionContext:UIViewControllerContextTransitioning, animationTime: CGFloat ,completion:()->Void)->Void in
 
            let toViewController = transactionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
            let fromViewController = transactionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
            let containerView = transactionContext.containerView()
            
            containerView.insertSubview(toViewController!.view, aboveSubview: fromViewController!.view)

            toViewController?.view .radialAppireanceWithStartFrame(rect, duration: animationTime, complitBlock: { () -> Void in
                
                
                completion();
                
                transitionCompletion?();
           
              
           })

        }
          self.pushViewController(viewController, animated: true)

        
        
          self.delegate = nil;
      
    }
//MARK: POP
    /**
    * radial pop view controller
    *
    * @param startFrame where circle start
    */
    func radialPopViewController( duration: CGFloat = 0.33 ,startFrame:CGRect = CGRectNull, transitionCompletion: (() -> Void)? = nil ){
        
        var rect = startFrame
        if(rect == CGRectNull){
            
            rect = CGRectMake(0, self.visibleViewController.view.frame.size.height/2, 0, 0)
        }
        
        
        var animatorDirector=AAPTransactionDirector();
        animatorDirector.duration=duration
        self.delegate=animatorDirector;
        animatorDirector.animationBlock={(transactionContext:UIViewControllerContextTransitioning, animationTime: CGFloat ,completion:()->Void)->Void in
            
            let toViewController = transactionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
            let fromViewController = transactionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
            let containerView = transactionContext.containerView()
            
            containerView.insertSubview(toViewController!.view, aboveSubview: fromViewController!.view)
            
            toViewController?.view .radialAppireanceWithStartFrame(rect, duration: animationTime, complitBlock: { () -> Void in
                completion();
             transitionCompletion?();
                
                
            })
            
        }
        
        self.popViewControllerAnimated(true)
            self.delegate = nil;
    }
    
    
    //MARK: Swipe
    
    func enableRadialSwipe(){
        
  
        
        
   self.enableGesture(true)
        
        
        
    }
    func disableRadialSwipe(){
self.enableGesture(false)
        
    }
    
    /**
    * enabling swipe back gesture. NOTE interactivePopGestureRecognizer will be disabled
    *
    */
    private func enableGesture(enabled:Bool){
        
        struct StaticStruct {
        
            static var recognizerData = Dictionary<String,UIGestureRecognizer>()
            
        }
        
        if enabled == true {
            
            if self.respondsToSelector(Selector("interactivePopGestureRecognizer")) {
                
                self.interactivePopGestureRecognizer.enabled = false
            }
            
            let  panGesture = UIScreenEdgePanGestureRecognizer(target: self, action: Selector("screenPan:"))
            panGesture.edges = UIRectEdge.Left
            
            self.view.addGestureRecognizer(panGesture)
            
            StaticStruct.recognizerData[self.description] = panGesture
            
            
            
        }else {
            
            self.view.removeGestureRecognizer(StaticStruct.recognizerData[self.description]!)
            StaticStruct.recognizerData[self.description] = nil
            
        }
    }
    
    func screenPan(sender: AnyObject){
        
        
        let pan: UIPanGestureRecognizer = sender as! UIPanGestureRecognizer
        
    
        let state: UIGestureRecognizerState = pan.state
        
        let location:CGPoint = pan.locationInView(self.view)
        
        struct StaticStruct {
            static var firstTouch:CGPoint = CGPointZero
            static var d:CGFloat = 0
            static var animDirector:AAPTransactionDirector? = nil
           
            
          static  func clean(){
                
                d=0;
                firstTouch=CGPointZero
                animDirector=nil
            }

        }
        
        switch state {
            
        case UIGestureRecognizerState.Began:
       
            if (self.viewControllers.count<2) {
                StaticStruct.clean()
                return;
            }
            
            StaticStruct.animDirector = AAPTransactionDirector()
            StaticStruct.animDirector?.isInteractive=true
            StaticStruct.animDirector?.duration = defaultRadialDuration
            self.delegate=StaticStruct.animDirector
            
           
            
            self.popViewControllerAnimated(true)
              self.delegate=nil
            StaticStruct.d =  sqrt(pow(self.visibleViewController.view.frame.size.width, 2)+pow(self.visibleViewController.view.frame.size.height, 2) )*2
            
            StaticStruct.firstTouch = location
            
            
       
             StaticStruct.animDirector?.animationBlock={(transactionContext:UIViewControllerContextTransitioning, animationTime: CGFloat ,completion:()->Void)->Void in
                
              
                let toViewController = transactionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
                let fromViewController = transactionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
                let containerView = transactionContext.containerView()
                
                containerView.insertSubview(toViewController!.view, aboveSubview: fromViewController!.view)
                
                let maskLayer = CAShapeLayer()
                let maskRect = CGRectMake(location.x-location.x/2, location.y-location.x/2, 0, 0);
                let path = CGPathCreateWithEllipseInRect(maskRect, nil)
                maskLayer.path=path
                toViewController?.view.layer.mask=maskLayer
                
         
            }
         
            
        case UIGestureRecognizerState.Changed:
           
            
            
            StaticStruct.animDirector?.interactiveUpdateBlock={(transactionContext:UIViewControllerContextTransitioning, percent: CGFloat)->Void in
                
                let maskLayer:CAShapeLayer = transactionContext.viewControllerForKey(UITransitionContextToViewControllerKey)?.view.layer.mask as! CAShapeLayer
                
                let mainD = percent * StaticStruct.d
                
                let maskRect : CGRect = CGRectMake(-mainD/2, location.y-mainD/2, mainD, mainD);
                
                let path = CGPathCreateWithEllipseInRect(maskRect, nil)
                
                
                maskLayer.path=path
                
            }
            
            let mainD = location.x*StaticStruct.d/self.view.frame.size.width
            
            
            StaticStruct.animDirector?.precent=mainD/StaticStruct.d
         
        default:
            
            
            let mainD  =  location.x*StaticStruct.d/self.view.frame.size.width;
            
            let canceled = mainD>StaticStruct.d*0.5 ? false : true;
            
            StaticStruct.animDirector?.endInteractiveTranscation(canceled: canceled, endBlock: { () -> Void in
                StaticStruct.clean()
            })
        }
    }
}






