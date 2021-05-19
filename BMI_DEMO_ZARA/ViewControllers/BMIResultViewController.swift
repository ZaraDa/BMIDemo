//
//  BMIResultViewController.swift
//  BMI_DEMO_ZARA
//
//  Created by Zara Davtyan on 2/28/20.
//  Copyright © 2020 Zara Davtyan. All rights reserved.
//

import UIKit
import GoogleMobileAds
import StoreKit

class BMIResultViewController: UIViewController {
    
    @IBOutlet weak var infoValue: UILabel!
    @IBOutlet weak var indexValue: UILabel!
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var bannerView: GADBannerView!
    
    @IBOutlet weak var viewShare: UIView!
    @IBOutlet weak var viewRate: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "BMI DETAILS"
        setupUI()
        loadAd()
    }
    
    func setupUI() {
        
        viewShare.layer.cornerRadius = 8.0
        viewShare.layer.borderColor = UIColor.white.cgColor
        viewShare.layer.borderWidth = 1.0
        
        viewRate.layer.cornerRadius = 8.0
        viewRate.layer.borderColor = UIColor.white.cgColor
        viewRate.layer.borderWidth = 1.0
    }
    
    func loadAd() {
        bannerView.adUnitID = BannerId.resultsScreenBannerId
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    
    func setIndexValue() {
        //// get value and parse in view model
        let firstValue = "18"
        let secondValue  =  ".61"
        
        let attributedValue = NSMutableAttributedString(string:firstValue)
        
        attributedValue.addAttribute(.font, value: UIFont(name: "SegoeUI-Bold", size: 100)!, range: NSRange(location: 0, length: firstValue.count))
        
        let secondAttributed = NSMutableAttributedString(string: secondValue)
        
        secondAttributed.addAttribute(.font, value: UIFont(name: "SegoeUI-Bold", size: 50)!, range:NSRange(location: 0, length: secondValue.count))
        
        attributedValue.append(secondAttributed)
        ////////
        indexValue.attributedText = attributedValue
    }
    
    func setupInfoValue() {
        ///// get value from vm and parse
        let text1 = "Hello Olivia you are good"
        let text2 = "\n Normal BMI range: 18.8kg/m2 - 25kg/m2 \n Ponderal index: 10.64kg/m3"
        
        
        let fontSize  = infoValue.font.pointSize
        let attributed1 = NSMutableAttributedString(string: text1)
        attributed1.addAttribute(.font, value: UIFont(name: "SegoeUI-Bold", size: fontSize)!, range: NSRange(location: 0, length: text1.count))
        
        let attributed2 = NSMutableAttributedString(string: text2)
        attributed2.addAttribute(.font, value: UIFont(name: "SegoeUI", size: fontSize)!, range: NSRange(location: 0, length: text2.count))
        attributed1.append(attributed2)
        infoValue.attributedText = attributed1
        /////
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        coverView.layer.addGradient(withRadius: 8.0, startPoint:CGPoint(x: 0, y: 0), endPoint:CGPoint(x: 1, y: 1))
        setIndexValue()
        setupInfoValue()
    }
    
    @IBAction func shareAction(_ sender: Any) {
        
        let text = "Share your result!"
        let image : UIImage = screenshot()
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [text, image], applicationActivities: nil)
        
        activityViewController.popoverPresentationController?.sourceView = self.infoValue
        
        
        // This lines is for the popover you need to show in iPad
        activityViewController.popoverPresentationController?.sourceView = (sender as! UIButton)
        
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
        
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToTencentWeibo,
            UIActivity.ActivityType.postToTwitter,
            UIActivity.ActivityType.postToFacebook,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.openInIBooks
        ]
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    func screenshot() -> UIImage {
        
        let imageSize = UIScreen.main.bounds.size as CGSize;
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
        let context = UIGraphicsGetCurrentContext()
        for obj : AnyObject in UIApplication.shared.windows {
            if let window = obj as? UIWindow {
                if window.responds(to: #selector(getter: UIWindow.screen)) || window.screen == UIScreen.main {
                    // so we must first apply the layer's geometry to the graphics context
                    context!.saveGState();
                    // Center the context around the window's anchor point
                    context!.translateBy(x: window.center.x, y: window.center
                                            .y);
                    // Apply the window's transform about the anchor point
                    context!.concatenate(window.transform);
                    // Offset by the portion of the bounds left of and above the anchor point
                    context!.translateBy(x: -window.bounds.size.width * window.layer.anchorPoint.x,
                                         y: -window.bounds.size.height * window.layer.anchorPoint.y);
                    
                    // Render the layer hierarchy to the current context
                    window.layer.render(in: context!)
                    
                    // Restore the context
                    context!.restoreGState();
                }
            }
        }
        let image = UIGraphicsGetImageFromCurrentImageContext();
        return image!
    }
    
    
    @IBAction func rateAction(_ sender: Any) {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
            
        } else if let url = URL(string: "itms-apps://itunes.apple.com/app/" + "appId") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    
}
