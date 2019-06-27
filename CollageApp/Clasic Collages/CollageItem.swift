//
//  CollageItem.swift
//  CollageApp
//
//  Created by Владимир Ребриков on 07/06/2019.
//  Copyright © 2019 Владимир Ребриков. All rights reserved.
//

import Foundation

class CollageItem {
    
    var relativeFrames = [String]()
    
    init(json:[String:Any]) {
        
        if let frames = json["relativeFramesStrings"] as? [String] {
            self.relativeFrames = frames
        }
    }
    
    class func objectArrayFromDictArray(dictArray:[[String:Any]]) -> [CollageItem] {
        var objects = [CollageItem]()
        for dict in dictArray {
            objects.append(CollageItem(json: dict))
        }
        return objects
    }
}
