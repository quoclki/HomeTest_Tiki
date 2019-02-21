//
//  Ultities.swift
//  HomeTest_Tiki
//
//  Created by Lu Kien Quoc on 2/20/19.
//  Copyright © 2019 Lu Kien Quoc. All rights reserved.
//

import Foundation
import UIKit

class Ultities {
    
    // Calculate Number of Line in Text
    static func calNumberOfLine(_ data: KeywordDetail) -> Int {
        guard let keyword = data.keyword?.trimmingCharacters(in: .whitespacesAndNewlines), !keyword.isEmpty else {
            return 1
        }
        
        if keyword.contains(" ") {
            return 2
        }
        
        return 1
    }
    
    // Get Data From URL
    static func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    // Down Image From URL
    static func getImageAsync(_ urlString: String, complete: @escaping ((UIImage?) -> ())) {
        guard let url = URL(string: urlString) else {
            complete(nil)
            return
        }

        getData(from: url) { data, response, error in
            guard let data = data, error == nil else {
                complete(nil)
                return
            }
            DispatchQueue.main.async() {
                complete(UIImage(data: data))
            }
        }
    }
    
    
}

