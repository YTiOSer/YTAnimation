//
//  YTCombinationAnimationViewController.swift
//  YTAnimationDemo
//
//  Created by YTiOSer on 18/5/28.
//  Copyright © 2018 YTiOSer. All rights reserved.
//

import UIKit

enum CombinationAnimationType: Int{
    case aPath = 0 //弹球
    case dingding //钉钉
    case dianzan //点赞
    case bezier //贝塞尔曲线
    case progress //进度球
}

class YTCombinationAnimationViewController: UIViewController {

    fileprivate var type: CombinationAnimationType = .aPath
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
    }
    
    convenience init(enterType: Int){
        
        self.init()
        
        switch enterType {
        case 0:
            aPathAnimation()
        case 1:
            dingDingAnimation()
        case 2:
            dianZanAnimation()
        case 3:
            bezierAnimation()
        case 4:
            progressAnimation()
        default:
            break
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// 弹球
extension YTCombinationAnimationViewController: DCPathButtonDelegate{
    
    func aPathAnimation() {
        
        let btn_DcPath = DCPathButton.init(center: UIImage(named: "chooser-button-tab"), hilightedImage: UIImage(named: "chooser-button-tab-highlighted"))
        
        btn_DcPath?.delegate = self
        
        //各个item
        let btn_Item1 = DCPathItemButton.init(image: UIImage(named: "chooser-moment-icon-music"), highlightedImage: UIImage(named: "chooser-moment-icon-music-highlighted"), backgroundImage: UIImage(named: "chooser-moment-button"), backgroundHighlightedImage: UIImage(named: "chooser-moment-button-highlighted"))
        
        let btn_Item2 = DCPathItemButton.init(image: UIImage(named: "chooser-moment-icon-place"), highlightedImage: UIImage(named: "chooser-moment-icon-place-highlighted"), backgroundImage: UIImage(named: "chooser-moment-button"), backgroundHighlightedImage: UIImage(named: "chooser-moment-button-highlighted"))
        
        let btn_Item3 = DCPathItemButton.init(image: UIImage(named: "chooser-moment-icon-camera"), highlightedImage: UIImage(named: "chooser-moment-icon-camera-highlighted"), backgroundImage: UIImage(named: "chooser-moment-button"), backgroundHighlightedImage: UIImage(named: "chooser-moment-button-highlighted"))
        
        let btn_Item4 = DCPathItemButton.init(image: UIImage(named: "chooser-moment-icon-thought"), highlightedImage: UIImage(named: "chooser-moment-icon-thought-highlighted"), backgroundImage: UIImage(named: "chooser-moment-button"), backgroundHighlightedImage: UIImage(named: "chooser-moment-button-highlighted"))
        
        let btn_Item5 = DCPathItemButton.init(image: UIImage(named: "chooser-moment-icon-sleep"), highlightedImage: UIImage(named: "chooser-moment-icon-sleep-highlighted"), backgroundImage: UIImage(named: "chooser-moment-button"), backgroundHighlightedImage: UIImage(named: "chooser-moment-button-highlighted"))
        
        btn_DcPath?.addPathItems([btn_Item1, btn_Item2, btn_Item3, btn_Item4, btn_Item5])
        
        if let btn = btn_DcPath{
            view.addSubview(btn)
        }
        
    }
    
    func itemButtonTapped(at index: UInt) {
        print("你点击了第 \(index) 个按钮")
    }
    
}

// MARK: 钉钉
extension YTCombinationAnimationViewController{
    
    func dingDingAnimation() {
        
        let label_Home = createBtnView()
        
        let btn_UpMenu = DWBubbleMenuButton.init(frame: CGRect.init(x: kScreenW - label_Home.frame.size.width - 20, y: kScreenH - label_Home.frame.size.height - 20, width: label_Home.frame.size.width, height: label_Home.frame.size.height), expansionDirection: .DirectionUp)
        btn_UpMenu?.homeButtonView = label_Home
        btn_UpMenu?.addButtons(createBtnArray())
        
        if let btn = btn_UpMenu{
            view.addSubview(btn)
        }
    }
    
    func createBtnView() -> UILabel {
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        label.text = "Tap"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.layer.cornerRadius = label.frame.size.height / 2
        label.backgroundColor = UIColor.red
        label.clipsToBounds = true
        return label
    }
    
    func createBtnArray() -> [UIButton] {
        
        var array_Btn = [UIButton]()
        let array = ["A", "B", "C", "D", "E", "F", "G"]
        
        
        for i in 0..<array.count{
            let btn = UIButton(type: .custom)
            btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            btn.setTitle(array[i], for: .normal)
            btn.setTitleColor(UIColor.white, for: .normal)
            btn.backgroundColor = UIColor.orange
            btn.layer.cornerRadius = btn.frame.size.height / 2
            btn.clipsToBounds = true
            btn.tag = i
            btn.addTarget(self, action: #selector(dingDingBtnClick(btn:)), for: .touchUpInside)
            array_Btn.append(btn)
        }
        
        return array_Btn
    }
    
    @objc func dingDingBtnClick(btn: UIButton) {
        print("点击了 \(btn.titleLabel?.text ?? "")")
    }
    
}

// MARK: 点赞
extension YTCombinationAnimationViewController{
    
    func dianZanAnimation() {
        
        let btn = MCFireworksButton.init(frame: CGRect.zero)
        btn.setImage(UIImage(named: "Like"), for: .normal)
        btn.particleImage = UIImage(named: "Sparkle")
        btn.particleScale = 0.05
        btn.particleScaleRange = 0.02
        btn.isSelected = false
        btn.addTarget(self, action: #selector(dianZanBtnClick(btn:)), for: .touchUpInside)
        view.addSubview(btn)
        
        btn.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(view)
            make.width.height.equalTo(50)
        }
    }
    
    @objc func dianZanBtnClick(btn: MCFireworksButton) {
        
        btn.isSelected = !btn.isSelected
        
        if btn.isSelected{
            btn.popOutside(withDuration: 0.5)
            btn.setImage(UIImage(named: "Like-Blue"), for: .normal)
            btn.animate()
        }else{
            btn.popInside(withDuration: 0.5)
            btn.setImage(UIImage(named: "Like"), for: .normal)
        }
    }
    
}

// MARK: 贝塞尔曲线 ❤️
extension YTCombinationAnimationViewController {
    
    func bezierAnimation() {
        
        let path = UIBezierPath()
        //起点
        let point_Start = CGPoint.init(x: kScreenW / 2, y: 120)
        //以起点为路径的起点
        path.move(to: point_Start)
        //设置一个终点
        let point_End = CGPoint.init(x: kScreenW / 2, y: kScreenH - 400)
        //设置第一个控制点
        let point_Control1 = CGPoint.init(x: kScreenW - 100, y: 20)
        //设置第二个控制点
        let point_Control2 = CGPoint.init(x: kScreenW, y: 180)
        //添加二次贝塞尔曲线
        path.addCurve(to: point_End, controlPoint1: point_Control1, controlPoint2: point_Control2)
        //路径现以上一个终点为起点
        path.move(to: point_End)
        //设置第三个控制点
        let point_Control3 = CGPoint.init(x: 0, y: 180)
        //设置第四个贝塞尔曲线
        let point_Control4 = CGPoint.init(x: 100, y: 20)
        //添加二次贝塞尔曲线
        path.addCurve(to: point_Start, controlPoint1: point_Control3, controlPoint2: point_Control4)
        //设置线类型
        path.lineCapStyle = .round
        //设置联系类型
        path.lineJoinStyle = .round
        
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.lineWidth = 2
        layer.strokeColor = UIColor.red.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeStart = 0
        layer.strokeEnd = 1
        view.layer.addSublayer(layer)
        
        let animation = CABasicAnimation.init(keyPath: "strokeEnd")
        animation.duration = 2
        animation.fromValue = 0
        animation.toValue = 1
        animation.fillMode =    CAMediaTimingFillMode.init(rawValue: "forwards") 
        animation.isRemovedOnCompletion = false
        
        layer.add(animation, forKey: "strokeEndAnimation")
    }
    
}

// MARK: 进度条
extension YTCombinationAnimationViewController{
    
    func progressAnimation() {
        
        view.backgroundColor = UIColor.red
        
        let view_Progress = YTProgressView.init(progress: 75, width: 17)
        view.addSubview(view_Progress)
        view_Progress.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
}




