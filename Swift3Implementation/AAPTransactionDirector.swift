//
//  AAPTransactionDirector.swift
//  AAPRadialTransaction_swift
//
//  Created by Alex Padalko on 9/23/14.
//  Copyright (c) 2014 Alex Padalko. All rights reserved.
//
//  Converted to Swift 3 by Ben Sullivan on 08/27/16

import UIKit

class AAPTransactionDirector: NSObject, UIViewControllerAnimatedTransitioning, UINavigationControllerDelegate, UIViewControllerInteractiveTransitioning {
  
  private var _context: UIViewControllerContextTransitioning?
  
  /**
   * animation block.Use transactionContext to get all needed views. toViewController will be above. NOTE: if you use it for animation without interactive YOU MUST RUN complitBlock at end.
   *
   */
  lazy var animationBlock:((_ transactionContext: UIViewControllerContextTransitioning, _ animationTime: CGFloat, _ transitionCompletion: @escaping () -> Void) -> Void)? = nil
  /**
   * interactive update block.Use transactionContext to get all needed views.updating after percent changing
   *
   */
  lazy var interactiveUpdateBlock:((_ transactionContext:UIViewControllerContextTransitioning, _ percent: CGFloat)->Void)? = nil
  
  lazy var interactiveEndBlock: ( () -> Void )? = nil
  
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
      
      self._context?.containerView.layer.timeOffset = CFTimeInterval(_percent*self.duration!)
      if (self._context != nil) {
        
        self.interactiveUpdateBlock?(_context!,_percent)
        
      }
    }
    
  }
  
  var timeOffset:CFTimeInterval{
    
    get {
      return self._context!.containerView.layer.timeOffset
    }
    set {
      self.precent = CGFloat(CGFloat(newValue)/self.duration!)
    }
  }
  
  //MARK: Interactive transaction ending
  /**
   * run to end interactive transaction
   *
   */
  
  func endInteractiveTranscation(canceled: Bool , endBlock: ( () -> Void) ) {
    
    self.interactiveEndBlock = endBlock
    
    if canceled {
      
      _context?.cancelInteractiveTransition()
      
      displayLink = CADisplayLink (target: self, selector: #selector(AAPTransactionDirector.updateCancelAnimation))
      
    } else {
      
      displayLink = CADisplayLink (target: self, selector: #selector(AAPTransactionDirector.updateFinishAnimation))
    }
    
    displayLink?.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
    
  }
  
  
  func updateFinishAnimation() {
    
    let offset =  CFTimeInterval(self.timeOffset) + displayLink!.duration
    
    if offset > CFTimeInterval(self.duration!) {
      
      transitionFinishedFinishing()
      
    } else {
      
      self.timeOffset = offset
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
    self._context?.containerView.layer.timeOffset=0
    displayLink?.invalidate()
    
    _context?.completeTransition(false)
    
    self.interactiveEndBlock?()
    
  }
  
  private func transitionFinishedFinishing(){
    displayLink?.invalidate()
    _context?.finishInteractiveTransition()
    _context?.completeTransition(true)
    self.interactiveEndBlock?()
    
  }
  
  
  
  //MARK: init & deinit
  
  override init() {
    
  }
  
  deinit{
    
  }
  
  //MARK: animation transaction delegate
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval{
    
    return TimeInterval(self.duration!)
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
    self._context=transitionContext
    
    self.animationBlock?(self._context!, self.duration!, { () -> Void in
      
      transitionContext.completeTransition(true)
      
    })
  }
  
  //MARK: interactive transaction delegate
  func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning){
    
    self._context=transitionContext
    self.animationBlock?(self._context!, self.duration!, { () -> Void in
      
    })
  }
  
  //MARK: navigation controller delegate
  func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    
    return self
  }
  
  func  navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    
    return self.isInteractive ? self : nil
    
  }
}
