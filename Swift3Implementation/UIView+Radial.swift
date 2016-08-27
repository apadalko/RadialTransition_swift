//
//  UIView+Radial.swift
//  AAPRadialTransaction_swift
//
//  Created by Alex Padalko on 9/23/14.
//  Copyright (c) 2014 Alex Padalko. All rights reserved.
//
//  Converted to Swift 3 by Ben Sullivan on 08/27/16

import UIKit

class LayerAnimator: NSObject, CAAnimationDelegate {
  
  var completionBlock: ( () -> Void)?
  var animLayer: CALayer?
  var caAnimation: CAAnimation?
  
  init(layer: CALayer , animation:CAAnimation) {
    
    self.caAnimation = animation
    self.animLayer = layer
  }
  
  func startAnimationWithBlock(block: ( () -> Void) ) {
    self.caAnimation?.delegate = self
    self.completionBlock = block
    
    self.animLayer?.add(self.caAnimation!, forKey: "anim")
  }
  
  func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
    
    self.completionBlock?()
  }
}


extension  UIView {
  
  func radialAppireanceWithStartFrame(startFrame: CGRect, duration: CGFloat, complitBlock: @escaping () -> Void) {
    
    let maskLayer = CAShapeLayer()
    let maskRect = startFrame
    let path = CGPath(ellipseIn: maskRect, transform: nil)
    maskLayer.path = path
    
    let d = sqrt(pow(self.frame.size.width, 2)+pow(self.frame.size.height, 2) ) * 2
    
    let newRect = CGRect(x: self.frame.size.width / 2 - d / 2, y: maskRect.origin.y - d / 2, width: d, height: d)
    
    let newPath = CGPath(ellipseIn: newRect, transform: nil)
    
    self.layer.mask = maskLayer
    
    
    let revealAnimation = CABasicAnimation(keyPath: "path")
    revealAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
    revealAnimation.fromValue = path
    revealAnimation.toValue = newPath
    
    revealAnimation.duration =  CFTimeInterval(duration)
    
    maskLayer.path=newPath
    
    let animator:LayerAnimator = LayerAnimator(layer: maskLayer, animation: revealAnimation)
    
    animator.startAnimationWithBlock { () -> Void in
      
      complitBlock()
    }
  }
  
  func radialDissmisWithStartFrame(startFrame: CGRect, duration: CGFloat, complitBlock: @escaping () -> Void ) {
    
    let maskLayer = CAShapeLayer()
    let maskRect = startFrame
    let path = CGPath(ellipseIn: maskRect, transform: nil)
    maskLayer.path = path
    
    let d = sqrt(pow(self.frame.size.width, 2)+pow(self.frame.size.height, 2) ) * 2
    
    let newRect = CGRect(x: self.frame.size.width / 2 - d / 2, y: maskRect.origin.y - d / 2, width: d, height: d)

    let newPath = CGPath(ellipseIn: newRect, transform: nil)
    
    self.layer.mask = maskLayer
    
    let revealAnimation = CABasicAnimation(keyPath: "path")
    revealAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
    revealAnimation.fromValue = path
    revealAnimation.toValue = newPath
    
    revealAnimation.duration =  CFTimeInterval(duration)
    
    maskLayer.path = newPath
    
    let animator:LayerAnimator = LayerAnimator(layer: maskLayer, animation: revealAnimation)
    
    animator.startAnimationWithBlock { () -> Void in
      
      complitBlock()
      
    }
  }
}
