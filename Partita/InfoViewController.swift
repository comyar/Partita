//
//  InfoViewController.swift
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
import BFPaperButton
import AMWaveTransition
import PodsLicenseReader


// MARK:- LicenseViewController

private class LicenseViewController: UIViewController {
    
    var license: License?
    
    private var textView: UITextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView = UITextView(frame: CGRect(x: 0.0, y: 82.0, width: CGRectGetWidth(view.bounds), height: CGRectGetHeight(view.bounds) - 82))
        textView?.font = UIFont.systemFontOfSize(16, weight: UIFontWeightLight)
        textView?.textContainerInset = UIEdgeInsets(top: 0.0, left: 8.0, bottom: 8.0, right: 8.0)
        textView?.backgroundColor = UIColor.clearColor()
        textView?.textColor = UIColor.whiteColor()
        textView?.selectable = false
        textView?.scrollEnabled = true
        textView?.showsHorizontalScrollIndicator = false
        textView?.showsVerticalScrollIndicator = false
        textView?.allowsEditingTextAttributes = false
        textView?.alwaysBounceHorizontal = false
        
        view.addSubview(textView!)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let l = license {
            textView?.text = l.text
        }
        textView?.contentOffset = CGPointZero
    }
}


// MARK:- InfoTableViewController

private class InfoTableViewController: AMWaveViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - InfoHeaderView
    
    private class InfoHeaderView: UITableViewHeaderFooterView {
        
        let label = UILabel()
        
        override init(reuseIdentifier: String?) {
            label.textColor = UIColor(white: 1.0, alpha: 0.5)
            label.backgroundColor = UIColor.clearColor()
            super.init(reuseIdentifier: reuseIdentifier)
            contentView.backgroundColor = UIColor.clearColor()
            addSubview(label)
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private override func layoutSubviews() {
            super.layoutSubviews()
            label.frame = bounds
        }
    }
    
    // MARK: Properties
    
    private static let licenses = PodsLicenseReader().getLicenses()
    private static let licenseViewController = LicenseViewController()
    
    private let tableView = UITableView(frame: CGRectZero, style: .Grouped)
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor.clearColor()
        tableView.frame = CGRect(x: 0.0, y: 80.0, width: CGRectGetWidth(view.bounds), height: CGRectGetHeight(view.bounds) - 80)
        tableView.registerClass(InfoHeaderView.self, forHeaderFooterViewReuseIdentifier: "headerFooterView")
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.clearColor()
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    //  MARK: AMWaveTransion
    
    override func visibleCells() -> [AnyObject]! {
        var cells: [AnyObject] = tableView.visibleCells
        if let header = tableView.headerViewForSection(0) {
            cells.insert(header, atIndex: 0)
        }
        if let header = tableView.headerViewForSection(1) {
            cells.insert(header, atIndex: 2)
        }
        return cells
    }
    
    // MARK: UITableViewDataSource
    
    @objc func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = nil
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCellWithIdentifier("creditCell")
            if cell == nil {
                cell = UITableViewCell(style: .Default, reuseIdentifier: "creditCell")
                cell?.textLabel?.textColor = UIColor.whiteColor()
                cell?.backgroundColor = UIColor.clearColor()
                cell?.textLabel?.text = "Created by Comyar Zaheri"
                cell?.selectionStyle = .None
            }
        } else {
            cell = tableView.dequeueReusableCellWithIdentifier("licenseCell")
            if cell == nil {
                cell = UITableViewCell(style: .Default, reuseIdentifier: "licenseCell")
                cell?.textLabel?.textColor = UIColor.whiteColor()
                cell?.backgroundColor = UIColor.clearColor()
                cell?.accessoryType = .DisclosureIndicator
            }
            let license = InfoTableViewController.licenses[indexPath.row]
            cell?.textLabel?.text = license.name
        }
        return cell!
    }
    
    @objc func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
    @objc func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    @objc func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : InfoTableViewController.licenses.count
    }
    
    // MARK: UITableViewDelegate
    
    @objc func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section > 0 {
            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                cell.setSelected(false, animated: true)
                InfoTableViewController.licenseViewController.license = InfoTableViewController.licenses[indexPath.row]
                self.navigationController?.pushViewController(InfoTableViewController.licenseViewController, animated: true)
            }
        }
    }
    
    @objc func tableView(tableView: UITableView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section > 0 {
            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                cell.setSelected(false, animated: true)
            }
        }
    }
    
    @objc func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var header = tableView.dequeueReusableHeaderFooterViewWithIdentifier("infoHeaderView")
        if header == nil {
            header = InfoHeaderView(reuseIdentifier: "infoHeaderView")
            (header as! InfoHeaderView).label.text = section == 0 ? "   CREDITS" : "   LICENSES"
        }
        return header
    }
}


// MARK:- InfoViewController

class InfoViewController: UIViewController {
    
    // MARK: Properties
    
    private let closeButton: BFPaperButton
    private let infoTableViewController: InfoTableViewController
    private let navigationViewController: UINavigationController
    
    // MARK: Creating an InfoViewController
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        closeButton = BFPaperButton(raised: true)
        infoTableViewController = InfoTableViewController()
        navigationViewController = UINavigationController(rootViewController: infoTableViewController)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationViewController.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(32.0, weight: UIFontWeightLight), NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationViewController.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationViewController.navigationBar.tintColor = UIColor.whiteColor()
        navigationViewController.navigationBar.backgroundColor = UIColor.clearColor()
        navigationViewController.automaticallyAdjustsScrollViewInsets = false
        navigationViewController.view.backgroundColor = UIColor.clearColor()
        navigationViewController.navigationBar.shadowImage = UIImage()
        navigationViewController.navigationBar.translucent = true
        addChildViewController(navigationViewController)
        view.addSubview(navigationViewController.view)
        
        closeButton.frame = CGRect(x: CGRectGetWidth(view.bounds) - 54, y: 30, width: 44, height: 44)
        closeButton.addTarget(self, action: "didTouchUpInsideButton:", forControlEvents: .TouchUpInside)
        closeButton.cornerRadius = CGRectGetWidth(closeButton.bounds) / 2.0
        closeButton.setTitleColor(UIColor.textColor(), forState: .Normal)
        closeButton.backgroundColor = UIColor.whiteColor()
        closeButton.setTitle("X", forState: .Normal)
        closeButton.rippleBeyondBounds = true
        view.addSubview(closeButton)
        
        let navigationLineView = UIView(frame: CGRect(x: 0.0, y: 80.0, width: CGRectGetWidth(view.bounds), height: 0.5))
        navigationLineView.backgroundColor = UIColor(white: 1.0, alpha: 0.75)
        view.addSubview(navigationLineView)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    // MARK: UIButton
    
    func didTouchUpInsideButton(button: UIButton) {
        if (button == closeButton) {
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
