//
//  SignIn.swift
//  Agence
//
//  Created by Kevin Amador Rios on 9/1/22.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import Firebase

struct SignIn: View {
    
    @StateObject var signInModel: SignInModelView = .init()
    
    var body: some View {
        //Add scrollview
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 15) {
                Image(systemName: "swift")
                    .font(.system(size: 100))
                    .foregroundColor(.orange)
                    (Text("Welcome,")
                        .foregroundColor(.black)
                        .font(.system(size: 40)) +
                     Text("\n Sign In to continue")
                        .font(.system(size: 30))
                        .foregroundColor(.gray)
                    )
                    .font(.title)
                    .fontWeight(.semibold)
                    .lineSpacing(10)
                    .padding(.top, 20)
                    .padding(.trailing, 15)
                
                //MARK: Form will be created here.
                EmailField(title: "Email", text: $signInModel.emailUser)
                PasswordField(title: "Password", text: $signInModel.passwordUser)
                
                //MARK: Sign In button
                HStack {
                    Button (action: signInModel.signInFireBase) {
                        HStack(spacing: 15) {
                            Text("Sign In")
                                .fontWeight(.semibold)
                                .transition(.identity)
                            Image(systemName: "lock.fill")
                                .font(.title3)
                        }
                    }
                    .foregroundColor(.black)
                    
                    //MARK: Add spacer
                    Spacer()
                    
                    //MARK: Forgot password
                    Button {
                        print("SS")
                    } label: {
                        HStack(spacing: 15) {
                            Text("Olvidé mi contraseña")
                                .fontWeight(.semibold)
                                .transition(.identity)
                            Image(systemName: "line.diagonal.arrow")
                                .font(.title3)
                                .rotationEffect(.init(degrees: 5))
                        }
                    }
                }
                .frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width - 50, alignment: .center)
                
                //Set social buttons
                HStack(spacing: 8) {
                    CustomButton(isGoogle: false)
                        .overlay {
                            
                        }
                    .clipped()
                    
                    CustomButton(isGoogle: true)
                        .overlay {
                            if let clinetId = FirebaseApp.app()?.options.clientID {
                                GoogleSignInButton {
                                    GIDSignIn.sharedInstance.signIn(with: .init(clientID: clinetId), presenting: UIApplication.shared.rootController()){ user, error in
                                        if let error = error {
                                            print(error.localizedDescription)
                                            return
                                        }
                                        
                                        //Call login function
                                        signInModel.SignIn(user: user!)
                                    }
                                }
                            }
                        }
                    .clipped()
                }
                //settings
                .frame(maxWidth: .infinity)
            }
        }
        .alert(signInModel.errorMessage, isPresented: $signInModel.showError){}
    }
}

@ViewBuilder
func CustomButton(isGoogle: Bool = false) -> some View {
    HStack {
        
        Group {
            if isGoogle {
                Image("google")
                    .resizable()
            } else {
                Image("facebook")
                    .resizable()
            }
        }
        .aspectRatio(contentMode: .fit)
        .frame(width: 25, height: 25)
        .frame(height: 45)
        Text("\(isGoogle ? "Google":"Facebook") Sign In")
            .font(.callout)
            .lineLimit(1)
    }
    .foregroundColor(.black)
    .padding(.horizontal, 15)
    .background {
        RoundedRectangle(cornerRadius: 16, style: .continuous)
            .fill(.white)
    }
    
}

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn().preferredColorScheme(.light)
    }
}
