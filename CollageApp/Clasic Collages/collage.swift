//
//  collage.swift
//  CollageApp
//
//  Created by Владимир Ребриков on 14/06/2019.
//  Copyright © 2019 Владимир Ребриков. All rights reserved.
//

import UIKit
@objc protocol MBcollageProtocol: NSObjectProtocol {
    @objc optional func didSelectCollageElement(element:collage)
    @objc optional func didBeginReceivingTouches(element:collage)
    @objc optional func didMoveOutsideCurrentElement(element:collage)
    @objc optional func didEndReceivingTouches(element:collage)
    @objc optional func didSwapCollageElements(primaryElement:collage, secondaryElement:collage)
    @objc optional func didEnterDeleteView(collageElement:collage, deleteView:UIView)
    @objc optional func didLeaveDeleteView(collageElement:collage, deleteView:UIView)
    @objc optional func didDeleteImageInElement(collageElement:collage)
}

public class collage:  UIControl, UIGestureRecognizerDelegate
{
    weak var delegate: MBcollageProtocol?
    private var relativeFrame: CGRect?
    private var ousideTheBounds: Bool = false
    private var elementImage: UIImage?
    var deleteView: UIView?
    private var isInsideDelete = false
    private var placeholderImageView: UIImageView?
    private var imageView: UIImageView?
    public var placeholderImage: UIImage? {
        didSet {
            if let placeholderImage = placeholderImage {
                let imageView = UIImageView(image: placeholderImage)
                imageView.frame.size = CGSize(width: 70, height: 70)
                imageView.contentMode = .center
                self.addSubview(imageView)
                imageView.center = CGPoint(x:self.bounds.size.width/2,y:self.bounds.size.height/2)
                self.placeholderImageView = imageView
            }
        }
    }
    
    private class func frameWithRelativeFrame(relativeFrame:CGRect, superview: UIView) -> CGRect
    {
        if !relativeFrame.equalTo(CGRect.zero)
        {
            var frame: CGRect = relativeFrame
            frame.origin.x *= superview.frame.size.width
            frame.size.width *= superview.frame.size.width
            frame.origin.y *= superview.frame.size.height
            frame.size.height *= superview.frame.size.height
            return frame
        }
        return .zero
    }
    
    
    // тут посмотреть по повуду вылезания картинки
    private init() { super.init(frame: .zero) }
    private override init(frame: CGRect) { super.init(frame: .zero) }
    
    init(superView: UIView, relativeFrame:CGRect) {
        super.init(frame: collage.frameWithRelativeFrame(relativeFrame: relativeFrame, superview: superView))
        superView.addSubview(self)
        self.relativeFrame = relativeFrame
        
        self.addTarget(self, action: #selector(collage.childViewTapped(_:)), for: .touchUpInside)
        self.clipsToBounds = true
    }
    //init(frame: CGRect,imageFrames:[CGRect])
    //    {
    //        super.init(frame: frame)
    //        localframes = imageFrames
    //        self.backgroundColor = .red
    //        for i in localframes
    //        {
    //            addViewToCollage(Cframe: i)
    //        }
    //    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func childViewTapped(_ sender:UITapGestureRecognizer) {
        self.delegate?.didSelectCollageElement?(element: self)
    }
    
    public func getElementImage() -> UIImage? {
        return self.elementImage
    }
    public func getElementImageView() -> UIImageView? {
        return self.imageView
    }
    
    private class func swapImagesInElements(primaryElement: collage, secondayElement: collage) {
        let firstImage = primaryElement.elementImage?.copy()
        let secondImage = secondayElement.elementImage?.copy()
        
        
        primaryElement.elementImage = nil
        secondayElement.elementImage = nil
        
        guard firstImage != nil || secondImage != nil else { return }
        
        if firstImage != nil {
            secondayElement.addElementImage(image: firstImage as! UIImage)
            secondayElement.clipsToBounds = true
        } else {
            secondayElement.placeholderImage = secondayElement.placeholderImage?.copy() as? UIImage
        }
        
        if secondImage != nil {
            primaryElement.addElementImage(image: secondImage as! UIImage)
            primaryElement.clipsToBounds = true
        } else {
            primaryElement.placeholderImage = primaryElement.placeholderImage?.copy() as? UIImage
        }
    }
    private func removeAllImages() {
        self.elementImage = nil
        for subview in subviews {
            if subview is UIImageView {
                subview.removeFromSuperview()
            }
        }
    }
    public func addElementImage(image: UIImage) {
        
        var destinationRect = CGRect.zero
        
        //Remove All Images
        self.removeAllImages()
        
        //Reset Clip To Bounds
        self.clipsToBounds = true
        
        let newImageView = UIImageView(image: image)
        newImageView.isUserInteractionEnabled = true
        
        newImageView.frame.size = self.frame.size
        newImageView.contentMode = .scaleAspectFit
        newImageView.frame.size = newImageView.imageFrameSize()
        newImageView.center = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        destinationRect = newImageView.frame
        
        newImageView.frame = destinationRect
        self.addSubview(newImageView)
        
        self.elementImage = image
        self.imageView = newImageView
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(collage.viewPanned(_:)))
        newImageView.addGestureRecognizer(panGesture)
        
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(collage.viewRotated(_:)))
        newImageView.addGestureRecognizer(rotationGesture)
        
        let pinchgesture = UIPinchGestureRecognizer(target: self, action: #selector(collage.handlePinchGesture(recognizer:)))
        newImageView.addGestureRecognizer(pinchgesture)
        
        rotationGesture.delegate = self
        panGesture.delegate = self
        pinchgesture.delegate = self
    }    
    @objc func viewTapped(_ gesture:UIRotationGestureRecognizer) {
        self.delegate?.didSelectCollageElement?(element: self)
    }
    
    
    @objc func viewRotated(_ gesture:UIRotationGestureRecognizer) {
        gesture.view?.transform = (gesture.view?.transform.rotated(by: gesture.rotation))!
        gesture.rotation = 0
    }
    @objc func handlePinchGesture(recognizer: UIPinchGestureRecognizer) {
        recognizer.view?.transform = (recognizer.view?.transform.scaledBy(x: recognizer.scale, y: recognizer.scale))!
        recognizer.scale = 1
    }
    @objc func viewPanned(_ sender:UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            self.superview?.bringSubviewToFront(self)
            self.ousideTheBounds = false
            self.delegate?.didBeginReceivingTouches?(element: self)
        case .ended,.possible,.cancelled,.failed:
            self.clipsToBounds = true
            self.ousideTheBounds = false
            var droppedInContainer = false
            
            if self.deleteView != nil && self.deleteView!.bounds.contains(sender.location(in: self.deleteView!)){
                self.elementImage = nil
                sender.view?.removeFromSuperview()
                self.placeholderImage = self.placeholderImage?.copy() as? UIImage
                self.delegate?.didDeleteImageInElement?(collageElement: self)
            } else {
                for view in self.superview?.subviews ?? [UIView]() {
                    if view is collage && view != self {
                        if view.frame.contains(sender.location(in: self.superview!)) {
                            sender.view?.removeFromSuperview()
                            collage.swapImagesInElements(primaryElement: (view as! collage), secondayElement: self)
                            droppedInContainer = true
                            break
                        }
                    }
                }
                if !droppedInContainer && !self.bounds.contains(sender.location(in: self)) {
                    self.addElementImage(image: self.elementImage?.copy() as! UIImage)
                    return
                }
            }
            self.delegate?.didEndReceivingTouches?(element: self)
        case .changed:
            if !self.bounds.contains(sender.location(in: self)) && !ousideTheBounds {
                self.clipsToBounds = false
                self.ousideTheBounds = true
                
                sender.view!.frame.size = CGSize(width: 120, height: 120)
                
                //////////////
                sender.view!.frame.size = (sender.view! as! UIImageView).imageFrameSize()
                sender.view?.center = sender.location(in: self)
                
                self.delegate?.didMoveOutsideCurrentElement?(element: self)
            }
            
            if let deleteView = self.deleteView {
                let isInside = deleteView.bounds.contains(sender.location(in: deleteView))
                if self.isInsideDelete != isInside {
                    self.isInsideDelete = isInside
                    if isInside {
                        self.delegate?.didEnterDeleteView?(collageElement: self, deleteView: deleteView)
                    } else {
                        self.delegate?.didLeaveDeleteView?(collageElement: self, deleteView: deleteView)
                    }
                }
            }
            let translation = sender.translation(in: sender.view!.superview)
            sender.view?.center = CGPoint(x: sender.view!.center.x + translation.x, y: sender.view!.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: sender.view!.superview)
        }
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
