//
//  AppDelegate.swift
//  Todoey
//
//  Created by Shah, Raj Kumar-CW on 2/2/18.
//  Copyright © 2018 Shah, Raj Kumar-CW. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        do{
          _ = try Realm()
            
        }catch{
            print("Eror initializing new Realm \(error)")
        }
        return true
    }


}

