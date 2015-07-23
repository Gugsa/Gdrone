import Foundation

class MainScene: CCNode {

// Mark: Variables
        
    weak var scoreLabel : CCLabelTTF!
    weak var restartButton: CCButton!
    weak var lifeBar: CCNode!
    weak var insertionPoint: CCNode!
    weak var gamePhysicsNode : CCPhysicsNode!


    var circles : [Circle] = []

    let typesOfObjects: Int = 4
    let multiplier: Int = 4

    weak var greenCircle : CCNode!
    weak var yellowCircle: CCNode!
    weak var redCircle: CCNode!
    weak var blueCircle: CCNode!

    weak var greenRectangle : CCNode!
    weak var yellowRectangle : CCNode!
    weak var redRectangle : CCNode!
    weak var blueRectangle : CCNode!
    weak var checkpoint: CCNode!
        
    var selectedCircle : Circle?
    var startPoint : CGPoint?
    
    
    


// MARK: Start
        
        func didLoadFromCCB(){
           // gamePhysicsNode.debugDraw = true
            self.schedule("dropCircle", interval: 1)
            userInteractionEnabled = true
            gamePhysicsNode.collisionDelegate = self
            checkpoint.physicsBody.sensor = true
            
        }

        

        override func onEnter() {
            super.onEnter()
            createRandomCircles()
            dropCircle()
        }
        
// MARK: Objects setup

        func createRandomCircles() {
            for index in 0...3 {
                
                let green = CCBReader.load("greenCircle") as! Circle                
                let yellow = CCBReader.load("yellowCircle") as! Circle
                let red = CCBReader.load("redCircle") as! Circle
                let blue = CCBReader.load("blueCircle") as! Circle
                
                green.visible = false
                yellow.visible = false
                red.visible = false
                blue.visible = false

                green.position = ccp(0, -300)
                yellow.position = ccp(0, -300)
                red.position = ccp(0, -300)
                blue.position = ccp(0, -300)

                circles.append(green)
                circles.append(yellow)
                circles.append(red)
                circles.append(blue)

                gamePhysicsNode.addChild(green)
                gamePhysicsNode.addChild(yellow)
                gamePhysicsNode.addChild(red)
                gamePhysicsNode.addChild(blue)
                
            }
            var screenHalf = CCDirector.sharedDirector().viewSize().width / 2
            insertionPoint.position = (CGPoint(x:screenHalf, y: 600))
        }
        
    

        func dropCircle() {
            var circle: Circle!
            do {
                var random = Int(CCRANDOM_0_1() * Float(typesOfObjects) * Float(multiplier))
                //to account for zero indexed arrays
                if random == typesOfObjects * multiplier {
                    random--
                }
                circle = circles[random]
            } while circle.state == .OnScreen
            
            circle.position = insertionPoint.position
            circle.state = .OnScreen
            circle.visible = true
        
        }
    
   
// MARK: Touch methods
    
        override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
            detectTouch(touch)
            startPoint = touch.locationInWorld()
            
            
        }
        
        func detectTouch(touch: CCTouch!){
            
            var currentTouch = convertToNodeSpace(touch.locationInWorld())
//          println(touch.locationInWorld())
            
            for circleGlobal in circles {

                var circle = convertToNodeSpace(circleGlobal.position)
                let size = circleGlobal.contentSize
                let minX = circle.x - size.width/2
                let maxX = circle.x + size.width/2
                let minY = circle.y - size.height/2
                let maxY = circle.y + size.height/2

                
                if currentTouch.x > minX && currentTouch.x < maxX && currentTouch.y > minY && currentTouch.y < maxY{

                    selectedCircle = circleGlobal
                    circleGlobal.state = .UserInteracting
                    println("Selected")
    
                }
            }
        }

        override func touchMoved(touch: CCTouch!, withEvent event: CCTouchEvent!){
            if let c = selectedCircle {
                c.position = touch.locationInWorld()
            }

        }
    
        override func touchEnded(touch: CCTouch!, withEvent event: CCTouchEvent!) {
            var endPoint = touch.locationInWorld()
            var speed = hypotf(Float(startPoint!.x - endPoint.x), Float((startPoint!.y - endPoint.y)))
            //selectedCircle?.physicsBody.applyImpulse(ccp(2500, -2500))
            selectedCircle?.state = .OnScreen
            selectedCircle = nil
            //println(startPoint!)
            //println(endPoint)
        }


        override func update(delta: CCTime) {
            for circle in circles {
                if circle.state != .UserInteracting {
//                    let velocityY = clampf(Float(circle.physicsBody.velocity.y),Float(circle.minVelocityY),0)
                    circle.physicsBody.velocity = ccp(0, CGFloat(circle.fallSpeed))
                    //circle.physicsBody.applyImpulse(ccp(0,circle.fallImpulse))
                } else {
                    circle.physicsBody.velocity = ccp(0, 0)

                }
            }
        }



        func move(direction: CGPoint){
        }


// MARK: Game Logic

        func isGameOver(){ // returns boolean
        }


        func triggerGameOver() {
        }

        func restart() {
            let scene = CCBReader.loadAsScene("MainScene")
            CCDirector.sharedDirector().presentScene(scene)
        }
}

// MARK: CCPhysicsCollisionDelegate

extension MainScene: CCPhysicsCollisionDelegate {
    
            func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, circle: Circle!, checkpoint: CCNode!) -> Bool {
            circle.state = .OffScreen
            return true
        }
}


