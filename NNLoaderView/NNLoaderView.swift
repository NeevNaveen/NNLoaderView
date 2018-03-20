//
//  NNLoaderView.swift
//  NNLoaderView
//
//  Created by Successive Software on 3/16/18.
//  Copyright © 2018 Successive Software. All rights reserved.
//

import UIKit

enum LoadingAnimation: Int {
    case scale               =  1
    case fadeInOutLenear     =  2
    case bounce              =  3
    case changeColor         =  4
}


class NNLoaderView: NSObject {

    fileprivate var container:     UIView!;
    fileprivate var transparentView:     UIView!;
    fileprivate var circleSpacing: Int       = 10;
    
    var circleCount:   Int       = 5;
    var circleRadius:  Int       = 10;
    var circleColor:   UIColor   = UIColor.orange;
    var changeColor:   UIColor   = UIColor.magenta;
    var frequency:     Double    = 0.5;
    var message:       String    = "Loading Message ...";
    
    
    var animationType: LoadingAnimation = .scale;
    
    fileprivate var isLoading: Bool = false;
    fileprivate var circleArray = [UIView]();
    fileprivate var counter = 0;
    
    open class var shared: NNLoaderView {
        struct Static {
            static let instance: NNLoaderView = NNLoaderView();
        }
        return Static.instance;
    }
}


/*
 ////////////////////////////////////////////////////////////////////////////////////////////
 P U B L I C    M E T H O D S
 ////////////////////////////////////////////////////////////////////////////////////////////
 */
extension NNLoaderView {
    func show(inView: UIView!) {
        
        circleSpacing = circleRadius ;
        
        let w = circleSpacing * (circleCount + 1) + (circleCount * circleRadius * 2);
        var h = circleRadius * 4;
        
        transparentView = UIView.init(frame: inView.bounds);
        transparentView.backgroundColor = UIColor.clear;
        transparentView.isUserInteractionEnabled = true;
        
        container = UIView.init(frame: inView.bounds);
        container.backgroundColor = UIColor.clear;
        
        if message != "no message" && message.count > 0 {
            h += 1;
            let messageLbl = UILabel.init(frame: CGRect(x:0,y:h,width:w,height:20));
            messageLbl.numberOfLines = 0;
            messageLbl.text = message;
            messageLbl.font = UIFont.init(name: "Avenir-MediumOblique", size: 17);
            messageLbl.textAlignment = .center;
            messageLbl.textColor = UIColor.darkGray;
            messageLbl.sizeToFit();
            
            h += Int(messageLbl.frame.size.height + 1.0);
            
            var f = messageLbl.frame;
            f.origin.x = CGFloat(w / 2) - CGFloat(f.size.width / 2);
            messageLbl.frame = f;
            container.addSubview(messageLbl);
        }
        
        container.frame = CGRect(x:Int(inView.frame.size.width / 2 - CGFloat(w / 2)),y:Int(inView.frame.size.height / 2 - CGFloat(h / 2)),width:w,height:h);
        
        
        transparentView.addSubview(container);
        inView.addSubview(transparentView);
        
        initializeLoaderView();
    }
    
    func remove ()
    {
        UIView.animate(withDuration: 0.001, delay: 0.0, options: [.beginFromCurrentState], animations: {
            print("Removing Loading View");
        }, completion: {
            (complete: Bool) -> Void in
        });
        
        self.circleArray.removeAll();
        self.isLoading = false;
        self.counter = 0;
        for v in self.container.subviews {
            v.alpha = 1.0;
        }
        self.container.removeFromSuperview();
        self.transparentView.removeFromSuperview();
        
        self.container = nil;
        self.transparentView = nil;
        
    }
}




/*
 ////////////////////////////////////////////////////////////////////////////////////////////
 P R I V A T  E    M E T H O D S
 ////////////////////////////////////////////////////////////////////////////////////////////
 */
extension NNLoaderView {
    
    fileprivate func initializeLoaderView () {
        
        isLoading = true;
        
        for i in 0..<circleCount {
            
            let x = (i+1) * circleSpacing + (i * (circleRadius * 2));
            let frame = CGRect(x:x,y:circleRadius,width:circleRadius*2,height:circleRadius*2);
            
            let circle = UIView.init(frame: frame);
            circle.backgroundColor = circleColor;
            circle.layer.cornerRadius = CGFloat(circleRadius);
            
            circleArray.append(circle);
            container.addSubview(circle);
        }
        
        performAnimation();
    }
    
    fileprivate func performAnimation () {
        
        if !isLoading {
            return;
        }
        
        switch animationType
        {
        case .scale:
            frequency = 0.5;
            scaleAnimation();
            break
            
        case .fadeInOutLenear:
            frequency = 0.2;
            fadeInOutLenearAnimation();
            break
            
        case .bounce:
            frequency = 0.3;
            bounceAnimation();
            break
            
        case .changeColor:
            frequency = 0.2;
            changeColorAnimation();
            break
        }
    }
    
    
    // ------------------ A N I M AT I O  N      M E T H O D S  ------------------//
    
    
    fileprivate func scaleAnimation ()
    {
        if !isLoading {
            return;
        }
        
        if counter < circleArray.count
        {
            print("Counter == \(counter)");
            let circle = circleArray[counter];
            UIView.animate(withDuration: frequency, delay: 0.0, options: .curveEaseIn, animations: { () -> Void in
                circle.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }, completion: { (completed: Bool) -> Void in
                
                if completed
                {
                    if self.isLoading  && self.circleArray.count > 0
                    {
                        self.counter += 1;
                        self.scaleAnimation();
                        
                        UIView.animate(withDuration: self.frequency * 0.8, delay: 0.1, options: .curveEaseOut, animations: { () -> Void in
                            circle.transform = CGAffineTransform.identity
                        }, completion: { (completed: Bool) -> Void in
                            
                        });
                    }
                }
                
            });
        }
        else
        {
            if self.isLoading && circleArray.count > 0
            {
                print("Restart Counter == \(counter)");
                counter = 0;
                performAnimation();
            }
        }
    }
    
    
    fileprivate func fadeInOutLenearAnimation ()
    {
        
        if !isLoading {
            return;
        }
        
        if counter < circleArray.count
        {
            print("Counter == \(counter)");
            let circle = circleArray[counter];
            UIView.animate(withDuration: frequency, delay: 0.0, options: .curveEaseIn, animations: { () -> Void in
                circle.alpha = 0.1;
            }, completion: { (completed: Bool) -> Void in
                
                if completed
                {
                    if self.isLoading
                    {
                        self.counter += 1;
                        self.fadeInOutLenearAnimation();
                    }
                    UIView.animate(withDuration: self.frequency * 0.8, delay: 0.1, options: .curveEaseOut, animations: { () -> Void in
                        circle.transform = CGAffineTransform.identity
                    }, completion: { (completed: Bool) -> Void in
                        circle.alpha = 1.0;
                    });
                }
                
            });
        }
        else
        {
            if self.isLoading {
                print("Restart Counter == \(counter)");
                counter = 0;
                performAnimation();
            }
        }
    }
    
    
    fileprivate func bounceAnimation ()
    {
        if !isLoading {
            return;
        }
        
        if counter < circleArray.count
        {
            print("Counter == \(counter)");
            let circle = circleArray[counter];
            UIView.animate(withDuration: frequency, delay: 0.0, options: .curveEaseIn, animations: { () -> Void in
                
                circle.center.y = circle.center.y - CGFloat(self.circleRadius);
                
            }, completion: { (completed: Bool) -> Void in
                
                if completed
                {
                    if self.isLoading
                    {
                        self.counter += 1;
                        self.bounceAnimation();
                    }
                    UIView.animate(withDuration: self.frequency * 0.8, delay: 0.1, options: .curveEaseOut, animations: { () -> Void in
                        circle.center.y = circle.center.y + CGFloat(self.circleRadius);
                    }, completion: { (completed: Bool) -> Void in
                        
                    });
                }
            });
        }
        else
        {
            if self.isLoading {
                print("Restart Counter == \(counter)");
                counter = 0;
                performAnimation();
            }
        }
        
    }
    
    
    fileprivate func changeColorAnimation ()
    {
        if !isLoading {
            return;
        }
        
        if counter < circleArray.count
        {
            print("Counter == \(counter)");
            let circle = circleArray[counter];
            UIView.animate(withDuration: frequency, delay: 0.0, options: .curveEaseIn, animations: { () -> Void in
                circle.backgroundColor = self.changeColor;
            }, completion: { (completed: Bool) -> Void in
                
                if completed
                {
                    if self.isLoading
                    {
                        self.counter += 1;
                        self.changeColorAnimation();
                    }
                    UIView.animate(withDuration: self.frequency * 0.8, delay: 0.1, options: .curveEaseOut, animations: { () -> Void in
                        circle.backgroundColor = self.circleColor;
                    }, completion: { (completed: Bool) -> Void in
                        
                    });
                }
            });
        }
        else
        {
            if self.isLoading {
                print("Restart Counter == \(counter)");
                counter = 0;
                performAnimation();
            }
        }
        
    }
}








extension UIView {
    /**
     Zoom in any view with specified offset magnification.
     
     - parameter duration:     animation duration.
     - parameter easingOffset: easing offset.
     */
    func zoomInWithEasing(duration: TimeInterval = 0.2, easingOffset: CGFloat = 0.2) {
        let easeScale = 1.0 + easingOffset
        let easingDuration = TimeInterval(easingOffset) * duration / TimeInterval(easeScale)
        let scalingDuration = duration - easingDuration
        UIView.animate(withDuration: scalingDuration, delay: 0.0, options: .curveEaseIn, animations: { () -> Void in
            self.transform = CGAffineTransform(scaleX: easeScale, y: easeScale)
        }, completion: { (completed: Bool) -> Void in
            UIView.animate(withDuration: easingDuration, delay: 0.0, options: .curveEaseOut, animations: { () -> Void in
                self.transform = CGAffineTransform.identity
            }, completion: { (completed: Bool) -> Void in
            })
        })
    }
    
    /**
     Zoom out any view with specified offset magnification.
     - parameter duration:     animation duration.
     - parameter easingOffset: easing offset.
     */
    func zoomOutWithEasing(duration: TimeInterval = 0.2, easingOffset: CGFloat = 0.2) {
        let easeScale = 1.0 + easingOffset
        let easingDuration = TimeInterval(easingOffset) * duration / TimeInterval(easeScale)
        let scalingDuration = duration - easingDuration
        UIView.animate(withDuration: easingDuration, delay: 0.0, options: .curveEaseOut, animations: { () -> Void in
            self.transform = CGAffineTransform(scaleX: easeScale, y: easeScale)
        }, completion: { (completed: Bool) -> Void in
            UIView.animate(withDuration: scalingDuration, delay: 0.0, options: .curveEaseOut, animations: { () -> Void in
                self.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
            }, completion: { (completed: Bool) -> Void in
            })
        })
    }
}







