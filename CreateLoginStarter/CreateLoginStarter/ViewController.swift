//
//  ViewController.swift
//  CreateLoginStarter
//
//  Created by Chris on 2017-03-29.
//  Copyright © 2017 Chris. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    var validInfo = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    
    @IBAction func LoginButton(_ sender: UIButton)
    {
        //check on the server if the username and password matches
        if validateFields()
        {
            validateInformation()
        }
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier:String, sender: Any?) -> Bool
    {
        
        if self.validInfo
        {
            self.validInfo = false
            return true
        }
        
        if identifier == "CreateAccountSegue"
        {
            return true
        }
        
        return false
    }
    
    override func performSegue(withIdentifier identifier: String, sender: Any?)
    {
        if identifier == "MainScreenSegue"
        {
            var nextScreen = self.storyboard?.instantiateViewController(withIdentifier: "MainScreenViewController") as! MainScreenViewController
            self.navigationController?.pushViewController(nextScreen, animated: true)
        }
        
    }
    
    
    
    func validateFields() -> Bool
    {
        let username = self.usernameField.text
        let password = self.passwordField.text
        
        var missingFields = [String]()
        if username == ""
        {
            missingFields.append("Username")
        }
        
        if password == ""
        {
            missingFields.append("Password")
        }
        
        if missingFields.count > 0
        {
            let alertValue = "Do not leave the following field(s) blank: \(missingFields.joined(separator: ", "))"
            //do an alert
            UIAlertController.showErrorAlert(message: alertValue, sender: self)
            return false
        }
        
        
        
        
        var invalidFields = [String]()
        
        if !String.usernameValid(username: username!)
        {
            invalidFields.append("Username")
        }
        
        if !String.passwordValid(password: password!)
        {
            invalidFields.append("Password")
        }
        
        if invalidFields.count > 0
        {
            let alertValue = "The following field(s) are not in the correct format: \(invalidFields.joined(separator: ", "))"
            UIAlertController.showErrorAlert(message: alertValue, sender: self)
            //do the alert
            return false
        }
        
        return true
        
    }
    
    func validateInformation ()
    {
        let username = self.usernameField.text
        let password = self.passwordField.text
        
        var data = [String:String]()
        data["username"] = username
        data["password"] = password
        
        URLRequest.getRequestResult(url: APIDetails.buildUrl(callType: .login, params: []), requestMethod: "POST", dataToSend: data)
        {
            (success, message, result) in
            
            //join back the main thread
            DispatchQueue.main.async(execute: {
                () -> Void in
                if success
                {
                    self.validInfo = true
                    if self.shouldPerformSegue(withIdentifier: "MainScreenSegue", sender: nil)
                    {
                        self.performSegue(withIdentifier: "MainScreenSegue", sender: nil)
                    }
                }else
                {
                    UIAlertController.showErrorAlert(message: message, sender: self)
                }
            })
            
            
        }
    }
}


























