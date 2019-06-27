//
//  CollageFilterViewController.swift
//  CollageApp
//
//  Created by Владимир Ребриков on 06/06/2019.
//  Copyright © 2019 Владимир Ребриков. All rights reserved.
//


//import UIKit
//import NBCollageView
//
//
//
//class CollageFilterViewController: UIViewController, NBCollageProtocol, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate {
//    
//    
//
//
//    
//    @IBOutlet var containerView: NBCollageView!
//    @IBOutlet var DeleteView: UIView!
//    
//    var collageItem: CollageItem?
//    var selectedElement: NBCollageElement?
//    var color = UIColor.black
//    
//    class func controllerWithCollageItem(item: CollageItem) -> CollageFilterViewController {
//        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CollageFilterViewController") as! CollageFilterViewController
//        controller.collageItem = item
//        return controller
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.view.layoutIfNeeded()
//        self.loadCollages()
//        
//        self.DeleteView.backgroundColor = UIColor.white
//    }
//    
//        @IBAction func actionSlider(_ sender: UISlider) {
//    
//            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
//                switch sender.value {
//                case 0..<0.5 :
//                    self.containerView.transform = CGAffineTransform(scaleX: 1, y: CGFloat(sender.value + 0.5))
//    
//                case 0.5...1:
//                    self.containerView.transform = CGAffineTransform(scaleX: CGFloat(sender.value + 0.5), y: 1)
//    
//                default:
//                    break
//                }
//            }, completion: nil)
//        }
//    
//    ///////////
//    func loadCollages() {
//        self.containerView.delegate = self
//        self.containerView.placeholderImage = UIImage(named: "placeHolder")
//        self.containerView.initializeCollageView(relativeFrames: self.collageItem?.relativeFrames ?? [String]())
//        self.containerView.deleteView = DeleteView
//        for element in self.containerView.allElements {
//            
//            //element.layer.borderColor = UIColor.green.cgColor
//            element.layer.borderWidth = 5
//        }
//    }
//    //    @IBAction func pencilPressed(_ sender: UIButton) {
//    ////        guard let pencil = Pencil(tag: sender.tag) else { // выбор карандаша
//    ////            return
//    ////        }
//    //        //color = pencil.color
//    //        for element in self.containerView.allElements {
//    //
//    //            //element.layer.borderColor = UIColor.green.cgColor
//    //
//    //
//    //            UIView.animate(withDuration: 1, animations: {element.layer.borderColor = UIColor.red.cgColor }, completion: nil)
//    //        }
//    //    }
//    func didEnterDeleteView(collageElement: NBCollageElement, deleteView: UIView) {
//        self.DeleteView.backgroundColor = UIColor.red
//    }
//    
//    func didLeaveDeleteView(collageElement: NBCollageElement, deleteView: UIView) {
//        self.DeleteView.backgroundColor = UIColor.white
//    }
//    
//    func didDeleteImageInElement(collageElement: NBCollageElement) {
//        self.DeleteView.backgroundColor = UIColor.white
//    }
//    
//    func didSelectCollageElement(element: NBCollageElement) {
//        self.selectedElement = element
//        
//        let imagePickerController = UIImagePickerController()
//        imagePickerController.delegate = self
//        present(imagePickerController, animated: true, completion: nil)
//        //imagePickerController.imageLimit = 4
//    }
//    
//    func cancelButtonDidPress(_ imagePicker: UIImagePickerController) {
//        imagePicker.dismiss(animated: true, completion: nil)
//    }
//
//    func wrapperDidPress(_ imagePicker: UIImagePickerController, images: [UIImage]) {
//
//    }
//
////    func doneButtonDidPress(_ imagePicker: UIImagePickerController, images: [UIImage]) {
////        self.selectedElement?.addElementImage(image: images[0])
////        imagePicker.dismiss(animated: true, completion: nil)
////    }
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        let currentImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
//        self.selectedElement?.addElementImage(image: currentImage)
//        picker.dismiss(animated: true, completion: nil)
//    }
//    
////    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
////        if let identifier = segue.identifier {
////            switch identifier {
////            case "DisplayLayerControls":
////                (segue.destination as? CollageFilterLayer)?.layerViewController = self
////            default:
////                break
////            }
////        }
////    }
//    
//}
