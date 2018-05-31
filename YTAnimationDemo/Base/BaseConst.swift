//
//  BaseConst.swift
//  YTAnimationDemo
//
//  Created by YTiOSer on 2018/5/24.
//  Copyright © 2018 YTiOSer. All rights reserved.
//

import UIKit

let kScreenW = UIScreen.main.bounds.size.width
let kScreenH = UIScreen.main.bounds.size.height
let kScreenBounds = UIScreen.main.bounds
let iPhoneXBottemHei:CGFloat = UIDevice.current.isX() == true ? 34.0 : 0
let kNavigationBarHei:CGFloat = 64.0 + (UIDevice.current.isX() == true ? 24.0 : 0)
let kBottomBarHei:CGFloat = 49.0 + iPhoneXBottemHei

extension UIDevice {
    public func isX() -> Bool {
        if UIScreen.main.bounds.height == 812 {
            return true
        }
        
        return false
    }
}

