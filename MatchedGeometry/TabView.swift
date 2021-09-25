//
//  TabView.swift
//  MatchedGeometry
//
//  Created by Developer on 9/19/21.
//

import SwiftUI

struct TabViewController: View {
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            ContentView()
                .tabItem {
                    Text("Square")
                }
                .tag(0)

            PolygonView()
                .tabItem {
                    Text("Polygon")
                }
                .tag(1)
            
            HeroView()
                .tabItem {
                    Text("Hero View")
                }
                .tag(2)
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabViewController()
    }
}
