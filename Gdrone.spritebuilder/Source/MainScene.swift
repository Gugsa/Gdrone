import Foundation

class MainScene: CCNode {
    
    weak var scoreLabel : CCLabelTTF!
    weak var restartButton: CCButton!
    weak var lifeBar: CCNode!
    weak var insertionPoint: CCNode!
    weak var gamePhysicsNode : CCPhysicsNode!
    
    var circles : [CCNode] = []
    
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
    

    //Loads the game
    func didLoadFromCCB(){
        //gamePhysicsNode.debugDraw = true
        self.schedule("dropCircle", interval: 2.0)
    }
    
    override func onEnter() {
        super.onEnter()
        createRandomCircles()
        dropCircle()
    }
    
    
    //Generates random circles
    func createRandomCircles() {
        
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
//        let green = CCBReader.load("greenCircle") as! GreenCircle
//        let yellow = CCBReader.load("yellowCircle") as! YellowCircle
//        let red = CCBReader.load("redCircle") as! RedCircle
//        let blue = CCBReader.load("blueCircle") as! BlueCircle
//        
//        gamePhysicsNode.addChild(green)
//        gamePhysicsNode.addChild(blue)
//        gamePhysicsNode.addChild(yellow)
//        gamePhysicsNode.addChild(red)
        

    
        
//       // var random = CCRANDOM_0_1() * 4
//        var screenHalf = CCDirector.sharedDirector().viewSize().width / 2
//    
//        green.position = (CGPoint(x: screenHalf, y: 1200))
//        yellow.position = (CGPoint(x: screenHalf, y: 1000))
//        red.position = (CGPoint(x: screenHalf, y: 800))
//        blue.position = (CGPoint(x: screenHalf, y: 600))
    
    }
    
    func dropCircle() {
        var random = Int(CCRANDOM_0_1() * Float(typesOfObjects) * Float(multiplier))
        
        //to account for zero indexed arrays
        if random == typesOfObjects * multiplier {
            random--
        }
        
        var circle = circles[random] as CCNode
        circle.position = insertionPoint.position
        circle.visible = true
//        gamePhysicsNode.addChild(circle)
    }
    
    //Touch Function
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        swipeLeft()
        swipeRight()
    }
    
    
    //Update Function
    override func update(delta: CCTime) {
//        greenCircle.physicsBody.applyImpulse(ccp(0,-50))
//        yellowCircle.physicsBody.applyImpulse(ccp(0,-50))
//        redCircle.physicsBody.applyImpulse(ccp(0,-50))
//        blueCircle.physicsBody.applyImpulse(ccp(0,-50))
    }
    
    
    //Moves the circles to the rectangels
    func move(CGPoint){

    }
    
    //Identifies swipe methods
    func swipeLeft() {
       move(CGPoint(x: -1, y: 0))
    }
    
    
    
    func swipeRight() {
        move(CGPoint(x: 1, y: 0))
    }
    
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, hero: CCNode!, level: CCNode!) -> Bool {
        triggerGameOver()
        return true
    }
    
    
    //Identifies game over case
    func isGameOver(){ // returns boolean
    }
    
    
    //Triggers GameOver Scene
    func triggerGameOver() {
    }
    
    func restart() {
        let scene = CCBReader.loadAsScene("MainScene")
        CCDirector.sharedDirector().presentScene(scene)
    }
}

