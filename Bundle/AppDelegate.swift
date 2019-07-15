//
//  AppDelegate.swift
//  Bundle
//
//  Created by Алексей Ляшенко on 7/9/19.
//  Copyright © 2019 Алексей Ляшенко. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions);
        FirebaseApp.configure()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let handled = ApplicationDelegate.shared.application(app, open: url, sourceApplication: (options [UIApplication.OpenURLOptionsKey.sourceApplication] as! String) , annotation: [UIApplication.OpenURLOptionsKey.annotation])
        return handled
    }
    
}

