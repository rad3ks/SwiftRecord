Pod::Spec.new do |s|
  s.name         = "SwiftRecord"
  s.version      = "0.0.1"
  s.summary      = "ActiveRecord for Swift"

  s.description  = <<-DESC
			The desc
                   DESC

  s.homepage     = "https://github.com/arkverse/SwiftRecord"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Zaid Daghestani" => "zaid@arkverse.com" }
  s.social_media_url   = "http://twitter.com/arkverse"
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.source       = { :git => "https://github.com/arkverse/SwiftRecord.git", :commit => "6961ea87f37ba6aaaa85e843d20118e39db57624" }
  s.source_files  = "Classes", "Classes/**/*.{swift}"
  s.requires_arc = true
end
