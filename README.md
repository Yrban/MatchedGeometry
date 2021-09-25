# MatchedGeometry
Based from https://swiftui-lab.com/matchedgeometryeffect-part1/. Updated and commented.

Requires iOS 15.

While following along with this tutorial, MatchedGeometryEffect – Part 1 (Hero Animations) on The SwiftUI Lab, I realized that the actual Hero Animation project was not well documented. The rest of the article walks you through in detail, but then just dumps code on you for the actual animation. I also found that a great deal of the code was unnecessary as well as now out of date to an extent for SwiftUI. So I wanted to make a project to demonstrate the tutorial including the Hero Animation.

What I learned in this was if you want an adaptible interface, you will have to use a GeometryReader. The GeometryReader is necessary because you need to know the original size of the thumbnail view that your hero animation emerges from. The original project from The SwiftUI Lab uses fixed sizing. That is all well and good for a demo, but will not work for a production app. No one is going to adjust your view sizes for you.

There were also a great deal of computations in the ModalView that at first look seemed unnecessary and strange. When I created the equivalent HeroDetailView, I only used currentSize - originalSize and then multiplied that by the transitionPercentage. And the project worked, except I kept coming up with a "Invalid frame dimension (negative or non-finite)" runtime error, ONLY when the HeroDetailView was animating back down to the thumbnail. After setting a runtime breakpoint, I found that transitionPercentage turned negative. It turns out that the way the spring effect works is it turns the transition amount negative to produce the bouncing effect by making the animated view smaller and bigger(as well as moving it slightly), and this negative percentage was causing the frame size to go negative.

The fix was already in The SwiftUI Lab's code, but I hadn't understood that originally. This was why the difference between the current size and the original size was computed. Because it was this that needed to be animated. The fromae height and width now became the original size plus the difference times the transitionPercentage. THis will cause the frame to shrink to just smaller than the original size, so it can then bounce to juste larger, and back again until the animation ends.

There is one remaining error that does not seem to affect anything. Occasionally, there is an id mismatch error in the matchedGeometryEffect views.
