RadialTransition_swift
=====================

Great ios radial transition for navigation controller, with custom back swipe.


Demo
----
![alt tag](https://raw.githubusercontent.com/apadalko/RadialTransition_objC/master/radilaDemo_long.gif)


Usage 
----

for push simple use
```  swift
   self.navigationController?.radialPushViewController(SecondViewController(nibName: "SecondViewController", bundle: nil),startFrame: CGRectMake(self.view.frame.size.width, 0, 0, 0),duration:0.9,transitionCompletion: { () -> Void in
   
   })
```
for pop  use
```  swift
    self.navigationController?.radialPopViewController(startFrame:CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height, 0, 0),duration: 0.9,transitionCompletion: { () -> Void in
            
   })
```
to enable swipe to back just use
```  swift
self.navigationController?.enableRadialSwipe()
  
```
to disable
```  swift
self.navigationController?.disableRadialSwipe()
```
Requirements
---
ios 7 +,xcode 6+

Futher Work
---
-add TabbarController transaction
-add radial circle options (shadow,color etc)
-other improvements

