//
//  MainTabViewController.swift
//  Swift2048-001
//
//  Created by gph on 15/1/8.
//  Copyright (c) 2015年 gph. All rights reserved.
//

import UIKit

class MainTabViewController:UITabBarController
{
    override init()
    {
        super.init(nibName: nil, bundle: nil)
        
        var viewMain = MainViewController()
        
        viewMain.title = "2048"
        
        var viewSetting = SettingViewController()
        
        viewSetting.title = "设置"
        
        var main = UINavigationController(rootViewController: viewMain)
        var setting = UINavigationController(rootViewController: viewSetting)
        
        self.viewControllers = [
            main, setting
        ]
        
        self.selectedIndex = 0
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
