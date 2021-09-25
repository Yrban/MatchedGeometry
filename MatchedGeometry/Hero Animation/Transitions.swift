//
//  Transitions.swift
//  HeroAnimations
//
//  Created by SwiftUI-Lab on 04-Jul-2020.
//  https://swiftui-lab.com/matchedGeometryEffect-part1
//

import SwiftUI

extension AnyTransition {
    /// This transition will pass a value (0.0 - 1.0), indicating how much of the
    /// transition has passed. To communicate with the view, it will
    /// use the custom environment key .modalTransitionPercent
    /// it will also make sure the transitioning view is not faded in or out and it
    /// stays visible at all times.
    static var modal: AnyTransition {
        AnyTransition.modifier(
            active: ThumbnailExpandedModifier(transitionPercentage: 0),
            identity: ThumbnailExpandedModifier(transitionPercentage: 1)
        )
    }
    
    struct ThumbnailExpandedModifier: AnimatableModifier {
        var transitionPercentage: CGFloat
        
        var animatableData: CGFloat {
            get { transitionPercentage }
            set { transitionPercentage = newValue }
        }
        
        func body(content: Content) -> some View {
            return content
                .environment(\.modalTransitionPercent, transitionPercentage)
                .opacity(1)
        }
    }
    
    /// This transition will cause the view to disappear,
    /// until the last frame of the animation is reached
    static var invisible: AnyTransition {
        AnyTransition.modifier(
            active: InvisibleModifier(transitionPercentage: 0),
            identity: InvisibleModifier(transitionPercentage: 1)
        )
    }
    
    struct InvisibleModifier: AnimatableModifier {
        var transitionPercentage: Double
        
        var animatableData: Double {
            get { transitionPercentage }
            set { transitionPercentage = newValue }
        }
        
        
        func body(content: Content) -> some View {
            content.opacity(transitionPercentage == 1.0 ? 1 : 0)
        }
    }
}
