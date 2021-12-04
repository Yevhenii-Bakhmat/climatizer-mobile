//
//  ContentView.swift
//  climatizer-mobile
//
//  Created by Евгений Бахмат on 04.12.2021.
//

import SwiftUI

let storedUsername = "johnbakhmat"
let storedPassword = "123456"



let lightGreyColor = Color(red: 239/255, green: 243.0/255, blue: 244.0/255.0, opacity: 1.0)

struct ContentView: View {
    
    @State var username: String = ""
    @State var password: String = ""
    
    @State var authenticationDidFail: Bool = false
    @State var authenticationDidSucceed: Bool = false
    
    @ObservedObject var keyboardResponder = KeyboardResponder()
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack {
                    WelcomeText()
                    UserImage()
                    UsernameTextField(username: $username)
                    PasswordSecureField(password: $password)
                    
                    if(authenticationDidFail){
                        Text("Information not correct. Try again!")
                            .offset(y:-10)
                            .foregroundColor(.red)
                    }
                    
                    Button(action: {
                        print("Button Tapped")
                        if(self.username == storedUsername && self.password == storedPassword){
                            self.authenticationDidSucceed = true
                            self.authenticationDidFail = false
                        }else{
                            self.authenticationDidFail = true
                        }
                    }){
                        LoginButtonContent()
                    }
                }.padding()
                
                if(authenticationDidSucceed){
                    Text("Login succeeded!")
                        .font(.headline)
                        .frame(width: 250, height: 80)
                        .background(Color.green)
                        .cornerRadius(20.0)
                        .foregroundColor(.white)
                        .animation(.default)
                }
            }
            
        }.offset(y: -keyboardResponder.currentHeight*0.9)
    }
}
#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

struct WelcomeText: View {
    var body: some View {
        Text("Welcome!").font(.largeTitle).fontWeight(.semibold).padding(.bottom,20)
    }
}

struct UserImage: View {
    var body: some View {
        Image("userImage").resizable().aspectRatio(contentMode: .fill).frame(width: 150, height: 150).clipped().cornerRadius(150).padding(.bottom,75)
    }
}

struct LoginButtonContent: View {
    var body: some View {
        Text("LOGIN").font(.headline).foregroundColor(.white).padding().frame(width: 220, height: 60).background(Color.green).cornerRadius(15.0)
    }
}

struct UsernameTextField: View {
    @Binding var username: String
    var body: some View {
        TextField("Username", text: $username)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom,20)
    }
}

struct PasswordSecureField: View {
    
    @Binding var password: String
    
    var body: some View {
        SecureField("Password",text: $password)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom,20)
    }
}
