//
//  CollageTableViewController.swift
//  CollageApp
//
//  Created by Владимир Ребриков on 18/06/2019.
//  Copyright © 2019 Владимир Ребриков. All rights reserved.
//

import UIKit

class CollageTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var collages: [CollageItem] {
        return CollageItem.objectArrayFromDictArray(dictArray: NSArray(contentsOfFile: Bundle.main.path(forResource: "Collages", ofType: "plist")!)! as! [[String:Any]])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.collages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCellX")!
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = testViewController.controllerWithCollageItem(item: self.collages[indexPath.row])
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
