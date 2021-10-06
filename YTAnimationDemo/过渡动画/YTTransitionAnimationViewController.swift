//
//  YTTransitionAnimationViewController.swift
//  YTAnimationDemo
//
//  Created by YTiOSer on 18/5/28.
//  Copyright © 2018 YTiOSer. All rights reserved.
//

import UIKit

enum TransitionAnimationType: Int{
    case fade = 0 //淡出 默认
    case moveIn //覆盖原图
    case push // 推出
    case reveal //底部显示出来
    case cube //立方旋转
    case suck //吸走
    case oglFlip //水平翻转 沿y轴
    case ripple //滴水效果
    case curl //卷曲翻页(向上翻页)
    case unCurl //卷曲翻页返回(向下翻页)
    case caOpen //相机开启
    case caClose //相机关闭
}

class YTTransitionAnimationViewController: YTBaseViewController {

    fileprivate var type: TransitionAnimationType = .fade
    fileprivate var label_Num: UILabel!
    fileprivate var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createLabel()
    }
    
    convenience init(enterType: Int) {
        self.init()
        switch enterType {
        case 0:
            type = .fade
        case 1:
            type = .moveIn
        case 2:
            type = .push
        case 3:
            type = .reveal
        case 4:
            type = .cube
        case 5:
            type = .suck
        case 6:
            type = .oglFlip
        case 7:
            type = .ripple
        case 8:
            type = .curl
        case 9:
            type = .unCurl
        case 10:
            type = .caOpen
        case 11:
            type = .caClose
        default:
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: 逻辑处理
extension YTTransitionAnimationViewController{
    
    func changeLabelNum() {
        
        if index > 4{ index = 0 }
        
        let array_Color = [UIColor.cyan, UIColor.magenta, UIColor.red, UIColor.purple, UIColor.orange]
        let array_Num = ["1", "2", "3", "4", "5"]
        
        view_Body.backgroundColor = array_Color[index]
        label_Num.text = array_Num[index]
        
        index += 1
    }
    
    override func playBtnClick(btn: UIButton) {
        
        changeLabelNum()
        
        switch type.rawValue {
        case 0:
            fadeAnimation()
        case 1:
            moveInAnimation()
        case 2:
            pushAnimation()
        case 3:
            revealAnimation()
        case 4:
            cubeAnimation()
        case 5:
            suckAnimation()
        case 6:
            oglFlipAnimation()
        case 7:
            rippleAnimation()
        case 8:
            curlAnimation()
        case 9:
            unCurlAnimation()
        case 10:
            caOpenAnimation()
        case 11:
            caCloseAnimation()
        default:
            break
        }
    }
    
}

// MARK: 过渡动画
extension YTTransitionAnimationViewController{
    
    // CATransition 转场动画
    
    func fadeAnimation() {
        
        let animation_Fade = CATransition()
        animation_Fade.type = .fade
        animation_Fade.duration = 1.0
        view_Body.layer.add(animation_Fade, forKey: "fadeAnimation")
    }
    
    func moveInAnimation() {
        
        let animation_MoveIn = CATransition()
        animation_MoveIn.type = .moveIn
        animation_MoveIn.duration = 1.0
        view_Body.layer.add(animation_MoveIn, forKey: "moveInAnimation")
    }
    
    func pushAnimation() {
        
        let animation_Push = CATransition()
        animation_Push.type = .push
        animation_Push.subtype = .fromRight /* the legal values are `fromLeft', `fromRight', `fromTop' and`fromBottom'. */
        animation_Push.duration = 1.0
        view_Body.layer.add(animation_Push, forKey: "pushAnimation")
    }
    
    func revealAnimation() {
        
        let animation_Reveal = CATransition()
        animation_Reveal.type = .reveal
        animation_Reveal.subtype = .fromRight
        animation_Reveal.duration = 1.0
        view_Body.layer.add(animation_Reveal, forKey: "revealAnimation")
    }
    
    func cubeAnimation() {
        
        let animation_Cube = CATransition()
        animation_Cube.type = CATransitionType.init(rawValue: "cube")
        animation_Cube.subtype = .fromRight
        animation_Cube.duration = 1.0
        view_Body.layer.add(animation_Cube, forKey: "cubeAnimation")
    }
    
    func suckAnimation() {
        
        let animation_Suck = CATransition()
        animation_Suck.type = CATransitionType.init(rawValue: "suckEffect")
        animation_Suck.subtype = .fromRight
        animation_Suck.duration = 1.0
        view_Body.layer.add(animation_Suck, forKey: "suckAnimation")
    }
    
    func oglFlipAnimation() {
        
        let animation_OglFlip = CATransition()
        animation_OglFlip.type = CATransitionType.init(rawValue: "oglFlip")
        animation_OglFlip.subtype = .fromRight
        animation_OglFlip.duration = 1.0
        view_Body.layer.add(animation_OglFlip, forKey: "oglFlipAnimation")
    }
    
    func rippleAnimation() {
        
        let animation_Ripple = CATransition()
        animation_Ripple.type = CATransitionType.init(rawValue: "rippleEffect")
        animation_Ripple.subtype = .fromRight
        animation_Ripple.duration = 1.0
        view_Body.layer.add(animation_Ripple, forKey: "rippleAnimation")
    }
    
    func curlAnimation() {
        
        let animation_Curl = CATransition()
        animation_Curl.type = CATransitionType.init(rawValue: "pageCurl")
        animation_Curl.subtype = .fromRight
        animation_Curl.duration = 1.0
        view_Body.layer.add(animation_Curl, forKey: "curlAnimation")
    }
    
    func unCurlAnimation() {
        
        let animation_UnCurl = CATransition()
        animation_UnCurl.type = CATransitionType.init(rawValue: "pageUnCurl")
        animation_UnCurl.subtype = .fromRight
        animation_UnCurl.duration = 1.0
        view_Body.layer.add(animation_UnCurl, forKey: "unCurlAnimation")
    }
    
    func caOpenAnimation() {
        
        let animation_CaOpen = CATransition()
        animation_CaOpen.type = CATransitionType.init(rawValue: "cameraIrisHollowOpen")
        animation_CaOpen.subtype = .fromRight
        animation_CaOpen.duration = 1.0
        view_Body.layer.add(animation_CaOpen, forKey: "caOpenAnimation")
    }
    
    func caCloseAnimation() {
        
        let animation_CaClose = CATransition()
        animation_CaClose.type = CATransitionType.init(rawValue: "cameraIrisHollowClose")
        animation_CaClose.subtype = .fromRight
        animation_CaClose.duration = 1.0
        view_Body.layer.add(animation_CaClose, forKey: "caCloseAnimation")
    }
    
}

// MARK: UI
extension YTTransitionAnimationViewController{
    
    func createLabel() {
        
        label_Num = UILabel()
        label_Num.font = UIFont.systemFont(ofSize: 40)
        label_Num.textAlignment = .center
        view_Body.addSubview(label_Num)
        label_Num.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(view_Body)
            make.width.height.equalTo(40)
        }
        
        changeLabelNum()
    }
    
}


