import Foundation

    class MainScene: CCNode {

    weak var scoreLabel : CCLabelTTF!
    weak var restartButton: CCButton!
    weak var lifeBar: CCNode!
    weak var insertionPoint: CCNode!
    weak var gamePhysicsNode : CCPhysicsNode!


    var circles : [CCNode] = []

    let firstCirclePosition : CGFloat = 280
    let typesOfObjects: Int = 4
    let multiplier: Int = 3

    //    weak var greenCircle : CCNode!
    //    weak var yellowCircle: CCNode!
    //    weak var redCircle: CCNode!
    //    weak var blueCircle: CCNode!

    weak var greenRectangle : CCNode!
    weak var yellowRectangle : CCNode!
    weak var redRectangle : CCNode!
    weak var blueRectangle : CCNode!
    var selectedCircle : CCNode?


//Loads the game---------------------------------------------------------------------------
        func didLoadFromCCB(){
           // gamePhysicsNode.debugDraw = true
            self.schedule("dropCircle", interval: 2)
            userInteractionEnabled = true
        }

        
//On Enter Function------------------------------------------------------------------------
        override func onEnter() {
            super.onEnter()
            createRandomCircles()
            dropCircle()
        }
        

//Generates random circles-----------------------------------------------------------------
        func createRandomCircles() {
        /*
        var prevCirclePos = firstCirclePosition
        if circles.count > 0 {
            prevCirclePos = circles.last!.position.x
        }
        */
            for index in 0...3 {
                
                let green = CCBReader.load("greenCircle") as! GreenCircle
                let yellow = CCBReader.load("yellowCircle") as! YellowCircle
                let red = CCBReader.load("redCircle") as! RedCircle
                let blue = CCBReader.load("blueCircle") as! BlueCircle
                
                green.visible = false
                yellow.visible = false
                red.visible = false
                blue.visible = false

                circles.append(green)
                circles.append(yellow)
                circles.append(red)
                circles.append(blue)

                gamePhysicsNode.addChild(green)
                gamePhysicsNode.addChild(yellow)
                gamePhysicsNode.addChild(red)
                gamePhysicsNode.addChild(blue)
                
            }
            
        /*
        var screenHalf = CCDirector.sharedDirector().viewSize().width / 2
        insertionPoint.position = (CGPoint(x:screenHalf, y: 600))
        */
        }


        
//Drop Circles---------------------------------------------------------------------------
        func dropCircle() {
            
            var random = Int(CCRANDOM_0_1() * Float(typesOfObjects) * Float(multiplier))
            
            //to account for zero indexed arrays
            
            if random == typesOfObjects * multiplier {
                random--
            }
                var circle = circles[random] as CCNode
            
            
                circle.position = insertionPoint.position
                circle.visible = true

//                circle.physicsBody.velocity.y = 0
//                gamePhysicsNode.addChild(circle)
        
        }

        
//Touch Began Function-------------------------------------------------------------------
        override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
            touch.locationInWorld()
            println(touch.locationInWorld())
            for circle in circles {
                if circle.position == touch.locationInWorld() {
                    
                    println("Adfaf")
                    selectedCircle = circle
                }
            }
            swipeLeft()
            swipeRight()
        }

        override func touchMoved(touch: CCTouch!, withEvent event: CCTouchEvent!){
            if let circle = selectedCircle {
                
                
            }
        }
//Update Function------------------------------------------------------------------------
        override func update(delta: CCTime) {
            
        //        for circle in circles.reverse() {
        //            
        //            let circleWorldPosition = gamePhysicsNode.convertToWorldSpace(circle.position)
        //            let circleScreenPosition = convertToNodeSpace(circleWorldPosition)
        //            
        //            // obstacle moved past left side of screen?
        //            if circleScreenPosition.y < (-circle.contentSize.height) {
        //                circle.removeFromParent()
        //                circles.removeAtIndex(find(circles, circle)!)
        //                
        //                // for each removed obstacle, add a new one
        //                createRandomCircles()
        //            }
        //        }
        //        //circles.physicsBody.applyImpulse(ccp(0,-50))
        }


//Move Function---------------------------------------------------------------------------
        func move(CGPoint){

        }
        
        

//Identifies swipe method-----------------------------------------------------------------
        func setupGestures() {
            var swipeLeft = UISwipeGestureRecognizer(target: self, action: "swipeLeft")
            swipeLeft.direction = .Left
            CCDirector.sharedDirector().view.addGestureRecognizer(swipeLeft)
            
            var swipeRight = UISwipeGestureRecognizer(target: self, action: "swipeRight")
            swipeRight.direction = .Right
            CCDirector.sharedDirector().view.addGestureRecognizer(swipeRight)
        }


//Swipe left------------------------------------------------------------------------------
        func swipeLeft() {
           move(CGPoint(x: -1, y: 0))
        }


//Swipe Right-----------------------------------------------------------------------------
        func swipeRight() {
            move(CGPoint(x: 1, y: 0))
        }

        
//Collision type---------------------------------------------------------------------------
        func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, hero: CCNode!, level: CCNode!) -> Bool {
            triggerGameOver()
            return true
        }


        
//Identifies game over case----------------------------------------------------------------
        func isGameOver(){ // returns boolean
        }


//Triggers GameOver Scene------------------------------------------------------------------
        func triggerGameOver() {
        }

        
//Restart function-------------------------------------------------------------------------
        func restart() {
            let scene = CCBReader.loadAsScene("MainScene")
            CCDirector.sharedDirector().presentScene(scene)
        }
        }

