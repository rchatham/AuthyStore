Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.name         = "AuthyStore"
  s.version      = "0.0.1"
  s.summary      = "Two factor authentication with Authy"
  s.description  = <<-DESC
                    Light swift wrapper for Authy's SMS authentication service.
                   DESC

  s.homepage     = "https://github.com/rchatham/AuthyStore"

  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.license      = "MIT"

  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.author       = { "Reid Chatham" => "reid.chatham@gmail.com" }

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.platform     = :ios, "8.0"

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.source       = { :git => "https://github.com/rchatham/AuthyStore.git", :tag => "#{s.version}" }
  s.source_files  = "Sources", "Sources/*"

end
