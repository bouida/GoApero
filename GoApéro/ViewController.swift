//
//  ViewController.swift
//  GoApéro
//
//  Created by Mehdy Bouida on 27/12/2016.
//  Copyright © 2016 Mehdy Bouida. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FBSDKLoginKit
import TwitterKit

class ViewController: UIViewController {

    //Ligne ajouté
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    var menuShowing = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuView.layer.shadowOpacity=1
        menuView.layer.shadowRadius=6
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

    @IBAction func openMenu(_ sender: Any) {
        if(menuShowing){
            leadingConstraint.constant = -140
            UIView.animate(withDuration: 0.3 , animations: {
                self.view.layoutIfNeeded()
            })
        }else{
            leadingConstraint.constant = 0
            UIView.animate(withDuration: 0.3 , animations: {
                self.view.layoutIfNeeded()
            })
        }
        menuShowing = !menuShowing
    }
     //Ligne ajouté
    @IBAction func createAccountAction(_ sender: Any) {
        
        if emailTextField.text == "" || self.passwordTextField.text == ""   {
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                
                if error == nil {
                    print("You have successfully signed up")
                    //Goes to the Setup page which lets the user take a photo for their profile picture and also chose a username
                    
                    /*let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                    self.present(vc!, animated: true, completion: nil)*/
                    
                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        
        
            }
    
    @IBAction func facebookLogin(_ sender: UIButton) { let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            
            guard let accessToken = FBSDKAccessToken.current() else {
                print("Failed to get access token")
                return
            }
            
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            
            // Perform login by calling Firebase APIs
            FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                    return
                }
                
                // Present the main view
                if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView") {
                    UIApplication.shared.keyWindow?.rootViewController = viewController
                    self.dismiss(animated: true, completion: nil)
                }
                
            })
            
        }
        
        let logInButton = TWTRLogInButton(logInCompletion: { session, error in
            if (session != nil) {
                let authToken = session?.authToken
                let authTokenSecret = session?.authTokenSecret
                let credential = FIRTwitterAuthProvider.credential(withToken: (session?.authToken)!, secret: (session?.authTokenSecret)!)
            } else {
                // ...
            }
        })
    logInButton.center=self.view.center
    self.view.addSubview(logInButton)
    }
    
    
}
        

    
    
    // A modifier 
/*@IBAction func loginAction(_ sender: AnyObject) {
 
 if self.emailTextField.text == "" || self.passwordTextField.text == "" {
 
 //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
 
 let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
 
 let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
 alertController.addAction(defaultAction)
 
 self.present(alertController, animated: true, completion: nil)
 
 } else {
 
 FIRAuth.auth()?.signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
 
 if error == nil {
 
 //Print into the console if successfully logged in
 print("You have successfully logged in")
 
 //Go to the HomeViewController if the login is sucessful
 let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
 self.present(vc!, animated: true, completion: nil)
 
 } else {
 
 //Tells the user that there is an error and then gets firebase to tell them the error
 let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
 
 let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
 alertController.addAction(defaultAction)
 
 self.present(alertController, animated: true, completion: nil)
 }
 }
 }
 }*/



