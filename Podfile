source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '9.0'
inhibit_all_warnings!
use_frameworks!

pod 'AMWaveTransition'
pod 'PodsLicenseReader'
pod 'PermissionScope'
pod 'BubbleTransition'
pod 'BFPaperButton'
pod 'WMGaugeView'
pod 'TuningFork'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ENABLE_BITCODE'] = 'NO'
    end
  end
end

