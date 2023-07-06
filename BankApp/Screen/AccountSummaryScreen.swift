import SwiftUI

struct AccountSummaryScreen: View {
    
    @ObservedObject private var accountSummaryVM = AccountSummaryViewModel()
    
    var body: some View {
        VStack {
            GeometryReader { g in
                VStack {
                    AccountListView(accounts: self.accountSummaryVM.accounts)
                        .frame(height: g.size.height/2)
                    Text("\(self.accountSummaryVM.total.formatAsCurrency())")
                    Spacer()
                }
            }
        }
        .onAppear {
            self.accountSummaryVM.getAllAccounts()
        }
        .navigationBarTitle("Account Summary")
        .embedInNavigationView()
    }
}

struct AccountSummaryScreen_Previews: PreviewProvider {
    static var previews: some View {
        AccountSummaryScreen()
    }
}
