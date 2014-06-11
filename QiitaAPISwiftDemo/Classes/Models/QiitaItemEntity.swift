//
//  QiitaItemEntity.swift
//  QiitaAPISwiftDemo
//
//  Created by yimajo on 2014/06/06.
//  Copyright (c) 2014年 Curiosity Software Inc. All rights reserved.
//

import Foundation

class QiitaItemEntity {
    
    let title : String
    let urlString : String
    
    var gistUrlString: String?
    
    init (title: String, urlString: String, gistUrlString: String? = nil) {
        self.title = title
        self.urlString = urlString
    }
    
}
