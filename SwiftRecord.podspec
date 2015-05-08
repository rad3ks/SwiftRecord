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
  s.ios.deployment_target = "7.0"
  s.osx.deployment_target = "10.7"
  s.source       = { :git => "https://github.com/arkverse/SwiftRecord.git", :commit => "f820a3f68c3410ea5abe392340ec1dc2758742c3" }
  s.source_files  = "Classes", "Classes/**/*.{swift}"
  s.requires_arc = true
end
