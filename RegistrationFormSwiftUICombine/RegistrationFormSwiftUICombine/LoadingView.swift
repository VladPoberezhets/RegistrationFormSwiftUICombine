//
//  LoadingView.swift
//  RegistrationFormSwiftUICombine
//
//  Created by Vlad on 15.06.2020.
//  Copyright © 2020 Vlad. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    //circle rounde
    @State private var progress:CGFloat = 0.7
    // starting or pause animating
    @State private var isAnimating = false
    
    //array color for circle
  private  var arrayColor:[Color] = [.red,.green,.blue]
    //index color is selected
    @State private var colorIndex = 0
    
    // timer for editing color by 1 sec
   private var timer:Timer{
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (_) in
            if self.colorIndex+1 >= self.arrayColor.count{
                self.colorIndex = 0
            }else{
                self.colorIndex += 1
            }
        }
    }
    var body: some View {
        ZStack{
            // background gray
            ZStack{
                Text("")
                
            }.frame(width:UIScreen.main.bounds.width,height:UIScreen.main.bounds.height).background(Color.black).opacity(0.03)
            // sircle animating
            VStack{
                withAnimation(){
                    
                    Circle().trim(from: 0, to: progress).stroke(style: StrokeStyle(lineWidth: 5.0, lineCap: .round, lineJoin: .round)).rotationEffect(Angle(degrees: isAnimating ? 360.0: 0.0)).foregroundColor(arrayColor[colorIndex]) .animation(Animation.linear(duration: 1.0).repeatForever(autoreverses: false))
                    
                }.navigationBarBackButtonHidden(true)
                
            }.frame(width:100, height:100)
            //animating text
            withAnimation(){
                Text("Loading...").foregroundColor(arrayColor[colorIndex]).animation(Animation.linear(duration: 2).repeatForever(autoreverses: false))
            }
            
        }.onAppear() {
            self.isAnimating = true
            _ = self.timer
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
