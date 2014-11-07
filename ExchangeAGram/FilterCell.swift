//
//  FilterCell.swift
//  ExchangeAGram
//
//  Created by Ilian Jordanov on 10/16/14.
//  Copyright (c) 2014 ihjordanov. All rights reserved.
//

import UIKit

class FilterCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        contentView.addSubview(imageView)
    }
    

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
