//
//  AppDelegate.swift
//  Tip-O-Matic
//
//  Created by Cesar Cavazos on 8/22/17.
//  Copyright © 2017 Cesar Cavazos. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        print("didFinishLaunchingWithOptions")
        // Make all the components orange via the tintColor
        window!.tintColor = UIColor.orange
        // Override point for customization after application launch.
        attemptClearCache()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        print("applicationDidEnterBackground")
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        saveCache()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        print("applicationWillEnterForeground")
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        attemptClearCache()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        saveCache()
    }

    func attemptClearCache() {
        print("attemptClearCache")
        let defaults = UserDefaults.standard
        let appInBackgroundDate = defaults.object(forKey: "appInBackground")
        if appInBackgroundDate != nil {
            print("App has been in background")
            let timeInBackground = Date().timeIntervalSince(appInBackgroundDate as! Date)
            // Time interval is represented by seconds, lets compare it to 10 minutes (600 seconds)
            print("Time in background \(timeInBackground)")
            if (timeInBackground > 600) {
                print("Clearing the bill cache")
                defaults.removeObject(forKey: "billAmount")
                defaults.synchronize()
            }
        }
    }
    
    func saveCache() {
        // Save the input
        let defaults = UserDefaults.standard
        let currentDate = Date()
        defaults.set(currentDate, forKey: "appInBackground")
        defaults.synchronize()
    }
}

