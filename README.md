# NNLoaderView
A simple loader view with easy customization.


# Integration: CocoaPods (iOS 11+)
  
  ```
  platform :ios, '11.0'
  use_frameworks!
  target 'MyApp' do
      pod 'NNLoaderView',  :git => 'https://github.com/NeevNaveen/NNLoaderView'
  end

  ```

# HOW TO USE

  * Set the Loader in the App Delegate's - didFinishLaunchingWithOptions
    
    ```swift
    NNLoaderView.shared.circleCount = 4;
    NNLoaderView.shared.circleRadius = 10;
    NNLoaderView.shared.circleColor = UIColor.purple;
    NNLoaderView.shared.changeColor = UIColor.cyan;
    ```
    
    Types of Animations to choose from
    
    ```swift
    NNLoaderView.shared.animationType = .scale;
    NNLoaderView.shared.animationType = .bounce;
    NNLoaderView.shared.animationType = .fadeInOutLenear;
    NNLoaderView.shared.animationType = .changeColor;
    ```
    
  * Now use it in your ViewController
    
    ```swift
        NNLoaderView.shared.show(inView: self.view); // To add the loaderview
        NNLoaderView.shared.remove(); // To remove the loaderview
    ```
    
