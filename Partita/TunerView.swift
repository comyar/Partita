//
//  TunerView.swift
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


// MARK: Imports

import UIKit
import WMGaugeView
import BFPaperButton


// MARK:- TunerView

class TunerView: UIView {
    
    // MARK: Properties
    
    let pitchLabel: UILabel
    let gaugeView: WMGaugeView
    let actionButton: BFPaperButton
    
    fileprivate let titleLabel: UILabel
    fileprivate let pitchTitleLabel: UILabel
    
    // MARK: Creating a TunerView
    
    override init(frame: CGRect) {
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: UIFontWeightLight)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textColor = UIColor.textColor()
        titleLabel.textAlignment = .center
        titleLabel.text = "Tuner"
        
        gaugeView = WMGaugeView()
        gaugeView.maxValue = 50.0
        gaugeView.minValue = -50.0
        gaugeView.needleWidth = 0.01
        gaugeView.needleHeight = 0.4
        gaugeView.scaleDivisions = 10
        gaugeView.scaleEndAngle = 270
        gaugeView.scaleStartAngle = 90
        gaugeView.scaleSubdivisions = 5
        gaugeView.showScaleShadow = false
        gaugeView.needleScrewRadius = 0.05
        gaugeView.scaleDivisionsLength = 0.05
        gaugeView.scaleDivisionsWidth = 0.007
        gaugeView.scaleSubdivisionsLength = 0.02
        gaugeView.scaleSubdivisionsWidth = 0.002
        gaugeView.backgroundColor = UIColor.clear
        gaugeView.needleStyle = WMGaugeViewNeedleStyleFlatThin
        gaugeView.needleScrewStyle = WMGaugeViewNeedleScrewStylePlain
        gaugeView.innerBackgroundStyle = WMGaugeViewInnerBackgroundStyleFlat
        gaugeView.scalesubdivisionsaligment = WMGaugeViewSubdivisionsAlignmentCenter
        gaugeView.scaleFont = UIFont.systemFont(ofSize: 0.05, weight: UIFontWeightUltraLight)
        
        pitchTitleLabel = UILabel()
        pitchTitleLabel.font = UIFont.systemFont(ofSize: 24, weight: UIFontWeightLight)
        pitchTitleLabel.adjustsFontSizeToFitWidth = true
        pitchTitleLabel.textColor = UIColor.textColor()
        pitchTitleLabel.textAlignment = .center
        pitchTitleLabel.text = "Pitch"
        
        pitchLabel = UILabel()
        pitchLabel.font = UIFont.systemFont(ofSize: 32, weight: UIFontWeightLight)
        pitchLabel.adjustsFontSizeToFitWidth = true
        pitchLabel.textColor = UIColor.textColor()
        pitchLabel.textAlignment = .center
        pitchLabel.text = "--"
        
        actionButton = BFPaperButton(raised: false)
        actionButton.setTitle("Start", for: .normal)
        actionButton.backgroundColor = UIColor.actionButtonColor()
        actionButton.setTitleColor(UIColor.white, for: .normal)
        actionButton.setTitleColor(UIColor(white: 1.0, alpha: 0.5), for: .highlighted)
        
        super.init(frame: frame)
        
        addSubview(titleLabel)
        addSubview(gaugeView)
        addSubview(pitchTitleLabel)
        addSubview(pitchLabel)
        addSubview(actionButton)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UIView
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(x: 0.0, y: 30, width: bounds.width, height: bounds.height / 18.52)
        gaugeView.frame = CGRect(x: 0, y: ((bounds).height - (bounds).width) / 2.0, width: (bounds).width, height: (bounds).width)
        pitchTitleLabel.frame = CGRect(x: 0, y: gaugeView.frame.origin.y + 0.85 * (gaugeView.bounds).height, width: (bounds).width, height: (bounds).height / 23.82)
        pitchLabel.frame = CGRect(x: 0, y: pitchTitleLabel.frame.origin.y + pitchTitleLabel.frame.height, width: bounds.width, height: bounds.height / 18.52)
        actionButton.frame = CGRect(x: 0, y: (bounds).height - 55, width: (bounds).width, height: 55)
        actionButton.tapCircleDiameter = 0.75 * (bounds).width
    }
}
