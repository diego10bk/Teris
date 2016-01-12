//
//  GameScene.swift
//  tetst
//
//  Created by Nguyen Manh Toan on 1/12/16.
//  Copyright (c) 2016 SBS. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    let centerX:CGFloat = 500.0
    let centerY:CGFloat = 500.0
    let centerR:CGFloat = 200.0
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let shapeNode = SKShapeNode(circleOfRadius: CGFloat(centerR/5.0))
        shapeNode.position = CGPointMake(centerX, centerY)
        shapeNode.fillColor = SKColor.blackColor()
        shapeNode.lineWidth = 1
        self.addChild(shapeNode)
        shapeNode.antialiased = true
        runAction(SKAction.repeatActionForever(SKAction.playSoundFileNamed("theme.mp3", waitForCompletion: true)))
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for _ in touches {
            let sprite = SKShapeNode(circleOfRadius: 20.0)
            
            sprite.fillColor = SKColor.blackColor()
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = CGPointMake(centerX,0)
            
            let move = SKAction.moveTo(CGPointMake(centerX,centerX-centerR), duration: 1.0)
            
            let startAngle = 1.5*CGFloat(M_PI)
            let endAngle = startAngle + CGFloat(M_PI)*2
            let archPath = UIBezierPath(arcCenter: CGPointMake(centerX,centerX), radius: centerR, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            let archAction = SKAction.followPath(archPath.CGPath, asOffset: false, orientToPath: true, duration: 5.0)
            archAction.timingMode = .Linear
            

            let shape = SKShapeNode(rect: CGRectMake(self.centerX-1, self.centerY, 1 , self.centerR-1))
            shape.fillColor = SKColor.greenColor()
            shape.lineWidth = 0
            
            let smallArchPath = UIBezierPath(arcCenter: CGPointMake(self.centerX,self.centerX), radius: self.centerR/2.0, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            let smallArchAction = SKAction.followPath(smallArchPath.CGPath, asOffset: false, orientToPath: true, duration: 5.0)
            archAction.timingMode = .Linear

            shape.runAction(SKAction.repeatActionForever(smallArchAction))
            

            
            sprite.runAction(move, completion: { () -> Void in
                sprite.runAction(SKAction.repeatActionForever(archAction))
            })
            
            self.addChild(shape)
            self.addChild(sprite)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        
        /* Called before each frame is rendered */
        if (self.children.count > 0) {
           print(self.children.last?.position)
        }

    }
}
