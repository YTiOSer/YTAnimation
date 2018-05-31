//
//  YTBaseViewController.swift
//  YTAnimationDemo
//
//  Created by YTiOSer on 2018/5/23.
//  Copyright © 2018 YTiOSer. All rights reserved.
//

import UIKit

class YTBaseViewController: UIViewController {

    var view_Body: UIView!
    var btn_Play: UIButton!
    
    let margin_Top: CGFloat = 100.0 //位置上移
    let margin_ViewWidthHeight: CGFloat = 100.0 //view宽高
    let margin_ViewMidPosition: CGFloat = 50.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initMainView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension YTBaseViewController{
    
    func playBtnClick(btn: UIButton) {
        
    }
    
}


// MARK: UI
extension YTBaseViewController{
    
    func initMainView() {
        
        view.backgroundColor = UIColor.white
        
        view_Body = UIView()
        view_Body.backgroundColor = UIColor.red
        view.addSubview(view_Body)
        view_Body.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(-margin_Top)
            make.width.height.equalTo(margin_ViewWidthHeight)
        }
        
        btn_Play = UIButton.init(type: .custom)
        btn_Play.setTitle("开始", for: .normal)
        btn_Play.setTitleColor(UIColor.white, for: .normal)
        btn_Play.backgroundColor = UIColor.orange
        btn_Play.addTarget(self, action: #selector(playBtnClick(btn:)), for: .touchUpInside)
        view.addSubview(btn_Play)
        btn_Play.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.bottom.equalTo(-iPhoneXBottemHei - 80)
            make.width.equalTo(150)
            make.height.equalTo(44)
        }
        
    }
    
}
