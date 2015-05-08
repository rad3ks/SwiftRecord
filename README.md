# SwiftRecord [![CocoaPod][pd-bdg]][pd] [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[pd-bdg]: https://img.shields.io/cocoapods/v/SwiftRecord.svg
[pd]: http://cocoadocs.org/docsets/ObjectiveRecord

ActiveRecord style Core Data object management. Tremendously convenient and easy to use. Necessary for any and every Core Data project.

Written purely in Swift and based heavily on [ObjectiveRecord](https://github.com/supermarin/ObjectiveRecord)

Easy creates, saves, deletes and queries. Do it using:

- `[String:AnyObject]` dictionaries for creates, queries or sorts
- `String` for queries and sorts, ie `name == 'someName'` or `date ASC`
- `NSPredicate` and `NSSortDescriptor`/`[NSSortDescriptor]` for queries and sorts if you'd like

This library also reads in your json dictionaries for you. Includes automatic camelCase changing ie `first_name` from server to `firstName` locally. You can customize the dictionary mappings too. Read more in the [mapping section](#mapping). 

Object relationships are also generated from dictionaries, but disabled by default. Set `SwiftRecord.generateRelationships` to true to enable this feature. See the [relationships section](#relationships)

## Installation

#### via [CocoaPods](http://cocoapods.org)
1. Edit your Podfile to use frameworks and add SwiftRecord:
		
		platform :ios, '8.0'
		use_frameworks!
	
		pod 'SwiftRecord', '~> 0.0.1'
2. run `pod install`

#### via Carthage


#### Manual Installation
Drag and drop either `Classes/SwiftRecord.swift` or `SwiftRecord.framework` into your project

## Usage

1. At the top of every `NSManagedObject` swift class add:

	```swift
	import SwiftRecord
	
	class Event: NSManagedObject {
		@NSManaged var eventID: NSNumber
		@NSManaged var name: String
		@NSManaged var type: String
		@NSManaged var when: NSDate
		@NSManaged var creator: User
		@NSManaged var attendess: NSSet
	}
	```
2. Set up Core Data by naming your model file `MyAppName.xcdatamodel` 

### create, save & delete:

```swift
var event = Event.create() as! Event // Downcasts are necessary, 
event.type = "Birthday"
event.when = NSDate()
event.save() // simple save
event.delete() // simple delete

var properties: [String:AnyObject] = ["name":"productQA","type":"meeting", "when":NSDate()]
var meeting = Event.create(properties) as! Event // Remember to downcast
```

Note: the downside to using swift is that `NSManagedObject` and `[NSManagedObject]`(arrays) are returned, so api calls have to down casted into your class type. Feel free to always force downcast. `MyObject` calls will always create `MyObject` unless your class could not be found

### querying

everything here is the same, except `where` are now `query` (where is a swift reserved keyword)

```swift
// grab all Events
var events = Event.all() as! [Event]

// all past events before now
var pastEvents = Event.query("when < \(NSDate().timeIntervalSince1970)") as! [Event]

// specific event, yes we still have support for objc formats. Note, finding specific events return optional vars
var thisEvent = Event.find("name == %@ AND when == %@", "productQA", NSDate()) as? Event

// Use dictionaries to query too
var birthdayEvents = Event.query(["type":"birthday"]) as! [Event]

// or NSPredicates
var predicate = NSPredicate("type == %@", "meeting")
var meetingEvents = Event.query(predicate) as! [Event]
```

### sorting, limits

```swift
// Events sorted by date, defaults to ascending
var events = Event.all(sort: "when") as! [Event]
// Descending
var descendingEvents = Event.all(sort:["when":"DESC"]) as! [Event]
// or
var descEvents = Event.all(sort:"when DESC, eventID ASC")

// All meeting events sorted by when desc and eventID ascending and limit 10
var theseEvents = Event.query(["type:"meeting"], sort:["when":"DESC","eventID":"ASC"], limit: 10) as! [Event]

// NSSortDescriptor as sort arg (or array of NSSortDescriptors
Event.all(sort: NSSortDescriptor(key:"when",ascending:true))
```

### Aggregation

```swift
// count all Events
var count = Event.count()

// count meeting Events
var count = Event.count("type == 'meeting'")
```

### Custom Core Data

#### Custom ManagedObjectContext
if you made your own, feel free to set it

```swift
var myContext: NSManagedObjectContext = ...

CoreDataManager.sharedManager.managedObjectContext = myContext
```

#### Custom CoreData model or .sqlite database
Don't set these if you set your own context.
If you have a modelName different from the name of your app, set it. If you want a different databse name, set it.
```swift
CoreDataManager.sharedManager.modelName = "MyModelName"
CoreDataManager.sharedManager.databaseName = "custom_database_name"
```

### Mapping

The most of the time, your JSON web service returns keys like `first_name`, `last_name`, etc. <br/>
Your Swift implementation has camelCased properties - `firstName`, `lastName`.<br/>

We automatically check against camelCase variations.

If you have different variations, override `static func mappings() -> [String:String]` to specify your local to remote key mapping

The key string is your local name, the value string, your remote name.

```swift
// this method is called once, so you don't have to do any caching / singletons
class Event: NSManagedObject {

override class func mappings() -> [String:String] {
	return ["localName":"remoteName","eventID":"_id","attendees":"people"]
}
  // firstName => first_name is automatically handled
}

@end
```

### Relationships
While it is advised against, you can have your NSManagedObject relationships in your dictionaries and they will be filled, but first you must enable it by setting:

	SwiftRecord.generateRelationships = true
	
Once this is set, you rels will be filled, ie:

```swift
var personDict = ["email":"zaid@arkverse.com","firstName":"zaid"]
var eventDict = ["name":"product QA meeting","when":NSDate(),"creator":personDict]
var event = Event.create(eventDict) as! Event
var person: Person = event.creator
println(person.username)
```

#### Testing

ObjectiveRecord supports CoreData's in-memory store. In any place, before your tests start running, it's enough to call
```swift
CoreDataManager.sharedManager.useInMemoryStore()
```

#### Roadmap

- improve Swiftiness
- Swift memory mgmt
- json generating

## License

SwiftRecord is available under the MIT license. See the LICENSE file
for more information.