//
//  Settings.swift
//  RegistrationFormSwiftUICombine
//
//  Created by Vlad on 11.06.2020.
//  Copyright © 2020 Vlad. All rights reserved.
//

import Foundation
import Combine

class SettingsRegistration:ObservableObject{
    
    
    var userDefaults = UserDefaults.standard
    
    @Published var userName:String = ""
    var errorUserName:String = ""
    @Published var email:String = ""
    var errorEmail:String = ""
    @Published var password:String = ""
    var errorPassword:String = ""
    @Published var confirmPassword:String = ""
    var errorConfirmPassword:String = ""
    @Published var enableButton = false
    
    var anyCancellable = Set<AnyCancellable>()
    
    init(){
        ErrorUserName.receive(on: RunLoop.main)
            .map{valid in
                valid ? "Incorect user name" : ""
        }
        .assign(to: \.errorUserName, on: self)
        .store(in: &anyCancellable)
        
        ErrorEmail.receive(on: RunLoop.main)
            .map{valid in
                valid ? "Error incorect email":""
        }
        .assign(to: \.errorEmail, on: self)
        .store(in: &anyCancellable)
        
        ErrorPassword.receive(on: RunLoop.main)
            .map{ valid in
                valid ? "Count password is more than 6": ""
        }
        .assign(to: \.errorPassword, on: self)
        .store(in: &anyCancellable)
        
        ErrorConfirmPassword.receive(on: RunLoop.main)
            .map{valid in
                valid ? "Confirm password doesn't equal password": ""
        }
        .assign(to: \.errorConfirmPassword, on: self)
        .store(in: &anyCancellable)
        
        EnableButton.receive(on: RunLoop.main)
            .assign(to: \.enableButton, on: self)
            .store(in: &anyCancellable)
        
    }
    
    private var ErrorUserName:AnyPublisher<Bool,Never>{
        $userName.debounce(for: 0.3, scheduler: RunLoop.main)
            .removeDuplicates()
            .map{item in
                item.count <= 3 && item.count > 0
        }
        .eraseToAnyPublisher()
    }
    
    private var ErrorEmail:AnyPublisher<Bool,Never>{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return $email.debounce(for: 0.2, scheduler: RunLoop.main)
            .map{item in
                !emailPred.evaluate(with: self.email) && item.count > 0
        }
        .eraseToAnyPublisher()
    }
    
    private var ErrorPassword:AnyPublisher<Bool,Never>{
        $password.debounce(for: 0.3, scheduler: RunLoop.main)
            .map{item in
                item.count < 6 && item.count > 0
        }
        .eraseToAnyPublisher()
    }
    
    private var ErrorConfirmPassword:AnyPublisher<Bool,Never>{
        Publishers.CombineLatest($password, $confirmPassword)
            .map{password,confirmPassword in
                confirmPassword != password
        }
        .eraseToAnyPublisher()
    }
    
    private var EnableButton:AnyPublisher<Bool,Never>{
        Publishers.CombineLatest4(ErrorUserName, ErrorEmail, ErrorPassword, ErrorConfirmPassword)
            .map{errorName, errorMail, errorPass, errorConfirmPass in
                errorName||errorMail||errorPass||errorConfirmPass == true || self.userName == "" || self.email == "" || self.password == "" || self.confirmPassword == ""
        }
        .eraseToAnyPublisher()
    }
    
    
}
