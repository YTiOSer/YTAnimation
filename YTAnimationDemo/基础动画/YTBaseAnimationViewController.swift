//
//  YTBaseAnimationViewController.swift
//  YTAnimationDemo
//
//  Created by YTiOSer on 2018/5/24.
//  Copyright © 2018 YTiOSer. All rights reserved.
//

import UIKit

enum BaseAnimationType: Int{
    case position = 0 //位移
    case rotate = 1 //旋转
    case scale //缩放
    case opacity //透明度
    case backgroundColor //背景色
}

class YTBaseAnimationViewController: YTBaseViewController {

    fileprivate var type: BaseAnimationType = .position
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
    convenience init(enterType: Int) {
        self.init()
        switch enterType {
        case 0:
            type = .position
        case 1:
            type = .rotate
        case 2:
            type = .scale
        case 3:
            type = .opacity
        case 4:
            type = .backgroundColor
        default:
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension YTBaseAnimationViewController{
    
    override func playBtnClick(btn: UIButton) {
        switch type.rawValue {
        case 0:
            positionAnimation()
        case 1:
            rotateAnimation()
        case 2:
            scaleAnimation()
        case 3:
            opacityAnimation()
        case 4:
            backgroundColorAnimation()
        default:
            break
        }
    }
    
}

// MARK: Animation
extension YTBaseAnimationViewController{
    
//    可选的KeyPath
//    transform.scale = 比例轉換
//    transform.scale.x
//    transform.scale.y
//    transform.rotation = 旋轉
//    transform.rotation.x
//    transform.rotation.y
//    transform.rotation.z
//    transform.translation
//    transform.translation.x
//    transform.translation.y
//    transform.translation.z
//
//    opacity = 透明度
//    margin
//    zPosition
//    backgroundColor 背景颜色
//    cornerRadius 圆角
//    borderWidth
//    bounds
//    contents
//    contentsRect
//    cornerRadius
//    frame
//    hidden
//    mask
//    masksToBounds
//    opacity
//    position
//    shadowColor
//    shadowOffset
//    shadowOpacity
//    shadowRadius
    
    //位移动画
    func positionAnimation() {
        
        let animation = CABasicAnimation.init(keyPath: "position") //keyPath为系统提供
        animation.fromValue = CGPoint.init(x: margin_ViewMidPosition, y: kScreenH / 2 - margin_Top)
        animation.toValue = CGPoint.init(x: kScreenW - margin_ViewMidPosition, y: kScreenH / 2 - margin_Top)
        animation.duration = 1.0
        view_Body.layer.add(animation, forKey: "positionAnimation") //key自定义
    }
    
    //旋转动画
    func rotateAnimation() {
        
        let animation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        animation.toValue = NSNumber.init(value: Double.pi)
        animation.duration = 0.1
        animation.repeatCount = 1e100 //无限大重复次数
        view_Body.layer.add(animation, forKey: "rotateAnimation")
    }
    
    //缩放动画
    func scaleAnimation() {
        
        let animation = CABasicAnimation.init(keyPath: "transform.scale")
        animation.toValue = NSNumber.init(value: 2.0)
        animation.duration = 1.0
        view_Body.layer.add(animation, forKey: "scaleAnimation")
    }
    
    //透明度动画
    func opacityAnimation() {
        
        let animation = CABasicAnimation.init(keyPath: "opacity")
        animation.fromValue = NSNumber.init(value: 1.0)
        animation.toValue = NSNumber.init(value: 0.0)
        animation.duration = 1.0
        view_Body.layer.add(animation, forKey: "opacityAnimation")
    }
    
    //背景色动画
    func backgroundColorAnimation() {
        
        let animation = CABasicAnimation.init(keyPath: "backgroundColor")
        animation.toValue = UIColor.green.cgColor //因为layer层动画, 所以需要使用cgColor
        animation.duration = 1.0
        view_Body.layer.add(animation, forKey: "backgroundColorAnimation")
    }
    
}

