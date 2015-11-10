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
    
    private let titleLabel: UILabel
    private let pitchTitleLabel: UILabel
    
    // MARK: Creating a TunerView
    
    override init(frame: CGRect) {
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFontOfSize(32, weight: UIFontWeightLight)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textColor = UIColor.textColor()
        titleLabel.textAlignment = .Center
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
        gaugeView.backgroundColor = UIColor.clearColor()
        gaugeView.needleStyle = WMGaugeViewNeedleStyleFlatThin
        gaugeView.needleScrewStyle = WMGaugeViewNeedleScrewStylePlain
        gaugeView.innerBackgroundStyle = WMGaugeViewInnerBackgroundStyleFlat
        gaugeView.scalesubdivisionsaligment = WMGaugeViewSubdivisionsAlignmentCenter
        gaugeView.scaleFont = UIFont.systemFontOfSize(0.05, weight: UIFontWeightUltraLight)
        
        pitchTitleLabel = UILabel()
        pitchTitleLabel.font = UIFont.systemFontOfSize(24, weight: UIFontWeightLight)
        pitchTitleLabel.adjustsFontSizeToFitWidth = true
        pitchTitleLabel.textColor = UIColor.textColor()
        pitchTitleLabel.textAlignment = .Center
        pitchTitleLabel.text = "Pitch"
        
        pitchLabel = UILabel()
        pitchLabel.font = UIFont.systemFontOfSize(32, weight: UIFontWeightLight)
        pitchLabel.adjustsFontSizeToFitWidth = true
        pitchLabel.textColor = UIColor.textColor()
        pitchLabel.textAlignment = .Center
        pitchLabel.text = "--"
        
        actionButton = BFPaperButton(raised: false)
        actionButton.setTitle("Start", forState: .Normal)
        actionButton.backgroundColor = UIColor.actionButtonColor()
        actionButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        actionButton.setTitleColor(UIColor(white: 1.0, alpha: 0.5), forState: .Highlighted)
        
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
        titleLabel.frame = CGRect(x: 0.0, y: 30, width: CGRectGetWidth(bounds), height: CGRectGetHeight(bounds) / 18.52)
        gaugeView.frame = CGRect(x: 0, y: (CGRectGetHeight(bounds) - CGRectGetWidth(bounds)) / 2.0, width: CGRectGetWidth(bounds), height: CGRectGetWidth(bounds))
        pitchTitleLabel.frame = CGRect(x: 0, y: gaugeView.frame.origin.y + 0.85 * CGRectGetHeight(gaugeView.bounds), width: CGRectGetWidth(bounds), height: CGRectGetHeight(bounds) / 23.82)
        pitchLabel.frame = CGRect(x: 0, y: pitchTitleLabel.frame.origin.y + CGRectGetHeight(pitchTitleLabel.frame), width: CGRectGetWidth(bounds), height: CGRectGetHeight(bounds) / 18.52)
        actionButton.frame = CGRect(x: 0, y: CGRectGetHeight(bounds) - 55, width: CGRectGetWidth(bounds), height: 55)
        actionButton.tapCircleDiameter = 0.75 * CGRectGetWidth(bounds)
    }
}
