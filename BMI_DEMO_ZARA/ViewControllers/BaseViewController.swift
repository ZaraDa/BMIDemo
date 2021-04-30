//
//  BaseViewController.swift
//  BMI_DEMO_ZARA
//
//  Created by Zara Davtyan on 2/26/20.
//  Copyright © 2020 Zara Davtyan. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarStyle()
    }
    
    func setupNavigationBarStyle() {


    self.navigationController?.navigationBar.tintColor = UIColor.white

        //// adding title color
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Segoe UI", size: 17)!]
               } else {
                   UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont(name: "Segoe UI", size: 17)!]
               }
        
        ////adding gradient
        if let navigationBar = self.navigationController?.navigationBar {
            let gradient = CAGradientLayer()
            var bounds = navigationBar.bounds
            bounds.size.height += UIApplication.shared.statusBarFrame.size.height
            gradient.frame = bounds
            gradient.colors = [UIColor(displayP3Red: 25.0/255.0, green: 119.0/255.0, blue: 159.0/255.0, alpha: 1.0).cgColor, UIColor(displayP3Red: 50.0/255.0, green: 205.0/255.0, blue: 165.0/255.0, alpha: 1.0).cgColor]
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 1, y: 0)
           
           if let image = getImageFrom(gradientLayer: gradient) {
               navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
           }
        }
        
        
        //// adding shadow
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.8
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 2
        
    }
    
    func getImageFrom(gradientLayer:CAGradientLayer) -> UIImage? {
        var gradientImage:UIImage?
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }

}
