source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '9.0'
inhibit_all_warnings!
use_frameworks!

target 'Partita' do
  pod 'AMWaveTransition', '~> 0.6'
  pod 'PodsLicenseReader', '~> 0.0.4'
  pod 'PermissionScope', '~> 1.0'
  pod 'BubbleTransition', '~> 2.0'
  pod 'BFPaperButton', '~> 2.0'
  pod 'WMGaugeView', '~> 0.0.3'
  pod 'TuningFork', '~> 0.2.0'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ENABLE_BITCODE'] = 'NO'
    end
  end
end

