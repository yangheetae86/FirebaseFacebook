//open podfile
//pod 'FBSDKLoginKit'
//pod 'Firebase/Auth'

//  ContentView.swift
//  FirebaseFacebook
//
//  Created by JU HAN LEE on 2020/05/07.
//  Copyright © 2020 yht. All rights reserved.
//

import SwiftUI
import FBSDKLoginKit
import Firebase

struct ContentView: View {
    var body: some View {
        login()
        .frame(width: 100, height: 50)
    }
}

struct login: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        
        return Coordinator()
        
    }
    
    
    func makeUIView(context: Context) -> FBLoginButton {
        
        let button = FBLoginButton()
        button.permissions = ["email"]
        button.delegate = context.coordinator
        
        return button
    }
    
    func updateUIView(_ uiView: FBLoginButton, context: Context) {
        
    }
    
    class Coordinator: NSObject, LoginButtonDelegate {
        func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
            
            if error != nil {
                print((error?.localizedDescription))
                return
            }
            
            if AccessToken.current != nil {
                
                let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
                
                Auth.auth().signIn(with: credential) { (res, er) in
                    
                    if er != nil {
                        
                        print((er?.localizedDescription))
                        return
                    }
                    
                    print("sucessss")
                }
                
            }
            
        }
        
        func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
            
            try! Auth.auth().signOut()
            
        }
        
        
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
