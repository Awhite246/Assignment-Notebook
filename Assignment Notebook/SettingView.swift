//
//  SettingView.swift
//  Assignment Notebook
//
//  Created by Student on 1/26/22.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.presentationMode) var presentationMode
    let backgroundNumber : Int
    @State private var num = 0
    var body: some View {
        NavigationView {
            Image("background \(num)")
                .resizable()
                .frame(width: 400, height: 800, alignment: .center)
                .overlay(
                    LazyVGrid(columns: Array(repeating: GridItem(.fixed(120), spacing: 0),count: 3), spacing: 19, content: {
                        ForEach(1..<8){ index in
                            Image("background \(index)")
                                .resizable()
                                .frame(width: 100, height: 200, alignment: .center)
                                .onTapGesture {
                                    num = index
                                }
                                .grayscale(num == index ? 0.9 : 0.0)
                                .blur(radius : num == index ? 3.0 : 0.0)
                        }
                    })
                )
                .navigationBarTitle("Change Background", displayMode: .inline)
                .navigationBarItems(
                    leading: Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "x.square")
                            .imageScale(.large)
                    })
        }
        .onAppear(perform: {
            num = backgroundNumber
        })
        .preferredColorScheme(.dark)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(backgroundNumber: 1)
    }
}
