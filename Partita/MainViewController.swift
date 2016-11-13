
//
//  TunerViewController.swift
//  Partita
//
//  Copyright (c) 2015 Comyar Zaheri. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to
//  deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
//  IN THE SOFTWARE.
//


// MARK:- Imports

import UIKit
import TuningFork
import BFPaperButton
import PermissionScope
import BubbleTransition
import PodsLicenseReader


// MARK:- MainViewController

class MainViewController: UIViewController, UIViewControllerTransitioningDelegate, TunerDelegate {

    // MARK: Properties
    
    fileprivate var tuner: Tuner?
    fileprivate var tunerView: TunerView?
    fileprivate var infoButton: BFPaperButton?
    fileprivate var infoViewController: InfoViewController?

    fileprivate var running = false
    fileprivate let transition = BubbleTransition()
    fileprivate let permissions = PermissionScope()
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        permissions.addPermission(MicrophonePermission(), message: "Partita would like to use your microphone.")
        permissions.closeButtonTextColor = UIColor.actionButtonColor()
        permissions.authorizedButtonColor = UIColor.authorizedColor()
        permissions.unauthorizedButtonColor = UIColor.unauthorizedColor()
        permissions.headerLabel.textColor = UIColor.textColor()
        permissions.bodyLabel.textColor = UIColor.textColor()
        permissions.permissionLabelColor = UIColor.textColor()
        
        tunerView = TunerView(frame: view.frame)
        tunerView?.actionButton.addTarget(self, action: #selector(MainViewController.didTouchUpInsideButton(_:)), for: .touchUpInside)
        view.addSubview(tunerView!)
        
        infoButton = BFPaperButton(frame: CGRect(x: (view.bounds).width - 54, y: 30, width: 44, height: 44), raised: true)
        infoButton?.addTarget(self, action: #selector(MainViewController.didTouchUpInsideButton(_:)), for: .touchUpInside)
        infoButton?.cornerRadius = (infoButton!.bounds).width / 2.0
        infoButton?.setTitleColor(UIColor.white, for: .normal)
        infoButton?.backgroundColor = UIColor.partitaDarkBlueColor()
        infoButton?.setTitle("i", for: .normal)
        infoButton?.rippleBeyondBounds = true
        view.addSubview(infoButton!)
        
        tuner = Tuner()
        tuner?.delegate = self
    }
    
    // MARK: Tuner Controls
    
    func startTuner() {
        if !running {
            running = true
            tuner?.start()
            tunerView?.actionButton.setTitle("Stop", for: .normal)
            tunerView?.actionButton.backgroundColor = UIColor.partitaDarkBlueColor()
        }
    }
    
    func stopTuner() {
        if running {
            running = false
            tuner?.stop()
            tunerView?.gaugeView.value = 0.0
            tunerView?.pitchLabel.text = "--"
            tunerView?.actionButton.setTitle("Start", for: .normal)
            tunerView?.actionButton.backgroundColor = UIColor.actionButtonColor()
        }
    }
    
    // MARK: TunerDelegate
    
    func tunerDidUpdate(_ tuner: Tuner, output: TunerOutput) {
        if output.amplitude < 0.01 {
            tunerView?.gaugeView.value = 0.0
            tunerView?.pitchLabel.text = "--"
        } else {
            tunerView?.pitchLabel.text = output.pitch + "\(output.octave)"
            tunerView?.gaugeView.value = Float(output.distance)
        }
    }
    
    // MARK: UIButton
    
    func didTouchUpInsideButton(_ button: UIButton) {
        if button == tunerView?.actionButton {
            if running {
                stopTuner()
            } else {
                if permissions.statusMicrophone() == .authorized {
                    self.startTuner()
                } else {
                    permissions.show({ (finished, results) -> Void in
                        let result = results.filter({ $0.type == .microphone })[0]
                        if result.status != .authorized {
                            self.showMicrophoneAccessAlert()
                        }
                    }, cancelled: { (results) -> Void in
                            self.showMicrophoneAccessAlert()
                    })
                }
            }
        } else if button == infoButton {
            infoViewController = InfoViewController()
            infoViewController?.transitioningDelegate = self
            infoViewController?.modalPresentationStyle = .custom
            self.present(infoViewController!, animated: true, completion: nil)
        }
    }
    
    // MARK: UIViewControllerTransitioningDelegate
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.duration = 0.3
        transition.transitionMode = .present
        transition.startingPoint = infoButton!.center
        transition.bubbleColor = UIColor.infoBackgroundColor()
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.duration = 0.3
        transition.transitionMode = .dismiss
        transition.startingPoint = infoButton!.center
        transition.bubbleColor = UIColor.infoBackgroundColor()
        return transition
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .default
    }
    
    // MARK: Private
    
    fileprivate func showMicrophoneAccessAlert() {
        let alert = UIAlertController(title: "Microphone Access", message: "Partita requires access to your microphone; please enable access in your device's settings.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
