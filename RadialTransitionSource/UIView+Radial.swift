//
//  UIView+Radial.swift
//  AAPRadialTransaction_swift
//
//  Created by Alex Padalko on 9/23/14.
//  Copyright (c) 2014 Alex Padalko. All rights reserved.
//

import UIKit



class LayerAnimator : NSObject{
    
    var complitionBlock:(()->Void)?
    var animLayer:CALayer?
    var caAnimation:CAAnimation?
    
    
    init(layer: CALayer , animation:CAAnimation) {
        
        self.caAnimation=animation;
        self.animLayer=layer;
      
        
        
    }
    
    func startAnimationWithBlock(block:(()->Void)){
          self.caAnimation?.delegate=self
        self.complitionBlock=block;
        
        self.animLayer?.addAnimation(self.caAnimation, forKey: "anim")
    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        self.complitionBlock?()
    }
    
    
}








extension  UIView {


    
    
    func radialAppireanceWithStartFrame(startFrame:CGRect,duration: CGFloat,complitBlock:()->Void ){
        
        
        let maskLayer = CAShapeLayer()
        let maskRect = startFrame
        let path = CGPathCreateWithEllipseInRect(maskRect, nil)
        maskLayer.path=path
        
        let d = sqrt(pow(self.frame.size.width, 2)+pow(self.frame.size.height, 2) )*2
        
        let newRect = CGRectMake(self.frame.size.width/2-d/2, maskRect.origin.y-d/2, d, d)
        
        let newPath = CGPathCreateWithEllipseInRect(newRect, nil)
        
        self.layer.mask = maskLayer;
        
        
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
    
    func radialDissmisWithStartFrame(startFrame:CGRect,duration: CGFloat,complitBlock:()->Void ){
        
        
        let maskLayer = CAShapeLayer()
        let maskRect = startFrame
        let path = CGPathCreateWithEllipseInRect(maskRect, nil)
        maskLayer.path=path
        
        let d = sqrt(pow(self.frame.size.width, 2)+pow(self.frame.size.height, 2) )*2
        
        let newRect = CGRectMake(self.frame.size.width/2-d/2, maskRect.origin.y-d/2, d, d)
        
        let newPath = CGPathCreateWithEllipseInRect(newRect, nil)
        
        self.layer.mask = maskLayer;
        
        
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
    
    

    
    
    
    

}
