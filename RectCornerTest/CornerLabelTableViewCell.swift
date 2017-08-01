//
//  CornerLabelTableViewCell.swift
//  RectCornerTest
//
//  Created by L on 2017/7/31.
//  Copyright © 2017年 L. All rights reserved.
//

import Foundation

import UIKit

class CornerLabelTableViewCell: UITableViewCell {
    
    @IBOutlet weak var leftLabel: UILabel!
    
    @IBOutlet weak var midLeftLabel: UILabel!
    
    @IBOutlet weak var midRightLabel: UILabel!
    
    @IBOutlet weak var rightLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
