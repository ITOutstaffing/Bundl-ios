import UIKit
import Firebase
import FBSDKLoginKit

class FirstVC: UIViewController, LoginButtonDelegate {

    @IBOutlet weak var facebookButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let faceBookLoginButton = FBLoginButton()
        facebookButton.addSubview(faceBookLoginButton)
        faceBookLoginButton.frame = CGRect(x: 0, y: 0, width: facebookButton.frame.width, height: facebookButton.frame.height)
        faceBookLoginButton.delegate = self
    }
    
    //    protocol facebook button
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if error != nil {
            print(error!)
            return
        }
        let accessToken = AccessToken.current
        guard let accessTokenString = accessToken?.tokenString else {return}
        let credential = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                print("error with auth facebook", error!)
                return
            }
            print("successesfully logged with FB", user!)
        }
        GraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start { (connection, result, err) in
            if err != nil {
                print("problem with graphrequest", err!)
                return
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Log out")
    }
    
}
