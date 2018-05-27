//
//  CoreDataHandler.swift
//  Events
//
//  Created by Rayan Aldafas on 26/05/2018.
//  Copyright © 2018 RayanAldafas. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHandler: NSObject {
    
    
    // set up and return context
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.persistentContainer.viewContext
    }
    
    // save object
    class func saveObject(name: String, date: String, eventDescription: String, image: NSData) -> Bool {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Event", in: context)
        let newObject = NSManagedObject(entity: entity!, insertInto: context)
        
        newObject.setValue(name, forKey: "name")
        newObject.setValue(eventDescription, forKey: "eventDescription")
        newObject.setValue(image, forKey: "image")
        newObject.setValue(date, forKey: "date")
        
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    // fetch objects, returns array on events
    class func fetchObjects() -> [Event]? {
        let context = getContext()
        var events:[Event]? = nil
        
        do {
            events = try context.fetch(Event.fetchRequest())
            return events
        } catch {
            return events
        }
    }
    
    // delete all objects
    class func deleteAll() -> Bool {
        let context = getContext()
        let deleteAll = NSBatchDeleteRequest(fetchRequest: Event.fetchRequest())
        
        do {
            try context.execute(deleteAll)
            return true
        } catch {
            return false
        }
        
    }
    

}
