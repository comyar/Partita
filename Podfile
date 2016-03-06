source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '9.0'
inhibit_all_warnings!
use_frameworks!

pod 'AMWaveTransition', '~> 0.6.2'
pod 'PodsLicenseReader', '~> 0.0.3'
pod 'PermissionScope', '~> 1.0.2'
pod 'BubbleTransition', '~> 1.0.1'
pod 'BFPaperButton', '~> 2.0.18'
pod 'WMGaugeView', '~> 0.0.3'
pod 'TuningFork', '~> 0.1.1'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ENABLE_BITCODE'] = 'NO'
    end
  end
end

