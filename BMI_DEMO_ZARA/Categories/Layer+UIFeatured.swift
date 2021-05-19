//
//  Layer+UIFeatured.swift
//  
//
//  Created by Zara Davtyan on 2/26/20.
//

import Foundation
import UIKit

extension CALayer {
    
    public func addGradient(withRadius cornerRadius:CGFloat, startPoint:CGPoint = CGPoint(x: 0, y: 0), endPoint:CGPoint = CGPoint(x: 1, y: 1)) {
    let gradient = CAGradientLayer()
    gradient.frame = bounds
    gradient.colors = [navBarGradient1Color.cgColor, navBarGradient2Color.cgColor]
    gradient.startPoint = startPoint
    gradient.endPoint = endPoint
    gradient.cornerRadius = cornerRadius
    self.insertSublayer(gradient, at: 0)
    }
    
    public func addShadow() {
        self.shadowColor = UIColor.lightGray.cgColor
        self.shadowOpacity = 1
        self.shadowOffset = .zero
        self.shadowRadius = 4
    }
    
}
