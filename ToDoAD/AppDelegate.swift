//
//  AppDelegate.swift
//  ToDoAD
//
//  Created by Arek on 18/03/2018.
//  Copyright © 2018 Arek. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

   

    func applicationWillTerminate(_ application: UIApplication){
    self.saveContext ()
}



lazy var presistentContainer: NSPersistentContainer = {
    

let container = NSPersistentContainer(name: "DataModel")
container.loadPersistentStores(completionHandler: { (storeDescription, error) in
    if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
    }
    })
    return container
    }()

//MARK: - Core Data Saving Support

func saveContext () {
    let context = presistentContainer.viewContext
    if context.hasChanges {
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
        }
    }


