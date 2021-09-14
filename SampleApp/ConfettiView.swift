//
//  ConfettiView.swift
//  SampleApp
//
//  Created by Mathew Thomas Li on 9/13/21.
//

import Foundation
import UIKit

private let kAnimationLayerKey = "com.sample.animationLayer"

class ConfettiView: UIView {
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func emit() {
        
        print("emit")
        
        let confettiTypes: [ConfettiType] = {
            let confettiColors = [
                (r:149,g:58,b:255), (r:255,g:195,b:41), (r:255,g:101,b:26),
                (r:123,g:92,b:255), (r:76,g:126,b:255), (r:71,g:192,b:255),
                (r:255,g:47,b:39), (r:255,g:91,b:134), (r:233,g:122,b:208)
                ].map { UIColor(red: $0.r / 255.0, green: $0.g / 255.0, blue: $0.b / 255.0, alpha: 1) }

            // For each position x shape x color, construct an image
            return [ConfettiPosition.foreground, ConfettiPosition.background].flatMap { position in
                return [ConfettiShape.rectangle, ConfettiShape.circle].flatMap { shape in
                    return confettiColors.map { color in
                        return ConfettiType(color: color, shape: shape, position: position)
                    }
                }
            }
        }()
        
        let confettiCells: [CAEmitterCell] = {
            return confettiTypes.map { confettiType in
                let cell = CAEmitterCell()
                
                if confettiType.position == .background {
                    cell.scale = 0.5
                    cell.alphaRange = 5
                }

                cell.beginTime = 0.1
                cell.birthRate = 10
                cell.contents = confettiType.image.cgImage
                cell.emissionRange = CGFloat(Double.pi)
                cell.lifetime = 4
                cell.spin = 4
                cell.spinRange = 8
                cell.velocityRange = 100
                cell.yAcceleration = 150
                
                cell.setValue("plane", forKey: "particleType")
                cell.setValue(Double.pi, forKey: "orientationRange")
                cell.setValue(Double.pi / 2, forKey: "orientationLongitude")
                cell.setValue(Double.pi / 2, forKey: "orientationLatitude")

                return cell
            }
        }()

        let confettiLayer: CAEmitterLayer = {
            let emitterLayer = CAEmitterLayer()
            
            emitterLayer.birthRate = 0  //this is a multiplier to the cell birthrate
            emitterLayer.emitterCells = confettiCells
            emitterLayer.emitterPosition = CGPoint(x: self.bounds.midX, y: self.bounds.minY)
            emitterLayer.emitterSize = CGSize(width: self.bounds.size.width, height: 500)
            emitterLayer.emitterShape = .rectangle
            emitterLayer.frame = self.bounds

            emitterLayer.beginTime = CACurrentMediaTime()
            return emitterLayer
        }()
       
        func addBirthrateAnimation(to layer: CALayer) {
            let animation = CABasicAnimation()
            animation.delegate = self
            animation.setValue(layer, forKey: kAnimationLayerKey)
            
            // This changes the birthrate over time
            animation.duration = 3
            animation.fromValue = 1
            animation.toValue = 0
            layer.add(animation, forKey: "birthRate")
        }
        self.layer.addSublayer(confettiLayer)
        addBirthrateAnimation(to: confettiLayer)
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        guard let superview = newSuperview else { return }
        frame = superview.bounds
    }
}



extension ConfettiView: CAAnimationDelegate {
    func animationDidStop(_ animation: CAAnimation, finished flag: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            // Not sure if I need to remove the layers since I'm removing the animation view, but it can't hurt
            if let layer = animation.value(forKey: kAnimationLayerKey) as? CALayer {
                layer.removeAllAnimations()
                layer.removeFromSuperlayer()
            }
            self.removeFromSuperview()
        }
    }
}
