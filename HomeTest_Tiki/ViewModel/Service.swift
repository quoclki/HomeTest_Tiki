//
//  Service.swift
//  HomeTest_Tiki
//
//  Created by Lu Kien Quoc on 2/20/19.
//  Copyright © 2019 Lu Kien Quoc. All rights reserved.
//

import Foundation

class Service {
    static func callTiki(_ animation: ((Bool) -> ())? = nil,  completed: @escaping ((Keywords?) -> ())) {
        guard let url = URL(string: Const.LINK_API) else {
            return
        }
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 60
        sessionConfig.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        sessionConfig.urlCache = nil
        
        let session = URLSession(configuration: sessionConfig)
        animation?(true)
        let task = session.dataTask(with: URLRequest(url: url)) { data, urlResponse, err in
            DispatchQueue.main.async {
                print(#function + " Data Response")
                animation?(false)
                
                if let err = err {
                    print(err.localizedDescription)
                    completed(nil)
                    return
                }
                
                do {
                    let jsonDecoder = JSONDecoder()
                    let keywords = try jsonDecoder.decode(Keywords.self, from: data!)
                    completed(keywords)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
}

