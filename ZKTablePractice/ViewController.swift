//
//  ViewController.swift
//  ZKTablePractice
//
//  Created by Zeeshan Khan on 30/05/15.
//  Copyright (c) 2015 Zeeshan Khan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tblList: UITableView!
    var arrRows:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.title = "Autolayout & Storyboard"
        
        let path = NSBundle.mainBundle().pathForResource("Text", ofType: "txt")
        let content = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil)!
        self.arrRows = content.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())
    
        self.tblList.estimatedRowHeight = 160
        self.tblList.rowHeight = UITableViewAutomaticDimension
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Basic", style:.Plain, target: self, action:"basicAction")
    }
    
    func basicAction() {
        let vc = BasicVC(nibName: "BasicVC", bundle: nil)
        var navCont = UINavigationController(rootViewController: vc)
        // from story board to xib PUSH not supported
        //        self.navigationController?.pushViewController(navCont, animated: true)
        self.presentViewController(navCont, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRows.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SubtitleCell", forIndexPath: indexPath) as! SubtitleCell
        cell.lblTitle.text = "Row \(indexPath.row)"
        cell.lblSubtitle.text = arrRows[indexPath.row]
        return cell
    }

}

