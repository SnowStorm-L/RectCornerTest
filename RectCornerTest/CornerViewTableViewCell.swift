//
//  CornerViewTableViewCell.swift
//  RectCornerTest
//
//  Created by L on 2017/7/31.
//  Copyright © 2017年 L. All rights reserved.
//

import UIKit

class CornerViewTableViewCell: UITableViewCell {

    @IBOutlet weak var leftView: UIView!
    
    @IBOutlet weak var midLeftView: UIView!
    
    @IBOutlet weak var midRightView: UIView!
    
    @IBOutlet weak var rightView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
