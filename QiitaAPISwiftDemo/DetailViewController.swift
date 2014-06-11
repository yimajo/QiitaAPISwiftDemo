//
//  DetailViewController.swift
//  QiitaAPISwiftDemo
//
//  Created by yimajo on 2014/06/06.
//  Copyright (c) 2014年 Curiosity Software Inc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var webView : UIWebView
    
    var detailItem: QiitaItemEntity? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail: QiitaItemEntity = self.detailItem {
            if let webView = self.webView {
                
                webView.loadRequest(NSURLRequest(URL:NSURL(string: detail.urlString)))
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

