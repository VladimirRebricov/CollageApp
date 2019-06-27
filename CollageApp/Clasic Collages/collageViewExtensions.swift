//
//  collageViewExtensions.swift
//  CollageApp
//
//  Created by Владимир Ребриков on 20/06/2019.
//  Copyright © 2019 Владимир Ребриков. All rights reserved.
//

import UIKit


extension UIImageView {
    func imageFrameSize() -> CGSize {
        if let image = self.image {
            let widthRatio = self.bounds.size.width / image.size.width
            let heightRatio = self.bounds.size.height / image.size.height
            var scale = min(widthRatio, heightRatio)
            if self.contentMode == .scaleAspectFill {
                scale = max(widthRatio, heightRatio)
            }
            let imageWidth = scale * image.size.width
            let imageHeight = scale * image.size.height
            return CGSize(width: imageWidth, height: imageHeight)
        } else {
            return self.frame.size
        }
    }
}

extension UIView {
    public func getSnapshotImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
        drawHierarchy(in: bounds, afterScreenUpdates: false)
        let snapshotImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return snapshotImage
    }
    class func instanceFromNib(nibName: String) -> UIView {
        return UINib(nibName: nibName, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    class func loadFromNibNamed(nibNamed: String, bundle : Bundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
}
