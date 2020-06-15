//
//  LogIn.swift
//  RegistrationFormSwiftUICombine
//
//  Created by Vlad on 13.06.2020.
//  Copyright © 2020 Vlad. All rights reserved.
//

import SwiftUI

struct LogIn: View {
    @State var name = ""
    
    private var heightTextFiled:CGFloat = 30
    private var errorPadding:CGFloat = 1.3
    private var buttonHeight:CGFloat = 13
    private var buttonWidth:CGFloat = 29
    
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
                    TextField("Enter user name or email", text: self.$name).frame(height:self.heightTextFiled)
                    Divider()
                }.padding([.leading, .trailing, .bottom]).padding(.top,100)
                
                VStack(alignment:.leading){
                    Text("Password").font(.subheadline)
                    .foregroundColor(Color.green)
                    SecureField("Enter password", text: self.$name).frame(height:self.heightTextFiled)
                    Divider()
                }.padding([.leading, .trailing, .bottom])
                
                Button(action: {
                    print("sign in")
                }, label: {Text("Log in").fontWeight(.bold).foregroundColor(.white).frame(width:geometry.size.width/self.errorPadding, height:geometry.size.height/self.buttonHeight)}).background(Color(.green)).cornerRadius(geometry.size.width/self.buttonWidth)
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
