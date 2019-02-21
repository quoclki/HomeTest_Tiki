//
//  DTO.swift
//  HomeTest_Tiki
//
//  Created by Lu Kien Quoc on 2/20/19.
//  Copyright © 2019 Lu Kien Quoc. All rights reserved.
//

import Foundation

class Keywords: Codable {
    var keywords: [KeywordDetail] = []
}

class KeywordDetail: Codable {
    var keyword: String?
    var icon: String?
}
