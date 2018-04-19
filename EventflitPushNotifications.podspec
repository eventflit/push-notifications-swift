Pod::Spec.new do |s|
  s.name             = 'EventflitPushNotifications'
  s.version          = '0.1.0'
  s.summary          = 'Eventflit PushNotifications SDK'
  s.homepage         = 'https://github.com/eventflit/push-notifications-swift'
  s.license          = 'MIT'
  s.author           = { "Eventflit" => "support@eventflit.com" }
  s.source           = { git: "https://github.com/eventflit/push-notifications-swift.git", tag: s.version.to_s }
  s.social_media_url = 'https://twitter.com/eventflit'
  s.documentation_url = 'https://eventflit.github.io/push-notifications-swift/Classes/PushNotifications.html'

  s.requires_arc = true
  s.source_files = 'Sources/*.swift'

  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.10'
end
