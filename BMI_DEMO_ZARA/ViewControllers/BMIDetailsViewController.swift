//
//  ViewController.swift
//  BMI_DEMO_ZARA
//
//  Created by Zara Davtyan on 2/26/20.
//  Copyright © 2020 Zara Davtyan. All rights reserved.
//

import UIKit
import GoogleMobileAds

class BMIDetailsViewController: BaseViewController {
    
    enum PickerTag:Int {
        case weight = 0
        case height
        case gender
    }

    @IBOutlet var tapGesture: UITapGestureRecognizer!
    @IBOutlet weak var nameCover: UIView!
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var pickerCover: UIView!
    @IBOutlet weak var weightsTB: UITableView!
    @IBOutlet weak var heightsTB: UITableView!
    @IBOutlet weak var genderTB: UITableView!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var bannerView: GADBannerView!
    
    
    /////// view model
    var selectedWeightTag:Int = 1
    var selectedHeightTag:Int = 1
    var selectedGenderTag:Int = 1
    //////// view model
    
    var interstitial: GADInterstitial!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// setupTableviews
        weightsTB.register(UINib(nibName: "PickerCell", bundle: nil), forCellReuseIdentifier: "PickerCellId")
        heightsTB.register(UINib(nibName: "PickerCell", bundle: nil), forCellReuseIdentifier: "PickerCellId")
        genderTB.register(UINib(nibName: "PickerCell", bundle: nil), forCellReuseIdentifier: "PickerCellId")
        ////
        
        self.navigationItem.title = "ADD BMI DETAILS"
        
        tapGesture.addTarget(self, action:#selector(tapOnTheScreen))
        self.view.addGestureRecognizer(tapGesture)
        
        
        self.setupUI()
        
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        
        bannerView.load(GADRequest())
        
        
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        let request = GADRequest()
        interstitial.load(request)
    }
    
    func setupUI() {
        nameCover.layer.cornerRadius = 4.0
        nameCover.layer.borderColor = defaultTextGray.cgColor
        nameCover.layer.borderWidth = 1.0
        nameTxtField.returnKeyType = .done
    }
    
    @objc func tapOnTheScreen() {
        nameTxtField.resignFirstResponder()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pickerCover.layer.addShadow()
        calculateButton.layer.addGradient(withRadius: 3.0)
        calculateButton.setTitle("Calculate", for: .normal)
        calculateButton.layer.addShadow()
    }
    
    @IBAction func calculateAction(_ sender: Any) {
        if interstitial.isReady {
          interstitial.present(fromRootViewController: self)
        } else {
          print("Ad wasn't ready")
        }
    }
    
}

extension BMIDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView.tag {
        case PickerTag.height.rawValue:
            return 200
        case PickerTag.weight.rawValue:
            return 200
        case PickerTag.gender.rawValue:
            return 2
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PickerCell = tableView.dequeueReusableCell(withIdentifier: "PickerCellId", for: indexPath) as! PickerCell
        cell.tag = indexPath.row
        switch tableView.tag {
        case PickerTag.weight.rawValue:
            cell.value.text = String(indexPath.row)
            if cell.tag == selectedWeightTag {
                cell.value.textColor = highlightBlue
                cell.underline.isHidden = false
                let fontSize = cell.value.font.pointSize
                cell.value.font = UIFont(name: "SegoeUI-Bold", size: fontSize)
                tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
            }
            else {
                cell.value.textColor = defaultTextGray
                cell.underline.isHidden = true
                let fontSize = cell.value.font.pointSize
                cell.value.font = UIFont(name: "SegoeUI", size: fontSize)
            }
            break
        case PickerTag.height.rawValue:
            cell.value.text = String(indexPath.row)
            if cell.tag == selectedHeightTag {
                cell.value.textColor = highlightBlue
                cell.underline.isHidden = false
                let fontSize = cell.value.font.pointSize
                cell.value.font = UIFont(name: "SegoeUI-Bold", size: fontSize)
                tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
            }
            else {
                cell.value.textColor = defaultTextGray
                cell.underline.isHidden = true
                let fontSize = cell.value.font.pointSize
                cell.value.font = UIFont(name: "SegoeUI", size: fontSize)
            }
            break
        case PickerTag.gender.rawValue:
            if indexPath.row == 0 {
                cell.value.text = "Male"
            }
            else if indexPath.row == 1 {
                cell.value.text = "Female"
            }
            
            if cell.tag == selectedGenderTag {
                 cell.value.textColor = highlightBlue
                 cell.underline.isHidden = false
                 tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
                let fontSize = cell.value.font.pointSize
                 cell.value.font = UIFont(name: "SegoeUI-Bold", size: fontSize)
            }
            else {
                cell.value.textColor = defaultTextGray
                cell.underline.isHidden = true
                let fontSize = cell.value.font.pointSize
                cell.value.font = UIFont(name: "SegoeUI", size: fontSize)
            }
            break
        default:
            break
        }
        cell.underlineWidth.constant = ((cell.value.text?.getSizeWithFont(font: cell.value.font).width ?? 25) + 20)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.height/3
    }
    

    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        switch scrollView.tag {
        case PickerTag.weight.rawValue:
            if weightsTB.visibleCells.count >= 2 {
                let cell:PickerCell = weightsTB.visibleCells[1] as! PickerCell
                selectedWeightTag = cell.tag
                weightsTB.reloadData()
            }
            break
        case PickerTag.height.rawValue:
           if heightsTB.visibleCells.count >= 2 {
             let cell:PickerCell = heightsTB.visibleCells[1] as! PickerCell
             selectedHeightTag = cell.tag
             heightsTB.reloadData()
           }
          break
        case PickerTag.gender.rawValue:
            let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
            if translation.y > 0 {
                // swipes from top to bottom of screen -> down
                selectedGenderTag = 0
            } else {
                // swipes from bottom to top of screen -> up
                selectedGenderTag = 1
            }
            genderTB.reloadData()
            break
        default:
            break
        }
    }
}

extension BMIDetailsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


