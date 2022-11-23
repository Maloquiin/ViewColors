//
//  ContentView.swift
//  ViewColors
//
//  Created by Peri on 22.11.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var sliderValueRed = Double.random(in: 0...255)
    @State private var sliderValueBlue = Double.random(in: 0...255)
    @State private var sliderValueGreen = Double.random(in: 0...255)
    
    var body: some View {
        ZStack {
            Color(.gray)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                ColorView(red: sliderValueRed, green: sliderValueGreen, blue: sliderValueBlue)
                ColorSlider(value: $sliderValueRed, sliderColor: .red)
                ColorSlider(value: $sliderValueBlue, sliderColor: .blue)
                ColorSlider(value: $sliderValueGreen, sliderColor: .green)
                Spacer()
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ColorSlider: View{
    @State private var showAlert = false
    @State private var newValue = 0.044
    @Binding var value: Double
    var sliderColor: Color
    
    var body: some View{
        HStack{
            Text("\(lround(value))")
                .frame(width: 40, alignment: .leading)
                .foregroundColor(.white)
            Slider(value: $value, in: 0...255, step: 1)
                .accentColor(sliderColor)
            TextField("", text: textValue, onCommit: {
                value = newValue
            })
                .frame(width: 32, height: 15)
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                .background(.white)
                .cornerRadius(8)
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Wrong Format"),
                        message: Text("Please enter value from 0 to 255")
                    )
                }
        }
    }
}

extension ColorSlider {
    var textValue: Binding<String> {
        Binding<String>(
            get: {
                "\(lround(value))"
            },
            set: {
                if let number = NumberFormatter().number(from: $0) {
                    let doubleValue = number.doubleValue
                    if !(0...255).contains(doubleValue) {
                        newValue = 0
                        showAlert.toggle()
                        return
                    }
                    newValue = doubleValue
                    
                } else {
                    newValue = 0
                    showAlert.toggle()
                }
            }
        )
    }
}

