//
//  YTProgressView.swift
//  YTAnimationDemo
//
//  Created by YTiOSer on 18/5/28.
//  Copyright © 2018 YTiOSer. All rights reserved.
//

import UIKit

class YTProgressView: UIView {

    fileprivate var label_Progress: UILabel! //显示progress数
    fileprivate var num_Progress: Int = 0 //动画显示进度
    fileprivate var progress: Int = 0 //设置progress
    fileprivate var layer_Gradient: CAGradientLayer! //渐变色layer
    fileprivate var width_MainPath: CGFloat = 0.0 // 进度条宽
    fileprivate var layer_BackPath: CAShapeLayer! // 进度里圈layer CAShapeLayer GPU执行
    fileprivate var layer_MainPathLayer: CAShapeLayer! //外圈layer
    fileprivate var timer_ProgressLabel: Timer!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    convenience init(progress: Int, width: CGFloat) {
        self.init(frame: CGRect.zero)
        self.progress = progress
        self.width_MainPath = width
        
        createView()
        drawCircle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension YTProgressView {
    
    func drawCircle(){
        
        //贝塞尔曲线画圆
        let path_Back = UIBezierPath.init(arcCenter: CGPoint.init(x: kScreenW / 2, y: kScreenH / 2), radius: kScreenW / 5 - width_MainPath, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 3, clockwise: true)
        let path_Main = UIBezierPath.init(arcCenter: CGPoint.init(x: kScreenW / 2, y: kScreenH / 2), radius: kScreenW / 5 - width_MainPath + 3, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 3, clockwise: true)
        
        layer_BackPath.path = path_Back.cgPath
        layer_MainPathLayer.path = path_Main.cgPath
        
        layer_Gradient.mask = layer_MainPathLayer //用 layer_MainPathLayer 截取渐变层
        
        //动画 显示路径
        let animation = CABasicAnimation.init(keyPath: "strokeEnd")
        animation.duration = CFTimeInterval(Double(progress) * 0.01)
        animation.fromValue = NSNumber.init(value: 0)
        animation.toValue = NSNumber.init(value: Double(progress) * 0.01)
        animation.fillMode = "forwards"
        animation.isRemovedOnCompletion = false //完成后不删除动画
        layer_MainPathLayer.add(animation, forKey: "strokeEndAnimation")
        
        if progress > 0{
            DispatchQueue.global().async {
                self.timer_ProgressLabel = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(YTProgressView.progressLabelTimerAction), userInfo: nil, repeats: true)
                RunLoop.current.run()
            }
        }else{
            label_Progress.text = "0%"
        }
        
    }
    
    func progressLabelTimerAction() {
        
        DispatchQueue.main.async {
            self.label_Progress.text = String(self.num_Progress) + "%"
        }
        
        if num_Progress >= progress{ //销毁计时器
            timer_ProgressLabel.invalidate()
            timer_ProgressLabel = nil
        }else{
            num_Progress += 1
        }
        
    }
    
}


extension YTProgressView {
    
    func createView() {
        
        label_Progress = UILabel()
        label_Progress.text = ""
        label_Progress.textAlignment = .center
        label_Progress.font = UIFont.systemFont(ofSize: 25)
        addSubview(label_Progress)
        label_Progress.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(self)
            make.width.equalTo(kScreenW)
            make.height.equalTo(30)
        }
        
        layer_BackPath = CAShapeLayer()
        layer_BackPath.fillColor = UIColor.clear.cgColor //填充颜色
        layer_BackPath.strokeColor = UIColor.white.withAlphaComponent(0.5).cgColor //划线颜色
        layer_BackPath.lineWidth = width_MainPath
        layer.addSublayer(layer_BackPath)
        
        layer_MainPathLayer = CAShapeLayer()
        layer_MainPathLayer.fillColor = UIColor.clear.cgColor
        layer_MainPathLayer.strokeColor = UIColor.white.cgColor
        layer_MainPathLayer.lineWidth = width_MainPath
        layer.addSublayer(layer_MainPathLayer)
        
        //渐变色
        layer_Gradient = CAGradientLayer()
        layer_Gradient.frame = CGRect.init(x: 0, y: 0, width: kScreenW, height: kScreenH)
        layer_Gradient.type = "axial" //线性变化  默认目前只有这一个type
        layer_Gradient.colors = [UIColor.init(hex: 0xf31414).cgColor, UIColor.init(hex: 0xf27200).cgColor, UIColor.init(hex: 0xffff00).cgColor, UIColor.init(hex: 0x2bee22).cgColor, UIColor.init(hex: 0x32a7eb).cgColor]
        layer_Gradient.locations = [0, 0.3, 0.5, 0.7, 1] //每个渐变颜色的终止位置，这些值必须是递增的，数组的长度和colors的长度最好一致
        //startPoint endPoint 分别表示渐变层的起始位置和终止位置，这两个点被定义在一个单元坐标空间，[0,0]表示左上角位置，[1,1]表示右下角位置，默认值分别是[.5,0] and [.5,1]；
        layer_Gradient.startPoint = CGPoint.init(x: 0, y: 0)
        layer_Gradient.endPoint = CGPoint.init(x: 1, y: 0)
        layer.addSublayer(layer_Gradient)
        
    }
    
}

// MARK: UIColor extension
extension UIColor {
    
    convenience init(hex: Int32) {
        let r = CGFloat(((hex & 0xFF0000) >> 16)) / 255.0
        let g = CGFloat(((hex & 0x00FF00) >> 8)) / 255.0
        let b = CGFloat(hex & 0x0000FF) / 255.0
        
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
    
}



