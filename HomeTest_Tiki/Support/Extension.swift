//
//  Extension.swift
//  HomeTest_Tiki
//
//  Created by Lu Kien Quoc on 2/21/19.
//  Copyright © 2019 Lu Kien Quoc. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    /// show loading
    func showLoadingView(_ isShow: Bool = true, frameLoading: CGRect = CGRect.zero, loadingBgColor color: UIColor = UIColor(hexString: "000000", a: 0.1), valueOfLoadingView value: String = "viewForLoading") {
        
        if !isShow {
            self.subviews.first(where: { $0.accessibilityValue == value })?.removeFromSuperview()
            return
        }
        
        let viewLoading = UIView()
        viewLoading.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewLoading.frame = frameLoading == CGRect.zero ? self.bounds : frameLoading
        viewLoading.backgroundColor = color
        viewLoading.accessibilityValue = value
        
        let vLoadingSmall = UIView()
        vLoadingSmall.frame.size = CGSize(width: 40, height: 40)
        vLoadingSmall.backgroundColor = UIColor(hexString: "000000", a: 0.3)
        vLoadingSmall.center = CGPoint(x: viewLoading.frame.size.width / 2, y: viewLoading.frame.height / 2)
        vLoadingSmall.autoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin, .flexibleRightMargin, .flexibleBottomMargin]
        vLoadingSmall.layer.cornerRadius = 4
        
        let indicator = UIActivityIndicatorView()
        indicator.startAnimating()
        indicator.autoresizingMask = vLoadingSmall.autoresizingMask
        indicator.center = CGPoint(x: vLoadingSmall.frame.size.width / 2, y: vLoadingSmall.frame.width / 2)
        
        vLoadingSmall.addSubview(indicator)
        viewLoading.addSubview(vLoadingSmall)
        
        self.addSubview(viewLoading)
        self.bringSubviewToFront(viewLoading)
    }
    
}

extension UIColor {
    convenience init(hexString: String, a: CGFloat = 1) {
        let hex = hexString.trimmingCharacters(in: NSCharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (r, g, b) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (r, g, b) = (int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (1, 1, 0)
        }
        
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a))
    }
}

extension String {
    var isImageUrl: Bool {
        do {
            let regexPng = try NSRegularExpression(pattern: "^*.png", options: .caseInsensitive)
            let regexJpg = try NSRegularExpression(pattern: "^*.jpg", options: .caseInsensitive)
            let regexJpeg = try NSRegularExpression(pattern: "^*.jpeg", options: .caseInsensitive)
            if regexPng.firstMatch(in: self, options: .reportProgress, range: NSMakeRange(0, self.count)) != nil
                || regexJpg.firstMatch(in: self, options: .reportProgress, range: NSMakeRange(0, self.count)) != nil
                || regexJpeg.firstMatch(in: self, options: .reportProgress, range: NSMakeRange(0, self.count)) != nil
            {
                return true
            }
            return false
        }
        catch let err {
            debugPrint(err)
            return false
        }
    }
    
}

extension UIImage {
    func resize(newWidth w: CGFloat) -> UIImage? {
        if w >= size.width {
            return self
        }
        
        let scale = w/size.width
        let h = size.height * scale
        
        UIGraphicsBeginImageContext(CGSize(width: w, height: h))
        draw(in: CGRect(x: 0, y: 0, width: w, height: h))
        let newImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImg
    }
    
}

extension UILabel {
    var isTruncated: Bool {
        guard let labelText = text else {
            return false
        }
        
        let labelTextSize = (labelText as NSString).boundingRect(
            with: CGSize(width: frame.size.width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil).size
        
        return labelTextSize.height > bounds.size.height
    }
}
