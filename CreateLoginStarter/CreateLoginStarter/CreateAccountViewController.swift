//
//  CreateAccountViewController.swift
//  CreateLoginStarter
//
//  Created by Roux-Dufault, Danny on 2017-04-13.
//  Copyright © 2017 Chris. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var verifyPasswordField: UITextField!
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
    
    @IBAction func AccountSubmit(_ sender: UIButton)
    {
        /*let alertController = UIAlertController(title: "Error", message: "aaaaaa", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)*/
        if validateFields()
        {
            addAccount()
        }
    }
}



//methods
extension CreateAccountViewController
{
    
    func validateFields() -> Bool
    {
        let username = self.usernameField.text
        let email = self.emailField.text
        let password = self.passwordField.text
        let verifyPassword = self.verifyPasswordField.text
        
        var missingFields = [String]()
        if username == ""
        {
            missingFields.append("Username")
        }
        
        if email == ""
        {
            missingFields.append("Email")
        }
        
        if password == ""
        {
            missingFields.append("Password")
        }
        
        if verifyPassword == ""
        {
            missingFields.append("Verify Password")
        }
        
        if missingFields.count > 0
        {
            let alertValue = "Do not leave the following field(s) blank: \(missingFields.joined(separator: ", "))"
            //do an alert
            UIAlertController.showErrorAlert(message: alertValue, sender: self)
            return false
        }
        
        if password != verifyPassword
        {
            let alertValue = "Passwords do not match"
            //do an alert
            UIAlertController.showErrorAlert(message: alertValue, sender: self)
            return false
        }
        
        
        
        var invalidFields = [String]()
        
        if !String.usernameValid(username: username!)
        {
            invalidFields.append("Username")
        }
        
        if !String.emailValid(email: email!)
        {
            invalidFields.append("Email")
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
    
    func addAccount()
    {
        let usernameValue = self.usernameField.text
        let emailValue = self.emailField.text
        let passwordValue = self.passwordField.text
        
        var data = [String:String]()
        data["username"] = usernameValue
        data["password"] = passwordValue
        data["email"] = emailValue
        
        URLRequest.getRequestResult(url: APIDetails.buildUrl(callType: .addUser, params: []), requestMethod: "POST", dataToSend: data)
        {
            (success, message, result) in
            
            //join back the main thread
            DispatchQueue.main.async(execute: {
                () -> Void in
                if success
                {
                    _ = self.navigationController?.popViewController(animated: true)
                    UIAlertController.showAlert( message: "Account Created", title: "Success", sender: self)
                }else
                {
                    UIAlertController.showErrorAlert(message: message, sender: self)
                }
            })
            
            
        }
    }
}



















