//
//  BasicVC.swift
//  ZKTablePractice
//
//  Created by Zeeshan Khan on 30/05/15.
//  Copyright (c) 2015 Zeeshan Khan. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    func heightOfString (string: NSString, constrainedToWidth width: Double) -> CGFloat {
        return string.boundingRectWithSize(CGSize(width: width, height: DBL_MAX),
            options: NSStringDrawingOptions.UsesLineFragmentOrigin,
            attributes: [NSFontAttributeName: self],
            context: nil).size.height
    }
}

class BasicVC: UIViewController {
    
    @IBOutlet var tblBasic: UITableView!
    var arrList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("Text", ofType: "txt")
        let content = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil)
        self.arrList = content!.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style:.Plain, target: self, action:"dismissAction")
    }
    
    func dismissAction() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    
        struct Static {
            static var font: UIFont?
            static var txtWidth: Double?
            static var extraHeight: CGFloat?
        }
        
        if Static.font == nil {
            let cell = self.tableCell(tableView)
            Static.font = cell.lblSubtitle.font
            Static.txtWidth = Double(cell.lblSubtitle.frame.size.width)
            Static.extraHeight = cell.frame.height - cell.lblSubtitle.frame.height
        }
        
        let txt = self.arrList[indexPath.row] as NSString
        var height = Static.font?.heightOfString(txt, constrainedToWidth: Static.txtWidth!)
        return height! + 5.0
    }
    
    func tableCell(tableView: UITableView) -> SubtitleCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("SubtitleCell") as? SubtitleCell
        if (cell == nil) {
            let xib = NSBundle.mainBundle().loadNibNamed("SubtitleCell", owner: self, options: nil)
            cell = xib[0] as? SubtitleCell
        }
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrList.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableCell(tableView)
        cell.lblTitle.text = "Row \(indexPath.row)"
        cell.lblSubtitle.text = self.arrList[indexPath.row]
        return cell
    }
    
}
