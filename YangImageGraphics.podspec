Pod::Spec.new do |s|
s.name         = "YangImageGraphics"
s.version      = "0.0.1"
s.summary      = "A test.”
s.homepage     = "https://github.com/78084367/YangImageGraphics"
s.license      = { :type => "MIT", :file => 'LICENSE' }
s.author       = { “YouYang” => “78084367@qq.com" }
s.platform     = :ios, "8.0"
s.source       = { :git => "https://github.com/78084367/YangImageGraphics.git", :tag => s.version}
s.frameworks   = 'UIKit'
s.source_files = “Classes/*.{h,m}”
#s.resource     = "iOS/Resources/**"
s.requires_arc = true
end
