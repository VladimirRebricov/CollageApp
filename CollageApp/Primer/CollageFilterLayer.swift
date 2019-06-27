//
//  CollageFilterLayer.swift
//  CollageApp
//
//  Created by Владимир Ребриков on 13/06/2019.
//  Copyright © 2019 Владимир Ребриков. All rights reserved.
//

//import UIKit
//
//class CollageFilterLayer: UIViewController {
//   
//    @IBOutlet var sliders: [UISlider]!
//    @IBOutlet var bordersColorSliders: [UISlider]!
//    @IBOutlet var shadowOffsetSliders: [UISlider]!
//    @IBOutlet var shadowColorSliders: [UISlider]!
//    
//    @IBOutlet var borderColorSlidersValueLabel: UILabel!
//
//    @IBOutlet var shadowOffsetSlidersValueLabel: UILabel!
//    @IBOutlet var shadowColorSlidersValueLabel: UILabel!
//    
//    enum Row: Int {
//        case borderWidth, borderColor, backgroundColor, shadowOpacity, shadowOffset, shadowRadius, shadowColor
//    }
//   
//    enum Slider: Int {
//        case opacity, cornerRadius, borderWidth, shadowOpacity, shadowRadius
//    }
//    enum ColorSlider: Int {
//        case red, green, blue
//    }
//    
//    
//    weak var layerViewController: CollageFilterViewController!
//    
//    
//    // MARK: - View life cycle
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        updateSliderValueLabels()
//}
//
// 
//    @IBAction func sliderChanged(_ sender: UISlider) {
//        let slidersArray = sliders as NSArray
//        let slider = Slider(rawValue: slidersArray.index(of: sender))!
//        
//        switch slider {
//        case .opacity:
//            layerViewController.containerView.layer.opacity = sender.value
//        case .cornerRadius:
//            layerViewController.containerView.layer.cornerRadius = CGFloat(sender.value)
//        case .borderWidth:
//            layerViewController.containerView.layer.borderWidth = CGFloat(sender.value)
//        case .shadowOpacity:
//            layerViewController.containerView.layer.shadowOpacity = sender.value
//        case .shadowRadius:
//            layerViewController.containerView.layer.shadowRadius = CGFloat(sender.value)
//    }
//    }
//    
//    @IBAction func borderColorSliderChanged(_ sender: UISlider) {
//        let colorAndLabel = colorAndLabelForSliders(bordersColorSliders)
//        layerViewController.containerView.layer.borderColor = colorAndLabel.color
//        borderColorSlidersValueLabel.text = colorAndLabel.label
//    }
//    
//
//    @IBAction func shadowOffsetSliderChanged(_ sender: UISlider) {
//    }
//    
//    
//    @IBAction func shadowColorSliderChanged(_ sender: UISlider) {
//        let colorAndLabel = colorAndLabelForSliders(shadowColorSliders)
//        layerViewController.containerView.layer.shadowColor = colorAndLabel.color
//        shadowColorSlidersValueLabel.text = colorAndLabel.label
//    }
//    // MARK: - Helpers
//    
//
//    
//    func updateSliderValueLabels() {
//        for slider in Slider.opacity.rawValue...Slider.shadowRadius.rawValue {
//            updateSliderValueLabel(Slider(rawValue: slider)!)
//        }
//    }
//    
//    func updateSliderValueLabel(_ sliderEnum: Slider) {
//        let index = sliderEnum.rawValue
//        let label = sliderValueLabels[index]
//        let slider = sliders[index]
//        
//        switch sliderEnum {
//        case .opacity, .shadowOpacity:
//            label.text = String(format: "%.1f", slider.value)
//        case .cornerRadius, .borderWidth, .shadowRadius:
//            label.text = "\(Int(slider.value))"
//        }
//    }
//    
//    func colorAndLabelForSliders(_ sliders: [UISlider]) -> (color: CGColor, label: String) {
//        let red = CGFloat(sliders[0].value)
//        let green = CGFloat(sliders[1].value)
//        let blue = CGFloat(sliders[2].value)
//        let color = UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0).cgColor
//        let label = "RGB: \(Int(red)), \(Int(green)), \(Int(blue))"
//        return (color: color, label: label)
//    }
//    
//   
//    // MARK: - UITableViewDelegate
//    
//     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let row = Row(rawValue: indexPath.row)!
//        
//        
//    }
//    
//     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let row = Row(rawValue: indexPath.row)!
//        
//       
//    }
//  
//}
