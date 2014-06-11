//
//  MasterViewController.swift
//  QiitaAPISwiftDemo
//
//  Created by yimajo on 2014/06/06.
//  Copyright (c) 2014年 Curiosity Software Inc. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var qiitaItems = QiitaItemEntity[]()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        QiitaAPIClient.items("swift", success:{(items: QiitaItemEntity[]) -> Void in
                //成功時のクロージャー
                self.qiitaItems = items
                self.tableView.reloadData()
            }, failure:nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // #pragma mark - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            
            let indexPath = self.tableView.indexPathForSelectedRow()
            let object = qiitaItems[indexPath.row] as QiitaItemEntity
            
            (segue.destinationViewController as DetailViewController).detailItem = object
        }
    }
    // #pragma mark - Table View

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.qiitaItems.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        let qiitaItem = self.qiitaItems[indexPath.row] as QiitaItemEntity
        cell.textLabel.text = qiitaItem.title
        
        //memo: Optional Bindingの説明のためにこんなことやってるだけ
        if let gistUrlString = qiitaItem.gistUrlString {
            cell.detailTextLabel.text = gistUrlString
        } else {
            cell.detailTextLabel.text = "<gistのurlはありませんでした>"
        }
        return cell
    }

}

