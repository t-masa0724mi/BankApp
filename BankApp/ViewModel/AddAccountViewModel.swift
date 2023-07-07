import Foundation

class AddAccountViewModel: ObservableObject {
    
    var name: String = ""
    var accountType: AccountType = .checking
    var balance: String = ""
    @Published var errrorMessage: String = ""
}

extension AddAccountViewModel {
    
    private var isNameValid: Bool {
        !name.isEmpty
    }
    
    private var isBalanceValid: Bool {
        guard let userBalance = Double(balance) else {
            return false
        }
        return userBalance <= 0 ? false : true
    }
    
    private func isValid() -> Bool {
        var errors = [String]()
        
        if !isNameValid {
            errors.append("Name is not valid")
        }
        if !isBalanceValid {
            errors.append("Balance is not valid")
        }
        if !errors.isEmpty {
            DispatchQueue.main.async {
                self.errrorMessage = errors.joined(separator: "\n")
            }
            return false
        }
        
        return true
    }
}

extension AddAccountViewModel {
    func createAccout(completion: @escaping (Bool) -> Void) {
        
        if !isValid() { return completion(false) }
        
        let createAccountReq = CreateAccountRequest(name: name, accountType: accountType.rawValue, balance: Double(balance)!)
        
        AccountService.shared.createAccount(createAccountRequest: createAccountReq) { result in
            switch result {
            case .success(let response):
                if response.success {
                    completion(true)
                } else {
                    if let error = response.error {
                        DispatchQueue.main.async {
                            self.errrorMessage = error
                        }
                        completion(false)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
