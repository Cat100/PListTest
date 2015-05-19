//
//  ViewController.swift
//  PListTest
//
//  Created by Chris Wardman on 17/05/2015.
//  Copyright (c) 2015 Chris Wardman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var tripNumber = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var count: Int = loadPList()
        println(count)
        saveCount(++count)
        println(count)
    }
    
    
    func loadPList() -> Int {
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask,
            true)
        let documentsDirectory = paths[0] as! String
        let documentsPath = documentsDirectory.stringByAppendingPathComponent("appValues.plist")
        
        println(documentsPath)
        
        let fileManager = NSFileManager.defaultManager()
        
        if !fileManager.fileExistsAtPath(documentsPath) {
            if let bundlePath = NSBundle.mainBundle().pathForResource("anyoldplist", ofType: "plist") {
                fileManager.copyItemAtPath(bundlePath, toPath: documentsPath, error: nil)
            }
        }
        
        if let dict = NSMutableDictionary(contentsOfFile: documentsPath) {
            tripNumber = dict.objectForKey("tripCount") as! Int
        }
        return tripNumber
    }
    
    func saveCount(tripNum: Int) {
        println("<--> \(tripNum)")
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask,
            true)
        let documentsDirectory = paths[0] as! String
        let documentsPath = documentsDirectory.stringByAppendingPathComponent("appValues.plist")
        
        let fileManager = NSFileManager.defaultManager()
        
        if !fileManager.fileExistsAtPath(documentsPath) {
            
            println("Error")
            
        } else {
            
            let dict = NSMutableDictionary(contentsOfFile: documentsPath)
            dict?.setObject(tripNum, forKey: "tripCount")
            dict?.writeToFile(documentsPath, atomically: false)
        }
    }
}

