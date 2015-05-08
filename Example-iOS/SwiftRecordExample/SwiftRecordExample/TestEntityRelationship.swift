//
//  TestEntityRelationship.swift
//  SwiftRecordExample
//
//  Created by Zaid on 5/8/15.
//  Copyright (c) 2015 ark. All rights reserved.
//

import Foundation
import CoreData
import SwiftRecord

class TestEntityRelationship: NSManagedObject {

    @NSManaged var string: String
    @NSManaged var relationship: TestEntity
    @NSManaged var relationships: TestEntity

}
