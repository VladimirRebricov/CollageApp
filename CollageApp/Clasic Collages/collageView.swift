//
//  collageView.swift
//  CollageApp
//
//  Created by Владимир Ребриков on 18/06/2019.
//  Copyright © 2019 Владимир Ребриков. All rights reserved.
//

import UIKit

@objc public protocol XcollageViewProtocol: NSObjectProtocol {
    @objc optional func didSelectCollageElement(element:collage)
    @objc optional func didBeginReceivingTouches(element:collage)
    @objc optional func didMoveOutsideCurrentElement(element:collage)
    @objc optional func didEndReceivingTouches(element:collage)
    @objc optional func didEnterDeleteView(collageElement:collage, deleteView:UIView)
    @objc optional func didLeaveDeleteView(collageElement:collage, deleteView:UIView)
    @objc optional func didDeleteImageInElement(collageElement:collage)
}

class collageView: UIView, MBcollageProtocol {
    public var placeholderImage: UIImage?
    public var borderColor: UIColor?
    public var translationImageView: UIImageView?
    public var delegate: XcollageViewProtocol?
    public var deleteView: UIView? {
        didSet {
            for subview in self.subviews {
                if subview is collage {
                    (subview as? collage)?.deleteView = self.deleteView
                }
            }
        }
    }
    
    
    
    public var allElements: [collage] {
        get {
            var elements = [collage]()
            for subview in self.subviews {
                if subview is collage {
                    elements.append(subview as! collage)
                }
            }
            return elements
        }
        
    }
    
    public func initializeCollageView(relativeFrames:[String]) {
        for frame in relativeFrames {
            let child = collage(superView: self, relativeFrame: NSCoder.cgRect(for: frame))
            child.delegate = self
            
//            if let borderColor = self.borderColor {
//                let layer = CALayer()
//                layer.frame = CGRect(x: 0, y: 0, width: floor(child.frame.width), height: floor(child.frame.height))
//                layer.isGeometryFlipped = false
//                //layer.frame = child.bounds
//                layer.backgroundColor = UIColor.white.cgColor
//                layer.borderColor = borderColor.cgColor
//                layer.borderWidth = 1
//                child.layer.addSublayer(layer)
//            }
            child.placeholderImage = placeholderImage
        }
    }
    
    func didSelectCollageElement(element: collage) {
        self.delegate?.didSelectCollageElement?(element: element)
    }
    
    func didEnterDeleteView(collageElement: collage, deleteView: UIView) {
        self.delegate?.didEnterDeleteView?(collageElement: collageElement, deleteView: deleteView)
    }
    
    func didLeaveDeleteView(collageElement: collage, deleteView: UIView) {
        self.delegate?.didLeaveDeleteView?(collageElement: collageElement, deleteView: deleteView)
    }
    
    func didDeleteImageInElement(collageElement:collage) {
        self.delegate?.didDeleteImageInElement?(collageElement: collageElement)
    }
    
    func didEndReceivingTouches(element: collage) {
        self.delegate?.didEndReceivingTouches?(element: element)
    }
    
    func didBeginReceivingTouches(element: collage) {
        self.delegate?.didBeginReceivingTouches?(element: element)
    }
    
    func didMoveOutsideCurrentElement(element: collage) {
        self.delegate?.didMoveOutsideCurrentElement?(element: element)
    }
    
}
