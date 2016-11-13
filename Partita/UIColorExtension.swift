//
//  UIColorExtension.swift
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


// MARK:- UIColor

extension UIColor {
    
    class func backgroundColor() -> UIColor {
        return partitaLightGrayColor()
    }
    
    class func textColor() -> UIColor {
        return partitaDarkBlueColor()
    }
    
    class func titleColor() -> UIColor {
        return partitaRedColor()
    }
    
    class func actionButtonColor() -> UIColor {
        return partitaRedColor()
    }
    
    class func authorizedColor() -> UIColor {
        return partitaGreenColor()
    }
    
    class func unauthorizedColor() -> UIColor {
        return partitaRedColor()
    }
    
    class func infoBackgroundColor() -> UIColor {
        return partitaDarkBlueColor()
    }
    
    class func rgba(_ r: Float, _ g: Float, _ b: Float, _ a: Float) -> UIColor {
        return UIColor(red: CGFloat(r/255.0), green: CGFloat(g/255.0), blue: CGFloat(b/255.0), alpha: CGFloat(a))
    }
    
    class func partitaGreenColor() -> UIColor {
        return rgba(97, 255, 104, 1.0)
    }
    
    class func partitaRedColor() -> UIColor {
        return rgba(255, 104, 97, 1.0)
    }
    
    class func partitaDarkBlueColor() -> UIColor {
        return rgba(68, 84, 105, 1.0)
    }
    
    class func partitaLightGrayColor() -> UIColor {
        return rgba(238, 238, 238, 1.0)
    }
}
