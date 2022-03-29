//
//  CircleProgressBar.swift
//
//  Created by Максим on 29.03.2022.
//

import UIKit

class CircleProgressBar: UIView {
    
    private var barRadius: Int!
    private var barWight: CGFloat = 8
    private var progressLayer: CAShapeLayer!
    private var barCenter: CGPoint!
    private(set) var barProgress: CGFloat = 0 {
        didSet{
            progressLayer.strokeEnd = barProgress
        }
    }
    var barTintColor = UIColor.black {
        didSet{
            progressLayer.strokeColor = barTintColor.cgColor
        }
    }
    
// MARK: - init
    public init(center: CGPoint, radius: Int) {
        
        super.init(frame: CGRect(origin: CGPoint(x: center.x - CGFloat(radius), y: center.y - CGFloat(radius)), size: CGSize(width: radius * 2, height: radius * 2)))
        self.barCenter = center
        self.barRadius = radius

        bildBar()
    }
    
    public init(center: CGPoint, radius: Int, wight: CGFloat, progress: CGFloat, color: UIColor) {
        
        super.init(frame: CGRect(origin: CGPoint(x: center.x - CGFloat(radius), y: center.y - CGFloat(radius)), size: CGSize(width: radius * 2, height: radius * 2)))
        self.barCenter = self.center
        self.barRadius = radius
        self.barTintColor = color
        self.barProgress = progress / 100
        self.barWight = wight

        bildBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
// MARK: - Functions
    private func bildBar() {
        
        self.backgroundColor = .clear
        
        let backLayer = configureBackgroundLayer()
        self.progressLayer = configureProgressLayer()

        self.layer.addSublayer(backLayer)
        self.layer.addSublayer(progressLayer)
    }

    
    private func startAnimation(progress: CGFloat) {
        
        let strokeEndAnimation = CABasicAnimation()
        
        strokeEndAnimation.toValue = progress
        strokeEndAnimation.duration = 2.0
        self.progressLayer.add(strokeEndAnimation, forKey: "strokeEndAnimation")
    }
    
    
    func setProgress(to value: Int) {
        
        barProgress = CGFloat(value) / 100
        startAnimation(progress: barProgress)
    }
    
    
    func resetProgressBar() {
        
        barProgress = 0
        startAnimation(progress: barProgress)
    }
}


// MARK: - Configures
extension CircleProgressBar {
    
     private func configureProgressBarPath() -> CGPath {
         UIBezierPath(arcCenter: CGPoint(x: barRadius, y: barRadius),
                     radius: CGFloat(barRadius),
                     startAngle: 3 * CGFloat.pi / 4,
                     endAngle: CGFloat.pi / 4,
                     clockwise: true).cgPath
    }
    
    private func configureBackgroundLayer() -> CAShapeLayer {
        let backgroundLayer = CAShapeLayer()
        
        backgroundLayer.path = configureProgressBarPath()
        backgroundLayer.strokeColor = UIColor.lightGray.cgColor
        backgroundLayer.lineWidth = barWight
        backgroundLayer.lineCap = .round
        backgroundLayer.fillColor = nil
        
        return backgroundLayer
    }
    
     private func configureProgressLayer() -> CAShapeLayer {
        let progressLayer = CAShapeLayer()
        
        progressLayer.path = configureProgressBarPath()
        progressLayer.strokeColor = barTintColor.cgColor
        progressLayer.lineWidth = barWight + 1.0
        progressLayer.lineCap = .round
        progressLayer.fillColor = nil
        progressLayer.strokeEnd = barProgress
        
        return progressLayer
    }
}
