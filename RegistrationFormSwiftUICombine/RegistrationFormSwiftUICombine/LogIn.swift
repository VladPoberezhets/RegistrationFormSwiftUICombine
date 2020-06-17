//
//  LogIn.swift
//  RegistrationFormSwiftUICombine
//
//  Created by Vlad on 13.06.2020.
//  Copyright © 2020 Vlad. All rights reserved.
//

import SwiftUI

struct LogIn: View {
    @State private var email:String = ""
    @State private var password:String = ""
    private var error:String = "This email or password is incorect"
    @State private var showError = false
    
    private var heightTextFiled:CGFloat = 30
    private var errorPadding:CGFloat = 1.3
    private var buttonHeight:CGFloat = 13
    private var buttonWidth:CGFloat = 29
    
    @State private var showRegistration = false
    @State private var showLoadingView = false
    
    var body: some View {
        GeometryReader{geometry in
            NavigationView{
                VStack{
                    VStack(alignment:.leading){
                        Text("Corporation name").padding(.leading).font(.callout).foregroundColor(Color.gray)
                        Divider().hidden()
                    }
                    VStack(alignment:.leading){
                        Text("User name or email").font(.subheadline)
                            .foregroundColor(Color.green)
                        TextField("Enter user name or email", text: self.$email).frame(height:self.heightTextFiled)
                        Divider()
                    }.padding([.leading, .trailing, .bottom]).padding(.top,100)
                    
                    VStack(alignment:.leading){
                        Text("Password").font(.subheadline)
                            .foregroundColor(Color.green)
                        SecureField("Enter password", text: self.$password).frame(height:self.heightTextFiled)
                        Divider()
                    }.padding([.leading, .trailing,])
                    
                    Text("\(self.showError ?self.error:"")").font(.footnote).foregroundColor(Color.red).padding([.bottom])
                    
                    Button(action: {
                        if self.email != (UserDefaults.standard.object(forKey: "Email")) as! String && self.password as AnyObject !== (UserDefaults.standard.object(forKey: "Password")) as AnyObject{
                            self.showError = true
                        }else{
                            self.showLoadingView = true
                        }
                        print("sign in")
                    }, label: {Text("Log in").fontWeight(.bold).foregroundColor(.white).frame(width:geometry.size.width/self.errorPadding, height:geometry.size.height/self.buttonHeight)}).background(Color(.green)).cornerRadius(geometry.size.width/self.buttonWidth)
                    
                    NavigationLink(destination: LoadingView(), isActive: self.$showLoadingView, label: {Text("")})
                    
                    Button(action: {
                        self.showRegistration = true
                        
                    }, label: {Text("Don't have account?")
                        .font(.subheadline)}).padding(.top).sheet(isPresented: self.$showRegistration) {
                            RegistrationFormView()
                    }
                    
                    Spacer()
                        .navigationBarTitle("Log in")
                }
            }
        }
    }
}

struct LogIn_Previews: PreviewProvider {
    static var previews: some View {
        LogIn()
    }
}
