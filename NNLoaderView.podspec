Pod::Spec.new do |s|
s.name             = 'NNLoaderView'
s.version          = '0.0.3'
s.summary          = 'A activity indicator view with friendly customization where you can customize Animation and text'

s.description      = <<-DESC
This will add a custom loader with animated circles. The loader view is easy to customize. There are some animation options which you can set in the AppDelegate and use the loader across the application. Easy to add and remove.
DESC

s.homepage         = 'https://github.com/NeevNaveen/NNLoaderView'
s.license          = { :type => 'GNU', :file => 'LICENSE' }
s.author           = { 'NeevNaveen' => 'imneev@gmail.com' }
s.source           = { :git => 'https://github.com/NeevNaveen/NNLoaderView.git', :tag => s.version.to_s }
s.ios.deployment_target = '11.0'
s.source_files = 'NNLoaderView/*.swift'

end
