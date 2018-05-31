//
//  YTKeyFrameAnimationViewController.swift
//  YTAnimationDemo
//
//  Created by YTiOSer on 2018/5/25.
//  Copyright © 2018 YTiOSer. All rights reserved.
//

import UIKit

enum KeyFrameAnimationType: Int {
    case keyFrame = 0 //关键帧
    case path //路径
    case shake //抖动
}

class YTKeyFrameAnimationViewController: YTBaseViewController {

    fileprivate var type: KeyFrameAnimationType!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    convenience init(enterType: Int) {
        self.init()
        switch enterType {
        case 0:
            type = .keyFrame
        case 1:
            type = .path
        case 2:
            type = .shake
        default:
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension YTKeyFrameAnimationViewController {
    
    override func playBtnClick(btn: UIButton) {
        switch type.rawValue {
        case 0:
            keyFrameAnimation()
        case 1:
            pathAnimation()
        case 2:
            shakeAnimation()
        default:
            break
        }
    }
    
}

// MARK: 关键帧动画
extension YTKeyFrameAnimationViewController {
    
    //关键帧动画
    func keyFrameAnimation() {
        
        let animation = CAKeyframeAnimation.init(keyPath: "position")
        let value_0 = CGPoint.init(x: margin_ViewMidPosition, y: kScreenH / 2 - margin_ViewWidthHeight)
        let value_1 = CGPoint.init(x: kScreenW / 3, y: kScreenH / 2 - margin_ViewWidthHeight)
        let value_2 = CGPoint.init(x: kScreenW / 3, y: kScreenH / 2 + margin_ViewMidPosition)
        let value_3 = CGPoint.init(x: kScreenW * 2 / 3, y: kScreenH / 2 + margin_ViewMidPosition)
        let value_4 = CGPoint.init(x: kScreenW * 2 / 3, y: kScreenH / 2 - margin_ViewWidthHeight)
        let value_5 = CGPoint.init(x: kScreenW - margin_ViewMidPosition, y: kScreenH / 2 - margin_ViewWidthHeight)
        animation.values = [value_0, value_1, value_2, value_3, value_4, value_5]
        animation.duration = 2.0
        view_Body.layer.add(animation, forKey: "keyFrameAnimation")
    }
    
    //路径动画
    func pathAnimation() {
        
        let animation = CAKeyframeAnimation.init(keyPath: "position")
        let path = UIBezierPath.init(arcCenter: CGPoint.init(x: kScreenW / 2, y: kScreenH / 2), radius: 60, startAngle: 0.0, endAngle: .pi * 2, clockwise: true)
        animation.duration = 2.0
        animation.path = path.cgPath
        view_Body.layer.add(animation, forKey: "pathAnimation")
    }
    
    //抖动动画
    func shakeAnimation() {
        
        let animation = CAKeyframeAnimation.init(keyPath: "transform.rotation")
        let value_0 = NSNumber.init(value: -Double.pi / 180 * 8)
        let value_1 = NSNumber.init(value: Double.pi / 180 * 8)
        animation.values = [value_0, value_1, value_0]
        animation.duration = 1.0
        animation.repeatCount = 1e100
        view_Body.layer.add(animation, forKey: "shakeAnimation")
    }
    
}
