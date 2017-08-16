//
//  UIImageView+Extension.swift
//  ChainProgramming
//
//  Created by L on 2017/8/2.
//  Copyright © 2017年 L. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func addCorner(_ setRornerRadius: CGFloat, setRectCorner: UIRectCorner = UIRectCorner.allCorners) {
        rectCorner = setRectCorner
        cornerRadius = setRornerRadius
    }
    
    fileprivate var rectCorner: UIRectCorner? {
        get {
            return objc_getAssociatedObject(self, &Constact.imageRectCornerKey) as? UIRectCorner
        } set {
            objc_setAssociatedObject(self, &Constact.imageRectCornerKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    fileprivate var cornerRadius: CGFloat {
        get {
            return imageObserver().cornerRadius
        } set {
            imageObserver().cornerRadius = newValue
        }
    }
    
    fileprivate struct Constact {
        static var imageObserverRuntimeKey = "imageObserverRuntimeKey"
        static var imageRectCornerKey = "imageRectCornerKey"
    }
    
    fileprivate func imageObserver() -> ImageObserver {
        
        var imageObserver = objc_getAssociatedObject(self, &Constact.imageObserverRuntimeKey) as? ImageObserver
        
        if imageObserver == nil {
            imageObserver = ImageObserver(imageView: self)
            objc_setAssociatedObject(self, &Constact.imageObserverRuntimeKey, imageObserver, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        if let cornerType = rectCorner {
            imageObserver?.rectCorner = cornerType
        }
    
        return imageObserver!
    }
    
}

fileprivate extension UIImage {
    
    fileprivate var hasCornerRadius: Bool? {
        get {
            return objc_getAssociatedObject(self, &Constact.cornerRuntimeKey) as? Bool
        } set {
            objc_setAssociatedObject(self, &Constact.cornerRuntimeKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    fileprivate struct Constact {
        static var cornerRuntimeKey = "cornerRuntimeKey"
    }
    
}

private class ImageObserver: NSObject {
    
    @objc dynamic fileprivate var originImageView: UIImageView?
    
    fileprivate var originImage: UIImage?
    
    fileprivate var rectCorner = UIRectCorner.allCorners
    
    var cornerRadius: CGFloat = 0 {
        didSet {
            if cornerRadius == oldValue {
                return
            }
            if (cornerRadius > 0) {
                updateImage()
            }
        }
    }
    
    fileprivate struct KeyPath {
        static let image = "image"
        static let contentMode = "contentMode"
    }
    
    init(imageView: UIImageView) {
        super.init()
        
        originImageView = imageView
        
        imageView.addObserver(self, forKeyPath: KeyPath.image, options: .new, context: nil)
        imageView.addObserver(self, forKeyPath: KeyPath.contentMode, options: .new, context: nil)
        
    }
    
    deinit {
        originImageView?.removeObserver(self, forKeyPath: KeyPath.image)
        originImageView?.removeObserver(self, forKeyPath: KeyPath.contentMode)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == KeyPath.image {
            
            guard let newImage = change?[.newKey] as? UIImage else { return }
            
            if !newImage.isKind(of: UIImage.self) || newImage.hasCornerRadius == true {
                return
            }
            
            updateImage()
        }
        
        if keyPath == KeyPath.contentMode {
            originImageView?.image = originImage
        }
        
    }
    
    
    fileprivate func updateImage() {
        
        originImage = originImageView?.image
        
        guard let _ = originImage,
            let originImageView = originImageView
            else { return }
        
        UIGraphicsBeginImageContextWithOptions(originImageView.bounds.size, false, UIScreen.main.scale)
        
        guard let currentContext = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return
        }
        
        let bezierPath = UIBezierPath(roundedRect: originImageView.bounds, byRoundingCorners: rectCorner, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        
        currentContext.addPath(bezierPath.cgPath)
        currentContext.clip()
        
        self.originImageView?.layer.render(in: currentContext)
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return
        }
        
        UIGraphicsEndImageContext()
        
        if image.isKind(of: UIImage.self) {
            image.hasCornerRadius = true
            self.originImageView?.image = image
        } else {
            DispatchQueue.main.async {
                self.updateImage()
            }
        }
        
    }
    
}
