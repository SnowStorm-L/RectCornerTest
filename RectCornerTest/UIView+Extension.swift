//
//  UIView+Extension.swift
//  RectCornerTest
//
//  Created by L on 2017/7/31.
//  Copyright © 2017年 L. All rights reserved.
//

import UIKit

extension UIView {
    
    fileprivate static let cornerLayerName = "cornerShapeLayer"
    
    func drawCorner(corner: UIRectCorner, radius: CGFloat, backgroundColor: UIColor? = nil) {
        
        removeCorner()
        
        let radii = CGSize(width: radius, height: radius)
        let cornerPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corner, cornerRadii: radii)
        
        let bezierRect = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        let bezierPath = UIBezierPath(rect: bezierRect)
        bezierPath.append(cornerPath)
        
        let shapelayer = CAShapeLayer()
        shapelayer.name = UIView.cornerLayerName
        shapelayer.path = bezierPath.cgPath
        shapelayer.fillRule = kCAFillRuleEvenOdd
        shapelayer.fillColor = backgroundColor?.cgColor
        
        /* 边框颜色  算法待优化暂时不使用
         let cornerPathLength = lengthOfCGPath(corner: corner, radius: radius, size: cornerBounds.size)
         let totolPathLength = 2 * (cornerBounds.height + cornerBounds.width) + cornerPathLength
         shapelayer.strokeStart = (totolPathLength-cornerPathLength)/totolPathLength
         shapelayer.strokeEnd = 1.0
         shapelayer.strokeColor = borderColor.cgColor
         */
        
        if isKind(of: UILabel.self) {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.layer.addSublayer(shapelayer)
            }
            return
        }
        
        layer.addSublayer(shapelayer)
    }
    
    // 边框颜色  算法待优化暂时不使用
    fileprivate func lengthOfCGPath(corner: UIRectCorner, radius: CGFloat, size: CGSize) -> CGFloat {
        var totolLength: CGFloat = 0
        switch corner {
        case [.topLeft, .topRight], [.bottomLeft, .bottomRight]:
            totolLength = 2 * (size.width + size.height) - 4 * radius + (.pi * radius)
        case UIRectCorner.allCorners:
            totolLength = 2 * (size.width + size.height) - 8 * radius + (.pi * radius) * 2
        default:
            break
        }
        return totolLength
    }
    
    fileprivate func hasCorner() -> Bool {
        
        guard let layerSublayer = layer.sublayers else { return false }
        
        for sublayer in layerSublayer {
            if sublayer.isKind(of: CAShapeLayer.self) &&
                sublayer.name == UIView.cornerLayerName
            {
                return true
            }
        }
        return false
    }
    
    fileprivate func removeCorner() {
        if hasCorner() {
            var tempLayer: CALayer?
            guard let layerSublayer = layer.sublayers else { return }
            for sublayer in layerSublayer {
                if sublayer.name == UIView.cornerLayerName {
                    tempLayer = sublayer
                }
            }
            tempLayer?.removeFromSuperlayer()
        }
    }
    
    /*
     
     enum CornerType {
     case cornerRadiusAndMasksToBounds
     case bezierPathAndCAShapeLayer
     case bezierPathAndCoreGraphics
     case coreGraphics
     }
     
     func makeCorner(viewArray: [UIView], type: CornerType) {
     
     if type == .cornerRadiusAndMasksToBounds {
     viewArray.forEach {
     $0.layer.cornerRadius = 20
     $0.layer.masksToBounds = true
     }
     }
     
     if type == .bezierPathAndCAShapeLayer {
     viewArray.forEach {
     let maskPath = UIBezierPath(roundedRect: $0.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 20, height: 20))
     let maskLayer = CAShapeLayer()
     maskLayer.frame = $0.bounds
     maskLayer.path = maskPath.cgPath
     $0.layer.mask = maskLayer
     }
     }
     
     if type == .bezierPathAndCoreGraphics {
     viewArray.forEach {
     UIGraphicsBeginImageContextWithOptions($0.bounds.size, false, UIScreen.main.scale)
     UIBezierPath(ovalIn: $0.bounds).addClip()
     $0.draw($0.bounds)
     // 这里强行解包,测试需要
     ($0 as! UIImageView).image = UIGraphicsGetImageFromCurrentImageContext()
     UIGraphicsEndImageContext()
     }
     }
     
     if type == .coreGraphics {
     viewArray.forEach {
     UIGraphicsBeginImageContextWithOptions($0.bounds.size, false, UIScreen.main.scale)
     let context = UIGraphicsGetCurrentContext()
     context?.addEllipse(in: $0.bounds)
     context?.clip()
     $0.draw($0.bounds)
     ($0 as! UIImageView).image = UIGraphicsGetImageFromCurrentImageContext()
     UIGraphicsEndImageContext()
     }
     }
     
     }
     */
}
