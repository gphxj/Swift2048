//
//  ViewController.swift
//  Swift2048-001
//
//  Created by gph on 15/1/8.
//  Copyright (c) 2015年 gph. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startGame(sender:UIButton)
    {
        let alertView = UIAlertView()
        alertView.title = "开始！"
        alertView.message = "游戏就要开始，你准备好了吗？"
        alertView.addButtonWithTitle("Ready Go!")
        alertView.show()
        alertView.delegate = self
    }
    
    func alertView(alertView:UIAlertView,clickedButtonAtIndex buttonIndex:Int){
        self.presentViewController(MainTabViewController(), animated: true, completion: nil)
    }
}

