#
# Be sure to run `pod lib lint ForcedUpgrade.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ForcedUpgrade'
  s.version          = '0.1.0'
  s.summary          = 'Force upgrade app interact with cloud service.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
As I want to improve customer experience, I need to make sure that the customer uses the correct version. 
So that, define the json object to be used in project, check the properties to determine whether force or not.
In case that others have same requirements, I create the library. Then enjoy !
                       DESC

  s.homepage         = 'https://github.com/Smart-XiaoLeiGe/ForcedUpgrade-Pod'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Lei' => 'wanglei_sh163@163.com' }
  s.source           = { :git => 'https://github.com/Smart-XiaoLeiGe/ForcedUpgrade-Pod.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'

  s.source_files = 'ForcedUpgrade/Classes/**/*'
  s.swift_versions = '5.0'
  
  # s.resource_bundles = {
  #   'ForcedUpgrade' => ['ForcedUpgrade/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'SwiftUI'
  s.dependency 'SwiftyJSON', '5.0.0'

end
