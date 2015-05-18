//
//  ViewController.swift
//  PListTest
//
//  Created by Chris Wardman on 17/05/2015.
//  Copyright (c) 2015 Chris Wardman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var tripNumber: AnyObject!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPList()
        saveCount(234)
    
    }
    
    func documentsPath() -> String {
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask,
            true)
        let documentsDirectory = paths[0] as! String
        
        return documentsDirectory.stringByAppendingPathComponent("anyoldplist.plist")
        
    }
    
    func loadPList() {
        
        
        let fileManager = NSFileManager.defaultManager()
        
        if !fileManager.fileExistsAtPath(documentsPath()) {
            if let bundlePath = NSBundle.mainBundle().pathForResource("anyoldplist", ofType: "plist") {
                fileManager.copyItemAtPath(bundlePath, toPath: documentsPath(), error: nil)
            }
        }
        
        if let dict = NSMutableDictionary(contentsOfFile: documentsPath()) {
            tripNumber = dict.objectForKey("tripCount")
        }
    }
    
    func saveCount(tripNum: Int) {
        
        
        let fileManager = NSFileManager.defaultManager()
        ()
        if !fileManager.fileExistsAtPath(documentsPath()) {
            
            println("Error")
            
        } else {
            
            let dict = NSMutableDictionary(contentsOfFile: documentsPath())
            dict?.setObject(tripNum, forKey: "tripCount")
            dict?.writeToFile(documentsPath(), atomically: false)
        }
    }
}

