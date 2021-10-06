//
//  YTGroupAnimationViewController.swift
//  YTAnimationDemo
//
//  Created by YTiOSer on 18/5/25.
//  Copyright © 2018 YTiOSer. All rights reserved.
//

import UIKit

enum GroupAnimationType: Int {
    case sameTime = 0 //同时
    case goOn //连续
}

class YTGroupAnimationViewController: YTBaseViewController {

    fileprivate var type: GroupAnimationType!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    convenience init(enterType: Int) {
        self.init()
        switch enterType {
        case 0:
            type = .sameTime
        case 1:
            type = .goOn
        default:
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension YTGroupAnimationViewController{
    
    override func playBtnClick(btn: UIButton) {
        switch type.rawValue {
        case 0:
            sameTimeAnimation()
        case 1:
            goOnAnimation()
        default:
            break
        }
    }
    
}


// MARK: 组动画
extension YTGroupAnimationViewController{
    
    //同时
    func sameTimeAnimation() {
        
        let animation_Position = CAKeyframeAnimation.init(keyPath: "position")
        let value_0 = CGPoint.init(x: margin_ViewMidPosition, y: kScreenH / 2 - margin_ViewMidPosition)
        let value_1 = CGPoint.init(x: kScreenW / 3, y: kScreenH / 2 - margin_ViewMidPosition)
        let value_2 = CGPoint.init(x: kScreenW / 3, y: kScreenH / 2 + margin_ViewMidPosition)
        let value_3 = CGPoint.init(x: kScreenW / 3 * 2, y: kScreenH / 2 + margin_ViewMidPosition)
        let value_4 = CGPoint.init(x: kScreenW / 3 * 2, y: kScreenH / 2 - margin_ViewMidPosition)
        let value_5 = CGPoint.init(x: kScreenW - margin_ViewMidPosition, y: kScreenH / 2 - margin_ViewMidPosition)
        animation_Position.values = [value_0, value_1, value_2, value_3, value_4, value_5]
        
        let animation_BGColor = CABasicAnimation.init(keyPath: "backgroundColor")
        animation_BGColor.toValue = UIColor.green.cgColor
        
        let animation_Rotate = CABasicAnimation.init(keyPath: "transform.rotation")
        animation_Rotate.toValue = NSNumber.init(value: Double.pi * 4)
        
        let animation_Group = CAAnimationGroup()
        animation_Group.animations = [animation_Position, animation_BGColor, animation_Rotate]
        animation_Group.duration = 4.0
        view_Body.layer.add(animation_Group, forKey: "groupAnimation")
    }
    
    //连续动画 最主要的是处理好各个动画时间的衔接
    func goOnAnimation() {
        
        //定义一个动画开始的时间
        let currentTime = CACurrentMediaTime()
        
        let animation_Position = CABasicAnimation.init(keyPath: "position")
        animation_Position.fromValue = CGPoint.init(x: margin_ViewMidPosition, y: kScreenH / 2)
        animation_Position.toValue = CGPoint.init(x: kScreenW / 2, y: kScreenH / 2)
        animation_Position.duration = 1.0
        animation_Position.fillMode = CAMediaTimingFillMode.init(rawValue: "forwards")  //只在前台
        animation_Position.isRemovedOnCompletion = false //切出界面再回来动画不会停止
        animation_Position.beginTime = currentTime
        view_Body.layer.add(animation_Position, forKey: "positionAnimation")
        
        let animation_Scale = CABasicAnimation.init(keyPath: "transform.scale")
        animation_Scale.fromValue = NSNumber.init(value: 0.7)
        animation_Scale.toValue = NSNumber.init(value: 2.0)
        animation_Scale.duration = 1.0
        animation_Scale.fillMode = CAMediaTimingFillMode.init(rawValue: "forwards")
        animation_Scale.isRemovedOnCompletion = false
        animation_Scale.beginTime = currentTime + 1.0
        view_Body.layer.add(animation_Scale, forKey: "scaleAnimation")
        
        let animation_Rotate = CABasicAnimation.init(keyPath: "transform.rotation")
        animation_Rotate.toValue = NSNumber.init(value: Double.pi * 4)
        animation_Rotate.duration = 1.0
        animation_Rotate.fillMode = CAMediaTimingFillMode.init(rawValue: "forwards")
        animation_Rotate.isRemovedOnCompletion = false
        animation_Rotate.beginTime = currentTime + 2.0
        view_Body.layer.add(animation_Rotate, forKey: "rotateAnimation")
    }
    
}






