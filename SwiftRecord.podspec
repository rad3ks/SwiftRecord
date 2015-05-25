Pod::Spec.new do |s|
  s.name         = "SwiftRecord"
  s.version      = "0.0.2"
  s.summary      = "ActiveRecord for Swift"

  s.description  = <<-DESC
			ActiveRecord style Core Data object management. Tremendously convenient and easy to use. Necessary for any and every Core Data project.

Written purely in Swift and based heavily on [ObjectiveRecord](https://github.com/supermarin/ObjectiveRecord)

This library also reads in your json dictionaries for you. Includes automatic camelCase changing ie `first_name` from server to `firstName` locally. You can customize the dictionary mapping to, read the mapping section. Relationship objects are also generated, but disabled by default. Set `SwiftRecord.generateRelationships` to true to enable this feature
                   DESC

  s.homepage     = "https://github.com/arkverse/SwiftRecord"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Zaid Daghestani" => "zaid@arkverse.com" }
  s.social_media_url   = "http://twitter.com/arkverse"
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.source       = { :git => "https://github.com/arkverse/SwiftRecord.git", :tag => "v#{s.version}" }
  s.source_files  = "Classes", "Classes/**/*.{swift}"
  s.requires_arc = true
end
