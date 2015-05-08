//
//  ViewController.swift
//  SwiftRecordExample
//
//  Created by Zaid on 5/8/15.
//  Copyright (c) 2015 ark. All rights reserved.
//

import Foundation
import UIKit
import SwiftRecord

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var test: TestEntity = TestEntity.create(properties: ["string":"testString", "date":NSDate(), "integer":NSNumber(integer: 5), "float":NSNumber(float: 5)]) as! TestEntity
        println("test.string = " + test.string)
        println("test.date = \(test.date)")
        println("test.integer = \(test.integer)")
        println("test.float = \(test.float)")
        test.save()
        var testrel = TestEntityRelationship.create(properties: ["string":"someName"]) as! TestEntityRelationship
        testrel.save()
        
        SwiftRecord.generateRelationships = true
        //SwiftRecord.setUpEntities(["TestEntity":TestEntity.self,"TestEntityRelationship":TestEntityRelationship.self])
        
        var test2 = TestEntity.create(properties: ["string":"testString2", "relationship":["string":"anotherName"],"relationships":[["string":"array1"],["string":"array2"],["string":"array3"]]]) as! TestEntity
        println(test2.string)
        println(test2.relationship.string)
        for er in test2.relationships {
            let e = er as! TestEntityRelationship
            println(e.string)
        }
        
        test2.save()
        test2.delete()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

