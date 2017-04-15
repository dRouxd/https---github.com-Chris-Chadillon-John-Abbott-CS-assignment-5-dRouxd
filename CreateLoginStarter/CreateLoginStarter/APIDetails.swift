
import Foundation

class APIDetails {
    static let baseURL = "http://localhost:8080/json/"
    
    static let apiCallCompletions:[APICalls:([String])->String] =   [.addUser:{(params) in "add"},
                                                                     .login:{(params) in "login"}
                                                                    ]
    
    class func buildUrl(callType:APICalls, params:[String])->URL {
        return URL(string: baseURL+apiCallCompletions[callType]!(params))!
    }
}
