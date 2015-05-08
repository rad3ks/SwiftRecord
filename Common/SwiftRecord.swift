//
//  SwiftRecord.swift
//  
//
//  Created by Zaid on 5/7/15.
//
//

import Foundation
import CoreData

public class CoreDataManager {
    
    public let appName = NSBundle.mainBundle().infoDictionary!["CFBundleName"] as! String
    
    public var databaseName: String {
        get {
            if let db = self._databaseName {
                return db
            } else {
                return self.appName + ".sqlite"
            }
        }
        set {
            _databaseName = newValue
        }
    }
    private var _databaseName: String?
    
    public var modelName: String {
        get {
            if let model = _modelName {
                return model
            } else {
                return appName
            }
        }
        set {
            _modelName = newValue
        }
    }
    private var _modelName: String?
    
    public var managedObjectContext: NSManagedObjectContext {
        if let context = _managedObjectContext {
            return context
        } else {
            let c = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
            c.persistentStoreCoordinator = persistentStoreCoordinator
            _managedObjectContext = c
            return c
        }
    }
    private var _managedObjectContext: NSManagedObjectContext?
    
    public var persistentStoreCoordinator: NSPersistentStoreCoordinator {
        if let store = _persistentStoreCoordinator {
            return store
        } else {
            let p = self.persistentStoreCoordinator(NSSQLiteStoreType, storeURL: self.sqliteStoreURL)
            _persistentStoreCoordinator = p
            return p
        }
    }
    private var _persistentStoreCoordinator: NSPersistentStoreCoordinator?
    
    public var managedObjectModel: NSManagedObjectModel {
        if let m = _managedObjectModel {
            return m
        } else {
            let modelURL = NSBundle.mainBundle().URLForResource(self.modelName, withExtension: "momd")
            _managedObjectModel = NSManagedObjectModel(contentsOfURL: modelURL!)
            return _managedObjectModel!
        }
    }
    private var _managedObjectModel: NSManagedObjectModel?
    
    public func useInMemoryStore() {
        _persistentStoreCoordinator = self.persistentStoreCoordinator(NSInMemoryStoreType, storeURL: nil)
    }
    
    public func saveContext() -> Bool {
        if !self.managedObjectContext.hasChanges {
            return false
        }
        let error: NSErrorPointer = NSErrorPointer()
        if (!self.managedObjectContext.save(error)) {
            println("Unresolved error in saving context! " + error.debugDescription)
            return false
        }
        return true
    }
    
    public func applicationDocumentsDirectory() -> NSURL {
        return NSFileManager.defaultManager().URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask).last as! NSURL
    }
    
    public func applicationSupportDirectory() -> NSURL {
        return (NSFileManager.defaultManager().URLsForDirectory(NSSearchPathDirectory.ApplicationSupportDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask).last as! NSURL).URLByAppendingPathComponent(self.appName)
    }
    
    private var sqliteStoreURL: NSURL {
        #if os(iOS)
            let dir = self.applicationDocumentsDirectory()
        #else
            let dir = self.applicationSupportDirectory()
            self.createApplicationSupportDirIfNeeded(dir)
        #endif
        return dir.URLByAppendingPathComponent(self.databaseName)
        
    }
    
    private func persistentStoreCoordinator(storeType: String, storeURL: NSURL?) -> NSPersistentStoreCoordinator {
        let c = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let error = NSErrorPointer()
        if c.addPersistentStoreWithType(storeType, configuration: nil, URL: storeURL, options: [NSMigratePersistentStoresAutomaticallyOption:true,NSInferMappingModelAutomaticallyOption:true], error: error) == nil {
            println("ERROR WHILE CREATING PERSISTENT STORE COORDINATOR! " + error.debugDescription)
        }
        return c
    }
    
    private func createApplicationSupportDirIfNeeded(dir: NSURL) {
        if NSFileManager.defaultManager().fileExistsAtPath(dir.absoluteString!) {
            return
        }
        NSFileManager.defaultManager().createDirectoryAtURL(dir, withIntermediateDirectories: true, attributes: nil, error: nil)
    }
    // singleton
    public static let sharedManager = CoreDataManager()
}

public extension NSManagedObjectContext {
    public static var defaultContext: NSManagedObjectContext {
        return CoreDataManager.sharedManager.managedObjectContext
    }
}

public extension NSManagedObject {
    
    public static func all() -> [NSManagedObject] {
        return self.all(NSManagedObjectContext.defaultContext)
    }
    
    public static func all(#order: AnyObject) -> [NSManagedObject] {
        return self.all(NSManagedObjectContext.defaultContext, withOrder:order)
    }
    
    public static func all(context: NSManagedObjectContext) -> [NSManagedObject] {
        
    }
    
    public static func all(context: NSManagedObjectContext, withOrder order: AnyObject) -> [NSManagedObject] {
        
    }
}