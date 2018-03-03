//
//  ViewController.swift
//  Parse_Chat
//
//  Created by Bijesh Subedi on 2/25/18.
//  Copyright © 2018 Bijesh Subedi. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    
    @IBAction func loginPressed(_ sender: Any) {
        loginUser()
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        registerUser()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func registerUser() {
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = usernameLabel.text ?? ""
        newUser.password = passwordLabel.text ?? ""
        
        createAlert(username: newUser.username!, password: newUser.password!)
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User Registered successfully")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                // manually segue to logged in view
            }
        }
    }
    
    func loginUser() {
        
        let username = usernameLabel.text ?? ""
        let password = passwordLabel.text ?? ""
        
        createAlert(username: username, password: password)
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
            } else {
                print("User logged in successfully")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                // display view controller that needs to shown after successful login
            }
        }
    }
    
    func createAlert(username: String, password: String){
        var msg: String
        if (username == "" && password == ""){
            msg = "Email and Password required"
        } else if (username == ""){
            msg = "Username cannot be empty"
        } else if (password == ""){
            msg = "Password cannot be empty"
        } else {
            return
        }
        let alertController = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            // handle cancel response here. Doing nothing will dismiss the view.
        }
        alertController.addAction(cancelAction)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
        }
        alertController.addAction(OKAction)
        present(alertController, animated: true) {
            // optional code for what happens after the alert controller has finished presenting
        }
    }


}

