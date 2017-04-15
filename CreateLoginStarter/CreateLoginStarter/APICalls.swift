import Foundation

enum APICalls: Int {
    case addUser = 0
    case login = 1
    
    var theIndex:Int {
        get {
            return self.rawValue
        }
    }
}
