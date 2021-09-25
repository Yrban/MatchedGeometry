//
//  Animations.swift
//  HeroAnimations
//
//  Created by SwiftUI-Lab on 04-Jul-2020.
//  https://swiftui-lab.com/matchedGeometryEffect-part1
//

import SwiftUI

// Use this variable to make all animations super slow, good for debugging transitions
var debugAnimations = false

extension Animation {
    static var hero1: Animation { debugAnimations ? debug : .interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.25) }
    
    static var hero2: Animation { debugAnimations ? debug : .interpolatingSpring(mass: 1.0, stiffness: 80, damping: 10, initialVelocity: 7)}

    static var resetConfig: Animation { debugAnimations ? debug : .interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.25) }

    static var blur: Animation { debugAnimations ? debug : .linear(duration: 0.25) }
    
    static var debug: Animation { .easeInOut(duration: 4.0) }
}
