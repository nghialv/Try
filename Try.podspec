Pod::Spec.new do |s|
  s.name         = "Try"
  s.version      = "0.0.1"
  s.summary      = "Swift µframework providing Try<T>."
  s.homepage     = "https://github.com/nghialv/Try"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "nghialv" => "nghialv2607@gmail.com" }
  s.social_media_url   = "http://twitter.com/nghialv2607"

  s.platform     = :ios
  s.ios.deployment_target = "8.0"
  s.source       = { :git => "https://github.com/nghialv/Try.git", :tag => "0.0.1" }
  s.source_files  = "Try/*.swift"
  s.requires_arc = true
end
