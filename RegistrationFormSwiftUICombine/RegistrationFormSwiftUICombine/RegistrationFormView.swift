//
//  ContentView.swift
//  RegistrationFormSwiftUICombine
//
//  Created by Vlad on 11.06.2020.
//  Copyright © 2020 Vlad. All rights reserved.
//

import SwiftUI
import Combine

struct RegistrationFormView: View {

    @ObservedObject var settings = Settings()
    
    private var heightTextFiled:CGFloat = 30
    private var errorPadding:CGFloat = 1.3
    private var buttonHeight:CGFloat = 13
    private var buttonWidth:CGFloat = 29
    private var paddingButton:CGFloat = 30
    
    @State private var keyboardHeight: CGFloat = 0
    
    var body: some View {
        GeometryReader{geometry in
            NavigationView{
                ScrollView{
                VStack{
                    VStack(alignment:.leading){
                        Text("Organisation name").font(.callout).foregroundColor(Color.gray).padding(.leading)
                        Divider().hidden()
                    }
                    
                    VStack(alignment:.leading){
                        Text("User name")
                            .font(.subheadline)
                            .foregroundColor(Color.green)
                        TextField("Enter your user name", text: self.$settings.userName).frame(height:self.heightTextFiled)
                        Divider()
                        Text("\(self.settings.errorUserName)").font(.footnote).foregroundColor(Color.red).padding(.leading,geometry.size.width/1.3)
                    }.padding([.leading,.trailing,.top])
                    
                    VStack(alignment:.leading){
                        Text("Email")
                            .font(.subheadline)
                            .foregroundColor(Color.green)
                        TextField("Enter your email", text: self.$settings.email).frame(height:self.heightTextFiled)
                        Divider()
                        Text("\(self.settings.errorEmail)").font(.footnote).foregroundColor(Color.red).padding(.leading,geometry.size.width/self.errorPadding)
                    }.padding([.leading,.trailing])
                    
                    VStack(alignment:.leading){
                        Text("Password")
                            .font(.subheadline)
                            .foregroundColor(Color.green)
                        SecureField("Enter your password", text: self.$settings.password).frame(height:self.heightTextFiled)
                        Divider()
                        Text("\(self.settings.errorPassword)").font(.footnote).foregroundColor(Color.red).padding(.leading,geometry.size.width/self.errorPadding)
                    }.padding([.leading,.trailing])
                    
                    VStack(alignment:.leading){
                        Text("Confirm password")
                            .font(.subheadline)
                            .foregroundColor(Color.green)
                        SecureField("Confirm your password", text: self.$settings.confirmPassword).frame(height:self.heightTextFiled)
                        Divider()
                        Text("\(self.settings.errorConfirmPassword)").font(.footnote).foregroundColor(Color.red).padding(.leading,geometry.size.width/self.errorPadding)
                    }.padding([.leading,.trailing])
                    
                    Button(action: {
                        print("sign up")
                    }, label: {Text("Sign up").fontWeight(.bold).foregroundColor(.white).frame(width:geometry.size.width/self.errorPadding, height:geometry.size.height/self.buttonHeight)}).background(self.settings.enableButton ?Color(.green):Color(.gray)).cornerRadius(geometry.size.width/self.buttonWidth).padding(.top,self.paddingButton).disabled(!self.settings.enableButton)
                    Spacer()
                }.navigationBarTitle("Registration")
                 
            }
        }   .padding(.bottom, self.keyboardHeight)
                     // 3.
                     .onReceive(Publishers.keyboardHeight) { self.keyboardHeight = $0 }
    }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationFormView()
    }
}
