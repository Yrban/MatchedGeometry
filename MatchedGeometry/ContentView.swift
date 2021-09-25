//
//  ContentView.swift
//  MatchedGeometry
//
//  Created by Developer on 9/19/21.
//

import SwiftUI

struct ContentView: View {
    @Namespace var namespace
    let id = "id"
    @State private var flag: Bool = true
    
    var body: some View {
        HStack {
            if flag {
                Rectangle()
                    .fill(Color.green)
                    .matchedGeometryEffect(id: id, in: namespace)
                    .frame(width: 100, height: 100)
            }
            
            Spacer()
            
            Button("Switch") {
                withAnimation(.easeInOut(duration: 2.0)) {
                    flag.toggle()
                }
            }
            
            Spacer()
            
            VStack {
                Rectangle()
                    .fill(Color.yellow)
                    .frame(width: 50, height: 50)
                
                if !flag {
                    Circle()
                        .fill(Color.blue)
                        .matchedGeometryEffect(id: id, in: namespace)
                        .frame(width: 50, height: 50)
                        .border(Color.black)
                        .zIndex(1)
                }
                
                Rectangle()
                    .fill(Color.yellow)
                    .frame(width: 50, height: 50)
            }
        }
        .frame(width: 250)
        .padding(10)
        .border(Color.gray, width: 3)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
