//
//  testViewController.swift
//  CollageApp
//
//  Created by Владимир Ребриков on 14/06/2019.
//  Copyright © 2019 Владимир Ребриков. All rights reserved.
//

import UIKit



class testViewController: UIViewController, XcollageViewProtocol, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate {
    
    @IBOutlet var deleteView: UIView!
    @IBOutlet var collageViewX: collageView!
    var collageItem: CollageItem?
    var selectedElement: collage?
    //var color = UIColor.black
    let layer1 = CALayer()
    func setUpLayer() {
      
        //selectedElement?.layer.backgroundColor = UIColor.red.cgColor
     
        for relativeFrame in self.collageViewX.allElements {
            
            
            //element.layer.backgroundColor = UIColor.red.cgColor
            //element.layer.isGeometryFlipped = false
            //            element.layer.cornerRadius = 100.0
            relativeFrame.layer.borderWidth = 12.0
            relativeFrame.layer.borderColor = UIColor.white.cgColor
            
            relativeFrame.layer.shadowOpacity = 0.75
            relativeFrame.layer.shadowOffset = CGSize(width: 0, height: 3)
            relativeFrame.layer.shadowRadius = 3.0
        }
    }
    
    class func controllerWithCollageItem(item: CollageItem) -> testViewController {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "testViewController") as! testViewController
        controller.collageItem = item
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.loadCollagesX()
        setUpLayer()
        updateUI()
        
        self.deleteView.backgroundColor = UIColor.white
       
    }
    
    
    
    @IBAction func testSlider(_ sender: UISlider) {
        for element in self.collageViewX.allElements {
            
            //element.layer.borderColor = UIColor.green.cgColor // Border Color
            //element.layer.borderWidth = CGFloat(sender.value) //12 0 20 Border Width
            element.layer.cornerRadius = CGFloat(sender.value) // 20 0 50 Corner Radius
            //element.layer.shadowOpacity =  sender.value // 0.75 0 1 Shadow Opacity
            //element.layer.shadowRadius = CGFloat(sender.value) // shadowRadius
        }
    }
    //    @IBAction func borderColorSliderChanged(_ sender: UISlider) {
    //        let colorAndLabel = colorAndLabelForSliders(borderColorSliders)
    //        layerViewController.layer.borderColor = colorAndLabel.color
    //        borderColorSlidersValueLabel.text = colorAndLabel.label
    //    }
    //
    //    @IBAction func backgroundColorSliderChanged(_ sender: UISlider) {
    //        let colorAndLabel = colorAndLabelForSliders(backgroundColorSliders)
    //        layerViewController.layer.backgroundColor = colorAndLabel.color
    //        backgroundColorSlidersValueLabel.text = colorAndLabel.label
    //    }
    //
    //    @IBAction func shadowOffsetSliderChanged(_ sender: UISlider) {
    //        let width = CGFloat(shadowOffsetSliders[0].value)
    //        let height = CGFloat(shadowOffsetSliders[1].value)
    //        layerViewController.layer.shadowOffset = CGSize(width: width, height: height)
    //        shadowOffsetSlidersValueLabel.text = "Width: \(Int(width)), Height: \(Int(height))"
    //    }
    //
    //    @IBAction func shadowColorSliderChanged(_ sender: UISlider) {
    //        let colorAndLabel = colorAndLabelForSliders(shadowColorSliders)
    //        layerViewController.layer.shadowColor = colorAndLabel.color
    //        shadowColorSlidersValueLabel.text = colorAndLabel.label
    //    }
    
    
    
    //Helpers
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
    
    func colorAndLabelForSliders(_ sliders: [UISlider]) -> (color: CGColor, label: String) {
        let red = CGFloat(sliders[0].value)
        let green = CGFloat(sliders[1].value)
        let blue = CGFloat(sliders[2].value)
        let color = UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0).cgColor
        let label = "RGB: \(Int(red)), \(Int(green)), \(Int(blue))"
        return (color: color, label: label)
    }
    
    func updateUI() {
        
        title = "your Collage"
        
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveCollage))
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
    }
    
    @objc func saveCollage() {
        let image = collageViewX.getSnapshotImage()
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        let alert = UIAlertController(title: "Внимание !", message: "Картинка сохранена в галлерее! ", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func loadCollagesX() {
        self.collageViewX.delegate = self
        self.collageViewX.placeholderImage = UIImage(named: "placeHolder")
        self.collageViewX.initializeCollageView(relativeFrames: self.collageItem?.relativeFrames ?? [String]())
        self.collageViewX.deleteView = deleteView
        
    }
    func didEnterDeleteView(collageElement: collage, deleteView: UIView) {
        self.deleteView.backgroundColor = UIColor.red
    }
    
    func didLeaveDeleteView(collageElement: collage, deleteView: UIView) {
        self.deleteView.backgroundColor = UIColor.white
    }
    
    func didDeleteImageInElement(collageElement: collage) {
        self.deleteView.backgroundColor = UIColor.white
    }
    
    func didSelectCollageElement(element: collage) {
        self.selectedElement = element
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    func cancelButtonDidPress(_ imagePicker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func wrapperDidPress(_ imagePicker: UIImagePickerController, images: [UIImage]) {
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let currentImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.selectedElement?.addElementImage(image: currentImage)
        picker.dismiss(animated: true, completion: nil)
    }
}
