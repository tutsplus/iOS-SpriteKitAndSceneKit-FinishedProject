//
//  MainScene.swift
//  CombinedSpriteKitSceneKit
//
//  Created by Davis Allie on 21/05/2015.
//  Copyright (c) 2015 tutsplus. All rights reserved.
//

import UIKit
import SceneKit
import SpriteKit

class MainScene: SCNScene {
    
    var cubeNode: SCNNode!
    var cameraNode: SCNNode!
    var lightNode: SCNNode!
    
    override init() {
        super.init()
        
        let cube = SCNBox(width: 3, height: 3, length: 3, chamferRadius: 0)
        
        let materialScene = SKScene(size: CGSize(width: 100, height: 100))
        let backgroundNode = SKSpriteNode(color: UIColor.blueColor(), size: materialScene.size)
        backgroundNode.position = CGPoint(x: materialScene.size.width/2.0, y: materialScene.size.height/2.0)
        materialScene.addChild(backgroundNode)
        let blueAction = SKAction.colorizeWithColor(UIColor.blueColor(), colorBlendFactor: 1, duration: 1)
        let redAction = SKAction.colorizeWithColor(UIColor.redColor(), colorBlendFactor: 1, duration: 1)
        let greenAction = SKAction.colorizeWithColor(UIColor.greenColor(), colorBlendFactor: 1, duration: 1)
        backgroundNode.runAction(SKAction.repeatActionForever(SKAction.sequence([blueAction, redAction, greenAction])))
        
        let cubeMaterial = SCNMaterial()
        cubeMaterial.diffuse.contents = materialScene
        cube.materials = [cubeMaterial]
        self.cubeNode = SCNNode(geometry: cube)
        self.cubeNode.runAction(SCNAction.repeatActionForever(SCNAction.rotateByX(0, y: 0.01, z: 0, duration: 1.0/60.0)))
        
        let camera = SCNCamera()
        camera.xFov = 60
        camera.yFov = 60
        
        let ambientLight = SCNLight()
        ambientLight.type = SCNLightTypeAmbient
        ambientLight.color = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        
        let cameraConstraint = SCNLookAtConstraint(target: self.cubeNode)
        cameraConstraint.gimbalLockEnabled = true
        
        self.cameraNode = SCNNode()
        self.cameraNode.camera = camera
        self.cameraNode.constraints = [cameraConstraint]
        self.cameraNode.light = ambientLight
        self.cameraNode.position = SCNVector3(x: 5, y: 5, z: 5)
        
        let omniLight = SCNLight()
        omniLight.type = SCNLightTypeOmni
        
        self.lightNode = SCNNode()
        self.lightNode.light = omniLight
        self.lightNode.position = SCNVector3(x: -3, y: 5, z: 3)
        
        self.rootNode.addChildNode(self.cubeNode)
        self.rootNode.addChildNode(self.cameraNode)
        self.rootNode.addChildNode(self.lightNode)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if keyPath == "paused" {
            self.paused = change[NSKeyValueChangeNewKey] as! Bool
        }
    }}
