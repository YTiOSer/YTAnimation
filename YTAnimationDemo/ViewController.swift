//
//  ViewController.swift
//  YTAnimationDemo
//
//  Created by YTiOSer on 2018/5/23.
//  Copyright © 2018 YTiOSer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    fileprivate var myTableView: UITableView!
    fileprivate var array_Dict = [Dictionary<String, Any>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "动画"
        view.backgroundColor = UIColor.white
        configData()
        initMainView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

// MARK: 配置数据
extension ViewController{
    
    func configData() {
        
        var dict_SectionOne = Dictionary<String, Any>()
        dict_SectionOne["title"] = "基础动画"
        dict_SectionOne["rowValue"] = ["位移", "旋转", "缩放", "透明度", "背景色"]
        
        var dict_SectionTwo = Dictionary<String, Any>()
        dict_SectionTwo["title"] = "关键帧动画"
        dict_SectionTwo["rowValue"] = ["关键帧", "路径", "抖动"]
        
        var dict_SectionThree = Dictionary<String, Any>()
        dict_SectionThree["title"] = "组动画"
        dict_SectionThree["rowValue"] = ["同时", "连续"]
        
        var dict_SectionFour = Dictionary<String, Any>()
        dict_SectionFour["title"] = "过渡动画"
        dict_SectionFour["rowValue"] = ["fade", "moveln", "push", "reveal", "cube", "suck", "oglFile", "ripple", "curl", "unCurl", "caOpen", "caClose"]
        
        var dict_SectionFive = Dictionary<String, Any>()
        dict_SectionFive["title"] = "项目案例"
        dict_SectionFive["rowValue"] = ["弹球", "钉钉", "点赞", "贝塞尔曲线", "进度"]
        
        array_Dict = [dict_SectionOne, dict_SectionTwo, dict_SectionThree, dict_SectionFour, dict_SectionFive]
    }
    
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return array_Dict.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let array: Array = array_Dict[section]["rowValue"] as? Array<String>{
            return array.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "AnimationCellIdentifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil{
            cell = UITableViewCell.init(style: .default, reuseIdentifier: identifier)
        }
        if let array: Array = array_Dict[indexPath.section]["rowValue"] as? Array<String>{
            cell?.textLabel?.text = array[indexPath.row]
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var vc: YTBaseViewController?
        switch indexPath.section {
        case 0:
            vc = YTBaseAnimationViewController.init(enterType: indexPath.row)
        case 1:
            vc = YTKeyFrameAnimationViewController.init(enterType: indexPath.row)
        case 2:
            vc = YTGroupAnimationViewController.init(enterType: indexPath.row)
        case 3:
            vc = YTTransitionAnimationViewController.init(enterType: indexPath.row)
        case 4:
            let viewControl = YTCombinationAnimationViewController.init(enterType: indexPath.row)
            if let array: Array = array_Dict[indexPath.section]["rowValue"] as? Array<String>{
                viewControl.title = array[indexPath.row]
            }
            navigationController?.pushViewController(viewControl, animated: true)
            break
        default:
            break
        }
        
        if let array: Array = array_Dict[indexPath.section]["rowValue"] as? Array<String>{
            vc?.title = array[indexPath.row]
        }
        guard let viewControl = vc else {return}
        navigationController?.pushViewController(viewControl, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return array_Dict[section]["title"] as? String
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
}

// MARK: UI
extension ViewController{
    
    func initMainView() {
        
        myTableView = UITableView.init(frame: CGRect.zero, style: .grouped)
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.backgroundColor = UIColor.init(red: 180, green: 180, blue: 180, alpha: 1)
        view.addSubview(myTableView)
        
        myTableView.snp.makeConstraints { (make) in
            make.top.equalTo(kNavigationBarHei)
            make.left.right.equalTo(view)
            make.bottom.equalTo(-iPhoneXBottemHei)
        }

        if #available(iOS 11.0, *) {
            myTableView.contentInsetAdjustmentBehavior = .never
        }else{
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
    }
    
}

