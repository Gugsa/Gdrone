//
//  Circle.swift
//  Gdrone
//
//  Created by Gugsa Gemeda on 7/16/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

enum State {
    case OnScreen
    case OffScreen
    case UserInteracting
}

class Circle: CCNode {
    
    var circleColor: String?
    var state: State = .OffScreen
    var fallSpeed: Int = -150
//    var fallImpulse: CGFloat = -10
    
    
    
    
//    override func update(delta: CCTime) {
//        
//        if state != .UserInteracting{
//            let velocityY = clampf(Float(self.physicsBody.velocity.y),Float(minVelocityY),0)
//            self.physicsBody.velocity = ccp(0, CGFloat(velocityY))
//            self.physicsBody.applyImpulse(ccp(0,fallImpulse))
//        }
//    }
}