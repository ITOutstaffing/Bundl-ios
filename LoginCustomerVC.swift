//
//  LoginCustomerVC.swift
//  Bundle
//
//  Created by Алексей Ляшенко on 7/9/19.
//  Copyright © 2019 Алексей Ляшенко. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit

class LoginCustomerVC: UIViewController, LoginButtonDelegate {
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
    
    @IBOutlet weak var registrEmailButtonOutlet: UIButton!
    @IBOutlet weak var emailTextFieldOutlet: UITextField!
    @IBOutlet weak var firstNameTextFieldOutlet: UITextField!
    @IBOutlet weak var lastNameTextFieldOutlet: UITextField!
    @IBOutlet weak var userNameTextFildOutlet: UITextField!
    @IBOutlet weak var passwordTextFieldOutlet: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var faceBookButtonLoginOutlet: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registrEmailButtonOutlet.isEnabled = false
        
        //       keyboard add hide and show
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        self.hideKeyboard()
        
        let faceBookLoginButton = FBLoginButton()
        faceBookButtonLoginOutlet.addSubview(faceBookLoginButton)
        faceBookLoginButton.frame = CGRect(x: 0, y: 0, width: faceBookButtonLoginOutlet.frame.width, height: faceBookButtonLoginOutlet.frame.height)
        faceBookLoginButton.delegate = self
        
    }
    func loginButtonIsActive(){
        let userEmail = emailTextFieldOutlet.text
        let firstName = firstNameTextFieldOutlet.text
        let lastName = lastNameTextFieldOutlet.text
        let username = userNameTextFildOutlet.text
        let password = passwordTextFieldOutlet.text
        if isValidEmail(testStr: userEmail!) && isValidPassw(testStr: password!) && isValidNames(testStr: firstName!) && isValidNames(testStr: lastName!) && isValidNames(testStr: username!) {
            registrEmailButtonOutlet.isEnabled = true
        }else{ }
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func isValidPassw(testStr:String) -> Bool {
        let paaswRegEx = "[A-Z0-9a-z._%+-]{6,64}"
        let passwTest = NSPredicate(format:"SELF MATCHES %@", paaswRegEx)
        return passwTest.evaluate(with: testStr)
    }
    
    func isValidNames(testStr:String) -> Bool {
        let paaswRegEx = "[A-Z0-9a-z._%+-]{3,64}"
        let passwTest = NSPredicate(format:"SELF MATCHES %@", paaswRegEx)
        return passwTest.evaluate(with: testStr)
    }
    
    @IBAction func emailTextFieldDidBegin(_ sender: Any) {
        emailTextFieldOutlet.textColor = UIColor.black
    }
    @IBAction func emailTextFieldDidEnd(_ sender: Any) {
        let userEmail = emailTextFieldOutlet.text
        let emailValid = isValidEmail(testStr: userEmail!)
        if emailValid{
            loginButtonIsActive()
        }else{
            emailTextFieldOutlet.placeholder = "Empty Email"
            emailTextFieldOutlet.textColor = UIColor.red
            registrEmailButtonOutlet.isEnabled = false
            return
        }
    }
    
    @IBAction func firstNameDidBegin(_ sender: Any) {
        firstNameTextFieldOutlet.textColor = UIColor.black
    }
    @IBAction func firstNameDidEnd(_ sender: Any) {
        let name = firstNameTextFieldOutlet.text
        let nameValid = isValidNames(testStr: name!)
        if nameValid{
            loginButtonIsActive()
        }else{
            firstNameTextFieldOutlet.placeholder = "Empty First name"
            firstNameTextFieldOutlet.textColor = UIColor.red
            registrEmailButtonOutlet.isEnabled = false
            return
        }
    }
    @IBAction func lastNameDidBegin(_ sender: Any) {
        lastNameTextFieldOutlet.textColor = UIColor.black
    }
    @IBAction func lastNameDidEnd(_ sender: Any) {
        let name = lastNameTextFieldOutlet.text
        let nameValid = isValidNames(testStr: name!)
        if nameValid{
            loginButtonIsActive()
        }else{
            lastNameTextFieldOutlet.placeholder = "Empty Last name"
            lastNameTextFieldOutlet.textColor = UIColor.red
            registrEmailButtonOutlet.isEnabled = false
            return
        }
    }
    @IBAction func userNameDidBegin(_ sender: Any) {
        userNameTextFildOutlet.textColor = UIColor.black
    }
    @IBAction func userNameDidEnd(_ sender: Any) {
        let name = userNameTextFildOutlet.text
        let nameValid = isValidNames(testStr: name!)
        if nameValid{
            loginButtonIsActive()
        }else{
            userNameTextFildOutlet.placeholder = "Empty Username"
            userNameTextFildOutlet.textColor = UIColor.red
            registrEmailButtonOutlet.isEnabled = false
            return
        }
    }
    @IBAction func passwordDidBegin(_ sender: Any) {
        passwordTextFieldOutlet.textColor = UIColor.black
    }
    @IBAction func passwordDidEnd(_ sender: Any) {
        let password = passwordTextFieldOutlet.text
        let passwValid = isValidPassw(testStr: password!)
        if passwValid{
            loginButtonIsActive()
        }else{
            passwordTextFieldOutlet.placeholder = "Empty Password"
            passwordTextFieldOutlet.textColor = UIColor.red
            registrEmailButtonOutlet.isEnabled = false
            return
        }
    }
    
    @IBAction func registrEmailButtonAction(_ sender: Any) {
        print("123")
    }
    
}
