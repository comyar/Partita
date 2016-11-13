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
    
    fileprivate var textView: UITextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView = UITextView(frame: CGRect(x: 0.0, y: 82.0, width: view.bounds.width, height: view.bounds.height - 82))
        textView?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightLight)
        textView?.textContainerInset = UIEdgeInsets(top: 0.0, left: 8.0, bottom: 8.0, right: 8.0)
        textView?.backgroundColor = UIColor.clear
        textView?.textColor = UIColor.white
        textView?.isSelectable = false
        textView?.isScrollEnabled = true
        textView?.showsHorizontalScrollIndicator = false
        textView?.showsVerticalScrollIndicator = false
        textView?.allowsEditingTextAttributes = false
        textView?.alwaysBounceHorizontal = false
        
        view.addSubview(textView!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let l = license {
            textView?.text = l.text
        }
        textView?.contentOffset = CGPoint.zero
    }
}


// MARK:- InfoTableViewController

private class InfoTableViewController: AMWaveViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - InfoHeaderView
    
    fileprivate class InfoHeaderView: UITableViewHeaderFooterView {
        
        let label = UILabel()
        
        override init(reuseIdentifier: String?) {
            label.textColor = UIColor(white: 1.0, alpha: 0.5)
            label.backgroundColor = UIColor.clear
            super.init(reuseIdentifier: reuseIdentifier)
            contentView.backgroundColor = UIColor.clear
            addSubview(label)
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        fileprivate override func layoutSubviews() {
            super.layoutSubviews()
            label.frame = bounds
        }
    }
    
    // MARK: Properties
    
    fileprivate static let licenses = PodsLicenseReader(path: Bundle.main.path(forResource: "Pods-Partita-acknowledgements", ofType: "plist")).getLicenses()
    fileprivate static let licenseViewController = LicenseViewController()
    
    fileprivate let tableView = UITableView(frame: CGRect.zero, style: .grouped)
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor.clear
        tableView.frame = CGRect(x: 0.0, y: 80.0, width: (view.bounds).width, height: (view.bounds).height - 80)
        tableView.register(InfoHeaderView.self, forHeaderFooterViewReuseIdentifier: "headerFooterView")
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    //  MARK: AMWaveTransion
    
    @objc override func visibleCells() -> [Any]! {
        var cells: [AnyObject] = tableView.visibleCells
        if let header = tableView.headerView(forSection: 0) {
            cells.insert(header, at: 0)
        }
        if let header = tableView.headerView(forSection: 1) {
            cells.insert(header, at: 2)
        }
        return cells
    }
    
    // MARK: UITableViewDataSource
    
    @objc func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = nil
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "creditCell")
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: "creditCell")
                cell?.textLabel?.textColor = UIColor.white
                cell?.backgroundColor = UIColor.clear
                cell?.textLabel?.text = "Created by Comyar Zaheri"
                cell?.selectionStyle = .none
            }
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "licenseCell")
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: "licenseCell")
                cell?.textLabel?.textColor = UIColor.white
                cell?.backgroundColor = UIColor.clear
                cell?.accessoryType = .disclosureIndicator
            }
            let license = InfoTableViewController.licenses[indexPath.row]
            cell?.textLabel?.text = license.name
        }
        return cell!
    }
    
    @objc func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    @objc func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    @objc func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    @objc func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : InfoTableViewController.licenses.count
    }
    
    // MARK: UITableViewDelegate
    
    @objc func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section > 0 {
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.setSelected(false, animated: true)
                InfoTableViewController.licenseViewController.license = InfoTableViewController.licenses[indexPath.row]
                self.navigationController?.pushViewController(InfoTableViewController.licenseViewController, animated: true)
            }
        }
    }
    
    @objc func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        if indexPath.section > 0 {
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.setSelected(false, animated: true)
            }
        }
    }
    
    @objc func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "infoHeaderView")
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
    
    fileprivate let closeButton: BFPaperButton
    fileprivate let infoTableViewController: InfoTableViewController
    fileprivate let navigationViewController: UINavigationController
    
    // MARK: Creating an InfoViewController
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
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
        navigationViewController.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 32.0, weight: UIFontWeightLight), NSForegroundColorAttributeName: UIColor.white]
        navigationViewController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationViewController.navigationBar.tintColor = UIColor.white
        navigationViewController.navigationBar.backgroundColor = UIColor.clear
        navigationViewController.automaticallyAdjustsScrollViewInsets = false
        navigationViewController.view.backgroundColor = UIColor.clear
        navigationViewController.navigationBar.shadowImage = UIImage()
        navigationViewController.navigationBar.isTranslucent = true
        addChildViewController(navigationViewController)
        view.addSubview(navigationViewController.view)
        
        closeButton.frame = CGRect(x: (view.bounds).width - 54, y: 30, width: 44, height: 44)
        closeButton.addTarget(self, action: #selector(InfoViewController.didTouchUpInsideButton(_:)), for: .touchUpInside)
        closeButton.cornerRadius = (closeButton.bounds).width / 2.0
        closeButton.setTitleColor(UIColor.textColor(), for: .normal)
        closeButton.backgroundColor = UIColor.white
        closeButton.setTitle("X", for: .normal)
        closeButton.rippleBeyondBounds = true
        view.addSubview(closeButton)
        
        let navigationLineView = UIView(frame: CGRect(x: 0.0, y: 80.0, width: view.bounds.width, height: 0.5))
        navigationLineView.backgroundColor = UIColor(white: 1.0, alpha: 0.75)
        view.addSubview(navigationLineView)
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: UIButton
    
    func didTouchUpInsideButton(_ button: UIButton) {
        if (button == closeButton) {
            dismiss(animated: true, completion: nil)
        }
    }
}
