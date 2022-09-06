//
//  LoginViewModel.swift
//  Agence
//
//  Created by Kevin Amador Rios on 9/1/22.
//

import SwiftUI
import Firebase
import GoogleSignIn

class SignInModelView: ObservableObject {
    @Published var emailUser: String = ""
    @Published var passwordUser: String = ""
    @Published var showError: Bool = false
    @Published var errorMessage:String = ""
    @AppStorage("log_status") var logStatus: Bool = false
    
    //MARK: Use Google Account
    func SignIn(user: GIDGoogleUser) {
        UIApplication.shared.closeKeyboard()
        Task {
            do {
                guard let idToken = user.authentication.idToken else { return }
                let accessToken = user.authentication.accessToken
                
                let credebntial = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
                try await Auth.auth().signIn(with: credebntial)
                print("success google")
                await MainActor.run(body: {
                    withAnimation(.easeInOut) {
                        logStatus = true
                    }
                })
            } catch let error {
                await handleError(error: error)
            }
        }
    }
    
    //MARK: Use Firebase Auth
    func signInFireBase() {
        Task {
            do {
                //access to response
                let userSignIn = try await Firebase.Auth.auth().signIn(withEmail: emailUser, password: passwordUser)
                if ((userSignIn.user.email?.isEmpty) != nil) {
                    await MainActor.run(body: {
                        withAnimation(.easeInOut) {
                            logStatus = true
                        }
                    })
                }
                
            } catch let error {
                await handleError(error: error)
            }
        }
    }
    
    //MARK: Use Facebook Authentication SDK Fails
    
    //MARK: Manage Error
    func handleError(error: Error) async {
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
        })
    }
}

//MARK: Complement 
extension UIApplication {
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    //root controller
    func rootController() -> UIViewController {
        guard let window = connectedScenes.first as? UIWindowScene else { return .init()}
        guard let viewController = window.windows.last?.rootViewController else {return .init()}
        return viewController
    }
}
