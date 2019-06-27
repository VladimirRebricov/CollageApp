//
//  primer.swift
//  CollageApp
//
//  Created by Владимир Ребриков on 17/06/2019.
//  Copyright © 2019 Владимир Ребриков. All rights reserved.
//

import UIKit


//class testViewController: UIViewController {
//
//    var currentCollage : collage! = nil
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        let w = view.frame.width
//        let h = view.frame.width
//
//
//        let frames = [CGRect(x: 0, y: 0, width: w/2, height: h),CGRect(x: w/2, y: 0, width: w/2, height: h/2),CGRect(x: w/2, y: h/2, width: w/2, height: h/2)]
//
//
//        currentCollage = collage(frame: CGRect(x: 0, y: 80, width: view.frame.width, height: view.frame.width), imageFrames: frames)
//        view.addSubview(currentCollage)
//    }
//
//    /*
//     // MARK: - Navigation
//
//     // In a storyboard-based application, you will often want to do a little preparation before navigation
//     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//     // Get the new view controller using segue.destination.
//     // Pass the selected object to the new view controller.
//     }
//     */
//
//}




//class collage: UIView, UIGestureRecognizerDelegate
//{
//    var localframes:[CGRect]! = nil
//
//    var rotationRecognizers = [UIRotationGestureRecognizer]()
//    var panRecognizers = [UIPanGestureRecognizer]()
//    var zoomRecognizers = [UIPinchGestureRecognizer]()
//
//
//
//    init(frame: CGRect,imageFrames:[CGRect])
//    {
//        super.init(frame: frame)
//        localframes = imageFrames
//        self.backgroundColor = .red
//        for i in localframes
//        {
//            addViewToCollage(Cframe: i)
//        }
//    }
//
//    func addViewToCollage(Cframe:CGRect)
//    {
//        let baseView = UIView(frame: Cframe)
//        let currentImage = UIImageView(frame: CGRect(x: 0, y: 0, width: Cframe.size.width, height: Cframe.size.height))
//        baseView.addSubview(currentImage)
//        currentImage.contentMode = .center
//        currentImage.image = UIImage(named: "placeHolder")
//        baseView.layer.borderColor  = UIColor.black.cgColor
//        baseView.layer.borderWidth = 2
//        addSubview(baseView)
//
//    }
//    required init?(coder aDecoder: NSCoder)
//    {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//
//}

