RadialTransition_swift
=====================

Great radial transition for navigation controller, with custom back swipe.


Demo
----
![alt tag](https://raw.githubusercontent.com/apadalko/RadialTransition_objC/master/radilaDemo_long.gif)


Usage 
----
just import
```  objc
#import "UINavigationController+RadialTransaction.h"
```
for push simple use
```  objc
[self.navigationController radialPushViewController:[[UIViewController alloc]init] comlititionBlock:^{
        
}];
 //or   
[self.navigationController radialPushViewController:[[UIViewController alloc]init] withDuration:1 comlititionBlock:^{
        
}];
 //or  
[self.navigationController radialPushViewController:[[UIViewController alloc]init] withDuration:1 withStartFrame:CGRectMake(self.view.frame.size.width, 0, 0, 0) comlititionBlock:^{
        
}];
```
for pop  use
```  objc
[self.navigationController radialPopViewControllerWithComlititionBlock:^{
        
}];
 //or
[self.navigationController radialPopViewControllerWithDuration:0.9 comlititionBlock:^{
        
}];
 //or   
[self.navigationController radialPopViewControllerWithDuration:0.9 withStartFrame:CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height, 0, 0) comlititionBlock:^{
        
}];
```
to enable swipe to back just use
```  objc
[self.navigationController enableRadialSwipe];
```
to disable
```  objc
[self.navigationController disableRadialSwipe];
```
if you want to change back swipe speed you may set new default duration
```  objc
[UINavigationController setDefaultRadialAnimationTime:11];
```
Requirements
---
ios 7 +,xcode 5+

Futher Work
---
-add TabbarController transaction
-add radial circle options (shadow,color etc)
-other improvements

