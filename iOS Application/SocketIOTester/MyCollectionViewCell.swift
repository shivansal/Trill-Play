//
//  MyCollectionViewCell.swift
//  Trill
//
//  Created by Gagan Kaushik on 1/31/16.
//  Copyright © 2016 gk. All rights reserved.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var buttonWithImage: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func buttonTapped(sender: AnyObject) {
    
    }
    

}
