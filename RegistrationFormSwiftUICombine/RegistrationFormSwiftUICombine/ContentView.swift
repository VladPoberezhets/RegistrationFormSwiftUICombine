//
//  ContentView.swift
//  RegistrationFormSwiftUICombine
//
//  Created by Vlad on 11.06.2020.
//  Copyright © 2020 Vlad. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var userName:String = ""
    @State var email:String = ""
    @State var password:String = ""
    @State var confirmPassword:String = ""
    private var heightTextFiled:CGFloat = 30
    private var errorPadding:CGFloat = 1.3
    private var buttonHeight:CGFloat = 13
    private var buttonWidth:CGFloat = 29
    private var paddingButton:CGFloat = 30
    var body: some View {
        GeometryReader{geometry in
            NavigationView{
                VStack{
                    VStack(alignment:.leading){
                        Text("Organisation name").font(.callout).foregroundColor(Color.gray).padding(.leading)
                        Divider().hidden()
                    }
                    VStack(alignment:.leading){
                        Text("User name")
                            .font(.subheadline)
                            .foregroundColor(Color.green)
                        TextField("Enter your user name", text: self.$userName).frame(height:self.heightTextFiled)
                        Divider()
                        Text("Error").font(.footnote).foregroundColor(Color.red).padding(.leading,geometry.size.width/1.3)
                    }.padding([.leading,.trailing,.top])
                    
                    VStack(alignment:.leading){
                        Text("Email")
                            .font(.subheadline)
                            .foregroundColor(Color.green)
                        TextField("Enter your email", text: self.$email).frame(height:self.heightTextFiled)
                        Divider()
                        Text("Error").font(.footnote).foregroundColor(Color.red).padding(.leading,geometry.size.width/self.errorPadding)
                    }.padding([.leading,.trailing])
                    
                    VStack(alignment:.leading){
                        Text("Password")
                            .font(.subheadline)
                            .foregroundColor(Color.green)
                        SecureField("Enter your password", text: self.$password).frame(height:self.heightTextFiled)
                        Divider()
                        Text("Error").font(.footnote).foregroundColor(Color.red).padding(.leading,geometry.size.width/self.errorPadding)
                    }.padding([.leading,.trailing])
                    
                    VStack(alignment:.leading){
                        Text("Confirm password")
                            .font(.subheadline)
                            .foregroundColor(Color.green)
                        SecureField("Confirm your password", text: self.$confirmPassword).frame(height:self.heightTextFiled)
                        Divider()
                        Text("Error").font(.footnote).foregroundColor(Color.red).padding(.leading,geometry.size.width/self.errorPadding)
                    }.padding([.leading,.trailing])
                    
                    Button(action: {
                        print("sign up")
                    }, label: {Text("Sign up").fontWeight(.bold).foregroundColor(.white).frame(width:geometry.size.width/self.errorPadding, height:geometry.size.height/self.buttonHeight)}).background(Color(.green)).cornerRadius(geometry.size.width/self.buttonWidth).padding(.top,self.paddingButton)
                    Spacer()
                }.navigationBarTitle("Registration")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
