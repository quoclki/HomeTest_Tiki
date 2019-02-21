//
//  ImageStore.swift
//  FnBPOS_Base
//
//  Created by Huynh Minh Thien on 6/13/17.
//  Copyright © 2018 CDS. All rights reserved.
//

import UIKit

public class ImageStore: NSObject {
    
    /// shared instant
    public static var shared = ImageStore()
    
    public var imgDict: [String: AnyObject?] = [:]

    /// set image to ImageView
    public func setImg(toImageView imv: UIImageView, imgURL: String?, defaultImg: UIImage? = nil, completedFunc: ((UIImage?) -> Void)? = nil) {
        func handleError() {
            imv.image = defaultImg
            completedFunc?(defaultImg)
        }
        
        guard let imgURL = imgURL, imgURL.isImageUrl else {
            handleError()
            return
        }
        
        func handleDownloadImage() {
            imv.image = defaultImg
            debugPrint("Handle Download Image")
            Ultities.getImageAsync(imgURL, complete: {
                if let image = $0?.resize(newWidth: min(($0?.size.width ?? 0), 450)) {
                    imv.image = image
                    self.imgDict.updateValue(image, forKey: imgURL)
                    completedFunc?(image)
                } else {
                    handleError()
                }
            })
        }

        if let item = imgDict.filter({$0.0 == imgURL}).first {
            // if has key in dictionary
            if let img = item.1 as? UIImage {
                // if img has been completely downloaded
                imv.image = img
                completedFunc?(img)
            } else {
                // if img has been downloaded but not finished yet -> download img but not store in imgDict
                handleDownloadImage()
            }
            return
        }
        // download new item in background, and add it to dictionary
        imgDict.updateValue(nil, forKey: imgURL)
        handleDownloadImage()
    }
}
