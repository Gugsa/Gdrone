//
//  greenCircle.swift
//  Gdrone
//
//  Created by Gugsa Gemeda on 7/13/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class GreenCircle: CCNode{
    
    override func update(delta: CCTime) {
        
        let velocityY = clampf(Float(self.physicsBody.velocity.y),-Float(70),0)
        self.physicsBody.velocity = ccp(0, CGFloat(velocityY))
        self.physicsBody.applyImpulse(ccp(0,-20))
        
    }
}
