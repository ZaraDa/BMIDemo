//
//  PickerCell.swift
//  BMI_DEMO_ZARA
//
//  Created by Zara Davtyan on 2/27/20.
//  Copyright © 2020 Zara Davtyan. All rights reserved.
//

import UIKit

class PickerCell: UITableViewCell {
    
    
    @IBOutlet weak var underlineWidth: NSLayoutConstraint!
    
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var underline: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
