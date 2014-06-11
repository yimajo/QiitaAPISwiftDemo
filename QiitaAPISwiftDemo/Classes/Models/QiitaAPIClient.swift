//
//  QiitaAPIClient.swift
//  QiitaAPISwiftDemo
//
//  Created by yimajo on 2014/06/06.
//  Copyright (c) 2014年 Curiosity Software Inc. All rights reserved.
//


import Foundation

class QiitaAPIClient {
    
class var baseUrlString: String { return "https://qiita.com/api/v1" }

class func itemsURL() -> NSURL {
    return NSURL(string: "\(self.baseUrlString)/items")
}

class func itemsURL(tagName:String) -> NSURL {
    
    return NSURL(string: "\(self.baseUrlString)/tags/\(tagName)/items")
}

    class func items(tagName:String, success:((QiitaItemEntity[]) -> Void)!, failure:((NSError?) -> Void)!) {
        
        let url = itemsURL(tagName)
        let request = NSURLRequest(URL: url)
        
        NSURLConnection.sendAsynchronousRequest(request,
            queue: NSOperationQueue.mainQueue(),
            completionHandler:{(response: NSURLResponse!,
                data: NSData!,
                error: NSError!) in
                
                if error {
                    failure?(error)
                    return
                }
                //NSJSONSerializationにnil渡すと例外になるためチェックをしている
                //オリジナルのNSErrorを作ればいいかもしれないがとりあえずnilを返しておく
                if !data {
                    failure?(nil)
                    return
                }
                
                var jsonError: NSError?

                if let anyObjects = NSJSONSerialization.JSONObjectWithData(data,
                        options:NSJSONReadingOptions.AllowFragments,
                        error:&jsonError) as? NSDictionary[] {
                        
                    var items = QiitaItemEntity[]()
                    //Arrayの全ての要素がNSDictionaryだからfor inできる
                    for dictionary : NSDictionary in anyObjects {
                        if let title = dictionary["title"] as? String {
                            if let urlString = dictionary["url"] as? String {
                                
                                let qiita = QiitaItemEntity(title: title, urlString: urlString)
                                qiita.gistUrlString = dictionary["gist_url"] as? String
                                //(5)配列の+=はapendされる
                                items += qiita
                            }
                        }
                    }
                
                    success?(items)
                
                } else if jsonError {
                    //想定外1（APIサーバーが仕様通りのJSONを返していない）
                    failure?(jsonError)
                } else {
                    //想定外2（APIサーバーがメンテナンスモードでJSONを返していないなどを疑う）
                    //これもオリジナルのNSErrorを作ればいいかもしれないがとりあえずnilを返しておく
                    failure?(nil)
                }
            }
        )
    }
}