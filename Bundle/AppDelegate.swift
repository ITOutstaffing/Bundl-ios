import UIKit
import Firebase
import FBSDKCoreKit
import AWSUserPoolsSignIn


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

