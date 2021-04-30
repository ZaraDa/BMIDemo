//
//  Strings.swift
//  BMI_DEMO_ZARA
//
//  Created by Zara Davtyan on 2/27/20.
//  Copyright © 2020 Zara Davtyan. All rights reserved.
//

import Foundation
import UIKit


extension String {

    func getSizeWithFont(font:UIFont) -> CGSize {
        let size: CGSize = self.size(withAttributes: [.font: font])
        return size
    }
}

