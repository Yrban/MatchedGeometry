//
//  HeroView.swift
//  MatchedGeometry
//
//  Created by Developer on 9/22/21.
//

import SwiftUI

struct HeroView: View {
    @Namespace var namespace
    let id = "hero"
    @State private var heroData: HeroData? = nil
    @State private var blur = false
    @State private var itemSize: CGSize = .zero

    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    let spacing: CGFloat = 50
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                LazyVGrid(columns: columns, spacing: spacing) {
                    ForEach(heroItems) { item in
                        if item.id != heroData?.id {
                        Image(systemName: item.image)
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .onTapGesture { tapImage(data: item) }
                            .matchedGeometryEffect(id: item.id, in: namespace, properties: .position)
                            .padding()
                            .frame(width: min(geometry.size.width, geometry.size.height) / 3, height: min(geometry.size.width, geometry.size.height) / 3, alignment: .center)
                            .background(Color.gray.opacity(0.25))
                            .clipped()
                        } else {
                            Color.clear
                        }
                    }
                }
                .padding(.vertical)
                .zIndex(1)
                
                if blur {
                BlurView()
                    .zIndex(2)
                }
                
                if heroData != nil {
                    Color.clear.overlay (
                        HeroDetailView(data: heroData!, onCloseTap: backTap, originalSize: itemSize, geometry: geometry)
                            .matchedGeometryEffect(id: heroData!.id, in: namespace, properties: .position)
                    )
                        .zIndex(3)
                        .transition(.modal)
                    
                }
            } // ZStack
            .onChange(of: heroData) { _ in
                itemSize = CGSize(width: min(geometry.size.width, geometry.size.height) / 3, height: min(geometry.size.width, geometry.size.height) / 3)
            }
        }
    }
    
    private func tapImage(data: HeroData) {
        withAnimation(.hero2) {
        heroData = data
        }
        
        DispatchQueue.main.async {
            withAnimation(.blur) {
                blur = true
            }
        }
    }

    private func backTap() {
        withAnimation(.blur) {
            blur = false
        }
        
        DispatchQueue.main.async {
            withAnimation(.hero2) {
                heroData = nil
            }
        }

    }
}

struct HeroData: Identifiable, Equatable {
    let image: String
    let text: String
    let id: UUID
}

let heroItems = [
    HeroData(image: "sunrise.fill", text: loremIpsum[Int.random(in: 0..<loremIpsum.count)], id: UUID()),
    HeroData(image: "sunset.fill", text: loremIpsum[Int.random(in: 0..<loremIpsum.count)], id: UUID()),
    HeroData(image: "sun.dust.fill", text: loremIpsum[Int.random(in: 0..<loremIpsum.count)], id: UUID()),
    HeroData(image: "sun.haze.fill", text: loremIpsum[Int.random(in: 0..<loremIpsum.count)], id: UUID()),
    HeroData(image: "cloud.sun.fill", text: loremIpsum[Int.random(in: 0..<loremIpsum.count)], id: UUID()),
    HeroData(image: "cloud.sun.rain.fill", text: loremIpsum[Int.random(in: 0..<loremIpsum.count)], id: UUID()),
    HeroData(image: "cloud.sun.bolt.fill", text: loremIpsum[Int.random(in: 0..<loremIpsum.count)], id: UUID()),
    HeroData(image: "thermometer.sun.fill", text: loremIpsum[Int.random(in: 0..<loremIpsum.count)], id: UUID())
]

var loremIpsum = [
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec accumsan leo ut porttitor viverra. Nulla facilisi. Donec quis dui nunc. Nullam egestas mauris in porta finibus. Nullam ac dui lacinia sem hendrerit porta sit amet et est. Vestibulum vel elit posuere purus ullamcorper tempus. Nam dictum nulla felis, quis molestie est euismod ac. Mauris et purus porta, pretium elit et, finibus arcu. Mauris turpis dolor, tempus ac ex nec, ullamcorper tristique orci.",
    "Fusce rhoncus risus nec dui semper, a tempus ex egestas. Proin laoreet porttitor consequat. Phasellus leo lorem, varius nec iaculis at, mollis eget nisi. Morbi euismod ornare lectus, ac iaculis ex dictum non. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Pellentesque eget condimentum purus. Nam tortor eros, eleifend ac est non, tristique bibendum nunc. Sed nec tristique neque, a tempus massa. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Praesent mi ligula, luctus et est et, scelerisque sagittis nulla.",
    "Phasellus ut odio sit amet ex pulvinar tempus id et diam. Fusce eget tellus metus. Suspendisse ac viverra ante. Cras vel dui finibus, posuere turpis faucibus, tristique arcu. Donec non elementum nibh, vitae dapibus magna. Etiam eu luctus ipsum. Mauris feugiat, sapien ut laoreet sollicitudin, dolor justo gravida orci, vitae vehicula arcu justo at nunc. Nunc ipsum nunc, maximus ac leo nec, lobortis tempus nisl. Mauris commodo semper dolor, non pellentesque nisi faucibus quis.",
    "Vestibulum at quam neque. Vestibulum faucibus mattis lectus. Nunc scelerisque turpis leo. Vestibulum ultrices lorem eros, at viverra mi ultrices id. Duis sit amet risus at justo condimentum elementum. Nullam volutpat pulvinar fringilla. Nulla vitae vulputate mi. Proin ac consequat mauris. Mauris et ligula orci. Mauris gravida ipsum quis dui iaculis fermentum. Aenean sit amet nisi velit. Maecenas ac laoreet eros. Donec pulvinar in quam vitae pulvinar. Donec egestas sed tellus vitae porta.",
    "Praesent lobortis nec mauris ut aliquet. Integer id purus id diam varius laoreet. Etiam molestie pretium auctor. Phasellus tempor dapibus facilisis. Integer a fermentum sem, ac fringilla mauris. Mauris turpis ipsum, tristique ac turpis non, mattis commodo mi. Nullam et eros nulla. Vestibulum mauris dolor, vestibulum eu varius hendrerit, tincidunt ac nisl. Morbi id lorem ante. Curabitur venenatis risus ac blandit pulvinar. Aenean egestas in felis eget scelerisque."
]

struct HeroView_Previews: PreviewProvider {
    static var previews: some View {
        HeroView()
    }
}
