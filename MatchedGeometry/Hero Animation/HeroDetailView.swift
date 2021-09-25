//
//  HeroDetailView.swift
//  MatchedGeometry
//
//  Created by Developer on 9/22/21.
//

import SwiftUI

struct HeroDetailView: View {
    @Environment(\.modalTransitionPercent) var pct: CGFloat
    
    let data: HeroData
    var onCloseTap: () -> Void
    let originalSize: CGSize
    let geometry: GeometryProxy
    let maxPct: CGFloat = 0.9
    
    var body: some View {
        // Computing the difference between the current size and the original size is necessary when using a spring animation, as the spring animation will percentage will go negative to make the view look like it is bouncing.
        let difference = CGSize(width: geometry.size.width - originalSize.width, height: geometry.size.height - originalSize.height)
        
        let height = originalSize.height + difference.height * pct * maxPct
        let width = originalSize.width + difference.width * pct * maxPct
        
        return VStack {
            Group {
            Image(systemName: data.image)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            
            Divider()
            Text(data.text)
            }
            // We want this view to disappear as the pct approaches 0, or else there will be a small version bouncing with the matched view.
            .opacity(pct > 0.1 ? pct : 0)
        }
        .frame(width: width, height: height, alignment: .center)
        .onTapGesture(perform: onCloseTap)
    }
}

