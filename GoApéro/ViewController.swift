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
 
}

