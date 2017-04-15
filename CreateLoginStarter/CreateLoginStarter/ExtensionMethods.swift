//
//  ExtensionMethods.swift
//  CreateLoginStarter
//
//  Created by danny on 2017-04-13.
//  Copyright © 2017 Chris. All rights reserved.
//

import UIKit


extension UIAlertController
{
    static func showErrorAlert(message:String, sender:UIViewController)
    {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        sender.present(alertController, animated: true, completion: nil)
    }
    
    static func showAlert(message:String, title:String, sender:UIViewController)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        sender.present(alertController, animated: true, completion: nil)
    }
}


extension URLRequest
{
    static func getRequestResult(url:URL, requestMethod:String, dataToSend:[String:String], onCompletion: @escaping (Bool, String, AnyObject?)->Void)
    {
        var request = URLRequest(url: url)
        request.httpMethod = requestMethod
        
        if requestMethod != "GET"
        {
            request.httpBody = buildAddPostDataString(data: dataToSend).data(using: .utf8)
        }
        
        let task = URLSession.shared.dataTask(with: request)
        {
            (data, response, error) in
            if error != nil
            {
                onCompletion(false, error as! String, nil)
                return
            }
            
            do
            {
                let result = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
                
                let success = result?["success"]! as! String == "true" ? true : false
                let message = result?["message"]! as! String
                
                if success
                {
                    onCompletion(true, message, result?["result"]!)
                }else
                {
                    onCompletion(false, message, nil)
                }
                
            } catch {
                onCompletion(false, error as! String, nil)
                return
            }
        }
        task.resume()
        
        
    }
    
    static func buildAddPostDataString(data:[String:String]) -> String {
        var pairs = [String]()
        for (key, value) in data {
            pairs.append("\(key)=\(value)")
        }
        return pairs.joined(separator: "&")
    }
}

extension String
{
    static func usernameValid(username:String) -> Bool
    {
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z0-9!@#$%^&*'\"?]{5,}$")
            return regex.firstMatch(in: username, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, username.characters.count)) != nil
        } catch {
            return false
        }
    }
    
    static func emailValid(email:String) -> Bool
    {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
            return regex.firstMatch(in: email, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, email.characters.count)) != nil
        } catch {
            return false
        }
    }
    
    static func passwordValid(password:String) -> Bool
    {
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z0-9!@#$%^&*'\"?]{5,}$")
            return regex.firstMatch(in: password, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, password.characters.count)) != nil
        } catch {
            return false
        }
    }
}





































