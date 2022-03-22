//
//  AppDelegate.swift
//  Lava Jato
//
//  Created by Olimpio Junior on 04/02/22.
//

import GooglePlaces
import GoogleMaps
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UITabBar.appearance().tintColor = UIColor.ColorDefault
        UINavigationBar.appearance().barTintColor = UIColor.ColorDefault
        GMSServices.provideAPIKey("AIzaSyBkMktW0sYUqwpDXhyXFfoPRLFYh5JeFlk")
        GMSPlacesClient.provideAPIKey("AIzaSyBkMktW0sYUqwpDXhyXFfoPRLFYh5JeFlk")
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

