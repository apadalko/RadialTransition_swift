//
//  AAPTransactionDirector.swift
//  AAPRadialTransaction_swift
//
//  Created by Alex Padalko on 9/23/14.
//  Copyright (c) 2014 Alex Padalko. All rights reserved.
//

import UIKit

class AAPTransactionDirector: NSObject,UIViewControllerAnimatedTransitioning,UINavigationControllerDelegate,UIViewControllerInteractiveTransitioning {
 
    private  var _context:UIViewControllerContextTransitioning?
    
 
  lazy var animationBlock:((transactionContext:UIViewControllerContextTransitioning, animationTime: CGFloat , transitionCompletion:()->Void)->Void)? = nil
  lazy var interactiveUpdateBlock:((transactionContext:UIViewControllerContextTransitioning, percent: CGFloat)->Void)? = nil
    lazy var interactiveEndBlock:(()->Void)? = nil
    
    
    var isInteractive:Bool = false
    var duration:CGFloat?
    private var displayLink:CADisplayLink? = nil
    private var _percent:CGFloat = 0
    var precent:CGFloat {
        
        get {
            return _percent
        }
        set {
            
            _percent = newValue
            
          
                 self._context?.updateInteractiveTransition(_percent)
            
           
            
            self._context?.containerView().layer.timeOffset = CFTimeInterval(_percent*self.duration!)
            if (self._context != nil) {
    
                self.interactiveUpdateBlock?(transactionContext:_context!,percent:_percent)
                
            }
         
           
            
        }
        
    }
    var timeOffset:CFTimeInterval{
        get {
            return self._context!.containerView().layer.timeOffset
        }
        set {
            self.precent = CGFloat(CGFloat(newValue)/self.duration!)
           //self._context?.containerView().layer.timeOffset=CFTimeInterval(newValue)
            
        }
        
        
    }

//MARK: Interactive transaction ending
    func endInteractiveTranscation(#canceled: Bool , endBlock:()->Void){
        self.interactiveEndBlock=endBlock
        if canceled {
                  _context?.cancelInteractiveTransition()
            displayLink = CADisplayLink (target: self, selector: Selector("updateCancelAnimation"))
            
        } else {
            
              displayLink = CADisplayLink (target: self, selector: Selector("updateFinishAnimation"))
        }
     
        displayLink?.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
        
    }
  
    
     func updateFinishAnimation(){
        
     
        let offset =  CFTimeInterval( self.timeOffset) + displayLink!.duration
        
        if offset > CFTimeInterval(self.duration!) {
             transitionFinishedFinishing()
        }else{
            self.timeOffset=offset
        }

        
    }
    
     func updateCancelAnimation(){
     
        let offset = CFTimeInterval( self.timeOffset) - displayLink!.duration
        
        if offset < 0 {
            transitionFinishedCanceling()
        }else{
           self.timeOffset=offset
       
        }
    }
    
    private func transitionFinishedCanceling(){
        self._context?.containerView().layer.timeOffset=0
        displayLink?.invalidate()
  
        _context?.completeTransition(false)
        
        self.interactiveEndBlock?();
        
    }
 
    private func transitionFinishedFinishing(){
        displayLink?.invalidate()
        _context?.finishInteractiveTransition()
        _context?.completeTransition(true)
          self.interactiveEndBlock?();
        
    }
    
    
    
//MARK: init & deinit

      override init() {
 println("director created");
        }
    
     deinit{
        println("trans action director deolocated");
        }



//MARK: animation transaction delegate
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval{
        
        return NSTimeInterval(self.duration!);
    }
   
    func animateTransition(transitionContext: UIViewControllerContextTransitioning){
        self._context=transitionContext
      
  
        var v1=transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!.view
        var v2=transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!.view
        
     
        
         self.animationBlock?(transactionContext: self._context!, animationTime: self.duration!, transitionCompletion: { () -> Void in
            
            println("aniation end")
          
           transitionContext.completeTransition(true)
      
        });
        
    }
    
//MARK: interactive transaction delegate
    func startInteractiveTransition(transitionContext: UIViewControllerContextTransitioning){
        
        self._context=transitionContext
        
        
        self.animationBlock?(transactionContext: self._context!, animationTime: self.duration!, transitionCompletion: { () -> Void in
            
         
            
        });
    }
    
//MARK: navigation controller delegate
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
     
    
       return self
    }
    
    
    
    
    func  navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return self.isInteractive ? self : nil;
        
    }
}
