//
//  TestEntity.swift
//  SwiftRecordExample
//
//  Created by Zaid on 5/8/15.
//  Copyright (c) 2015 ark. All rights reserved.
//

import Foundation
import CoreData
import SwiftRecord

class TestEntity: NSManagedObject {

    @NSManaged var string: String
    @NSManaged var date: NSDate
    @NSManaged var integer: NSNumber
    @NSManaged var float: NSNumber
    @NSManaged var relationship: TestEntityRelationship
    @NSManaged var relationships: NSSet

}
