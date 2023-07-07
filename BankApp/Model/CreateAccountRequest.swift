import Foundation

struct CreateAccountRequest: Codable {
    
    let name: String
    let accountType: String
    let balance: Double
}
