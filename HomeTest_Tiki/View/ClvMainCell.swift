//
//  ClvMainCell.swift
//  HomeTest_Tiki
//
//  Created by Lu Kien Quoc on 2/20/19.
//  Copyright © 2019 Lu Kien Quoc. All rights reserved.
//

import UIKit

class ClvMainCell: UICollectionViewCell {

    @IBOutlet weak var imvItem: UIImageView!
    @IBOutlet weak var vTitle: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    
    private var detail: KeywordDetail!
    
    static var DEFINIED_FONT: UIFont = UIFont.systemFont(ofSize: 14)
    static var DEFINIED_LABEL_HEIGHT: CGFloat = 40
    static var DEFINIED_MIN_WIDTH: CGFloat = 112
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        vTitle.layer.cornerRadius = 5
        vTitle.clipsToBounds = true
        lblTitle.textColor = .white
    }
    
    func updateCell(_ detail: KeywordDetail) {
        lblTitle.numberOfLines = Ultities.calNumberOfLine(detail)
        lblTitle.font = ClvMainCell.DEFINIED_FONT
        lblTitle.frame.size.height = ClvMainCell.DEFINIED_LABEL_HEIGHT
        self.detail = detail
        ImageStore.shared.setImg(toImageView: imvItem, imgURL: detail.icon)
        lblTitle.text = detail.keyword
    }
    
}
