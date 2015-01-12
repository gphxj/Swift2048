//
//  ScoreView.swift
//  Swift2048-001
//
//  Created by gph on 15/1/12.
//  Copyright (c) 2015年 gph. All rights reserved.
//

import UIKit

protocol ScoreViewProtocol{
    func changeScore(value s:Int)
}

class ScoreView:UIView
{
    var label:UILabel
    
    let defaultFrame = CGRectMake(0, 0, 100, 30)
    
    var score:Int = 0{
        didSet{
            label.text = "分数：\(score)"
        }
    }
    
    override init()
    {
        label = UILabel(frame: defaultFrame)
        label.textAlignment = NSTextAlignment.Center
        
        super.init(frame:defaultFrame)
        
        backgroundColor = UIColor.orangeColor()
        label.font = UIFont(name: "微软雅黑", size: 16)
        label.textColor = UIColor.whiteColor()
        self.addSubview(label)
    }
    
    func scoreChanged(Value s:Int)
    {
        score = s
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BestScoreView:ScoreView, ScoreViewProtocol
{
    var bestscore:Int = 0{
        didSet{
            label.text = "最高分：\(bestscore)"
        }
    }
    
    func changeScore(value s: Int)
    {
        bestscore = s
    }
}