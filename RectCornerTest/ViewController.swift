//
//  ViewController.swift
//  RectCornerTest
//
//  Created by L on 2017/7/31.
//  Copyright © 2017年 L. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 基于 iOS 10.3.3 Xcode 8.3.3 iPhone6s Plus 和 iPhone5c 测试 其它机型系统如有区别暂未测试
        //
        
        /*
         clipsToBounds(UIView)
         是指视图上的子视图,如果超出父视图的部分就截取掉,
         masksToBounds(CALayer)
         却是指视图的图层上的子图层,如果超出父图层的部分就截取掉
         */
        
        //testViewCorner()
        
        //testLabelCorner()
        
        //testImageViewCorner()
        
        // 其它控件基本都是由这3个组成的,什么时候触发混合图层或者离屏渲染可以参考
        // 单纯的masksToBounds或cornerRadius 并不会导致离屏渲染
        // masksToBounds和cornerRadius 一起运用就会导致离屏渲染了
        
        //UIButton、UIView、UIImageView(没图片) 只需设置 layer.cornerRadius 这一键值对就可实现圆角效果
        
    }
    
    func testViewCorner() {
        
        let greenView = UIView()
        greenView.frame.size = CGSize(width: 200, height: 200)
        greenView.center = view.center
        view.addSubview(greenView)
        greenView.backgroundColor = .green // 此时并不是混合图层
        //混合的图层Blended Layer(用红色标注)
    
        // 加了这行后就变成混合图层了,没出现离屏渲染 直接就是圆弧了(button也是一行圆弧)
        greenView.layer.cornerRadius = 100;
        
        // 再加这行 视图的图层上的子图层,如果超出父图层的部分就截取掉  也没出现离屏渲染
        greenView.layer.masksToBounds = true
        
    }
    
    func testLabelCorner() {
        
        let greenLabel = UILabel()
        greenLabel.frame.size = CGSize(width: 200, height: 200)
        greenLabel.center = view.center
        view.addSubview(greenLabel)
        greenLabel.backgroundColor = .green // 直接就是混合图层了
        greenLabel.text = "greenLabel" // 添加文字之后混合图层消失了
        //混合的图层Blended Layer(用红色标注)
        
        //没出现离屏渲染和混合图层 也并没有变成圆弧
        greenLabel.layer.cornerRadius = 100;
        
        // 再加这行 视图的图层上的子图层,如果超出父图层的部分就截取掉
        // 变成了圆弧
        // 出现离屏渲染,没出现混合图层
        greenLabel.layer.masksToBounds = true
    }
    
    func testImageViewCorner() {
        
        let greenImageView = UIImageView()
        greenImageView.frame.size = CGSize(width: 200, height: 200)
        greenImageView.center = view.center
        view.addSubview(greenImageView)
        greenImageView.backgroundColor = .green // 没出现混合图层
        //对于UIImageView来说，不仅它自身需要是不透明的，它的图片也不能含有alpha通道才会没图层混合
        //可以拿noAlpha_PNG测试
        //greenImageView.image = #imageLiteral(resourceName: "Corner_PNG") // 出现了混合图层
        //混合的图层Blended Layer(用红色标注)
        
        // 没有变成圆弧,因为有图片,没图片的话就是圆弧了
        greenImageView.layer.cornerRadius = 100;
        // 变成圆弧,触发了离屏渲染
        greenImageView.layer.masksToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

