//
//  CornerImageTableViewCell.swift
//  RectCornerTest
//
//  Created by L on 2017/7/31.
//  Copyright © 2017年 L. All rights reserved.
//

import UIKit

class CornerImageTableViewCell: UITableViewCell {
    
    @IBOutlet var imageViewCollection: [UIImageView]!

    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.layoutIfNeeded()
        
        imageViewCollection.forEach {
            $0.addCorner(20, setRectCorner: .bottomLeft)
        }
        
    }
    
    
}
