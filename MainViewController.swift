//
//  MainViewController.swift
//  Swift2048-001
//
//  Created by gph on 15/1/8.
//  Copyright (c) 2015年 gph. All rights reserved.
//

import UIKit

enum Animation2048Type
{
    case None       //无动画
    case New        //新出现动画
    case Merge      //合并动画
}

class MainViewController:UIViewController
{
    //游戏方格维度
    var dimension:Int = 4
    //游戏过关最大值
    var maxnumber:Int = 2048
    
    //数字格子的宽度
    var width:CGFloat = 50
    //格子与格子的间距
    var padding:CGFloat = 6
    
    //保存背景图数据
    var backgrounds:Array<UIView>
    
    //游戏数据模型
    var gmodel:GameModel!
    
    //保存界面上的数字Label数据
    var tiles: Dictionary<NSIndexPath, TileView>
    
    //保存实际数字值的一个字典
    var tileVals: Dictionary<NSIndexPath, Int>
    
    var score:ScoreView!
    
    var bestscore:BestScoreView!
    
    
    override init() {
        self.backgrounds = Array<UIView>()
        
        var count = self.dimension * self.dimension
        //self.tiles = Array<TileView>(count:count, repeatedValue:0)
        self.tiles = Dictionary()
        self.tileVals = Dictionary()
        
        super.init(nibName: nil, bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupBackground()
        setupButtons()
        setupSwipeGuestures()
        setupScoreLables()
        self.gmodel = GameModel(dimension:self.dimension, score:score , bestscore: bestscore)
        
        for i in 0 ..< 2
        {
            genNumber()
        }
    }
    
    func setupButtons()
    {
        var cv = ControlView()
        var btnreset = cv.createButton("重置", action: Selector("resetTapped"), sender: self)
        btnreset.frame.origin.x = 50
        btnreset.frame.origin.y = 450
        self.view.addSubview(btnreset)
        
        var btngen = cv.createButton("新数", action: Selector("genTapped"), sender: self)
        btngen.frame.origin.x = 170
        btngen.frame.origin.y = 450
        self.view.addSubview(btngen)
    }
    
    func setupScoreLables()
    {
        score = ScoreView()
        score.frame.origin.x = 50
        score.frame.origin.y = 80
        score.changeScore(value: 0)
        self.view.addSubview(score)
        
        bestscore = BestScoreView()
        bestscore.frame.origin.x = 170
        bestscore.frame.origin.y = 80
        bestscore.changeScore(value: 0)
        self.view.addSubview(bestscore)
    }
    
    func setupBackground()
    {
        var x:CGFloat = 30
        var y:CGFloat = 150
        
        for i in 0 ..< dimension
        {
            y = 150
            for j in 0 ..< dimension
            {
                var background = UIView(frame:CGRectMake(x, y, width, width))
                
                background.backgroundColor = UIColor.darkGrayColor()
                
                self.view.addSubview(background)
                backgrounds += backgrounds
                y += padding + width
            }
            x += padding + width
        }
    }
    
    func setupSwipeGuestures()
    {
        let upSwipe = UISwipeGestureRecognizer(target: self, action: Selector("swipeUp"))
        upSwipe.numberOfTouchesRequired = 1
        upSwipe.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(upSwipe)
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: Selector("swipeDown"))
        downSwipe.numberOfTouchesRequired = 1
        downSwipe.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(downSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("swipeLeft"))
        leftSwipe.numberOfTouchesRequired = 1
        leftSwipe.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("swipeRight"))
        rightSwipe.numberOfTouchesRequired = 1
        rightSwipe.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(rightSwipe)
    }
    
    func printTiles(tiles:Array<Int>)
    {
        var count = tiles.count
        for var i=0; i<count; i++
        {
            if (i+1) % Int(dimension) == 0
            {
                println(tiles[i])
            }
            else
            {
                print("\(tiles[i])\t")
            }
            
        }
        println("")
    }
    
    func swipeUp()
    {
        println("swipeUp")
        
        gmodel.reflowUp()
        gmodel.mergeUp()
        gmodel.reflowUp()
        
        printTiles(gmodel.tiles)
        printTiles(gmodel.mtiles)
        
//        resetUI()
        
        initUI()
        
        genNumber()
        
        
        /*for i in 0 ..< dimension
        {
            for j in 0 ..< dimension
            {
                var row:Int = i
                var col:Int = j
                var key = NSIndexPath(forRow: row, inSection: col)
                
                if(tileVals.indexForKey(key) != nil)
                {
                    println("move")
                    //如果行>1 上移一行
                    if(row > 1)
                    {
                        var value = tileVals[key]
                        
                        removeKeyTile(key)
                        
                        var index = row*dimension+col - dimension
                        row = Int(index/dimension)
                        col = index - row*dimension
                        insertTile((row,col), value:value!)
                    }
                }
            }
        }*/
    }
    
    func swipeDown()
    {
        println("swipeDown")
        gmodel.reflowDown()
        gmodel.mergeDown()
        gmodel.reflowDown()
        
        printTiles(gmodel.tiles)
        printTiles(gmodel.mtiles)
        
//        resetUI()
        
        initUI()
        
        genNumber()
    }
    
    func swipeLeft()
    {
        println("swipeLeft")
        gmodel.reflowLeft()
        gmodel.mergeLeft()
        gmodel.reflowLeft()
        
        printTiles(gmodel.tiles)
        printTiles(gmodel.mtiles)
        
//        resetUI()
        
        initUI()
        
        genNumber()
    }
    
    func swipeRight()
    {
        println("swipeRight")
        gmodel.reflowRigth()
        gmodel.mergeRight()
        gmodel.reflowRigth()
        
        printTiles(gmodel.tiles)
        printTiles(gmodel.mtiles)
        
//        resetUI()
        
        initUI()
        
        genNumber()
    }
    
    func removeKeyTile(key:NSIndexPath)
    {
        var tile = tiles[key]!
        var tileVal = tileVals[key]
        
        tile.removeFromSuperview()
        tiles.removeValueForKey(key)
        tileVals.removeValueForKey(key)
        
    }
    
    func resetTapped()
    {
        println("reset")
        resetUI()
        gmodel.initTiles()
    }
    
    func initUI()
    {
        var index:Int
        var key:NSIndexPath
        var tile:TileView
        var tileVal:Int
        
        for i in 0 ..< dimension
        {
            for j in 0 ..< dimension
            {
                index = i*self.dimension + j
                key = NSIndexPath(forRow: i, inSection: j)
                //原来界面没有值，模型数据中有值
                if((gmodel.tiles[index] > 0) && tileVals.indexForKey(key) == nil)
                {
                    insertTile((i,j), value: gmodel.tiles[index], atype: Animation2048Type.Merge)
                }
                //原来界面中有值，现在模型中没有值了
                if((gmodel.tiles[index] == 0) && (tileVals.indexForKey(key) != nil))
                {
                    tile = tiles[key]!
                    tile.removeFromSuperview()
                
                    tiles.removeValueForKey(key)
                    tileVals.removeValueForKey(key)
                }
                //原来有值，但是现在还有值
                if((gmodel.tiles[index] > 0) && (tileVals.indexForKey(key) != nil))
                {
                    tileVal = tileVals[key]!
                    if(tileVal != gmodel.tiles[index])
                    {
                        tile = tiles[key]!
                        tile.removeFromSuperview()
 
                        tiles.removeValueForKey(key)
                        tileVals.removeValueForKey(key)
                        insertTile((i,j), value: gmodel.tiles[index], atype: Animation2048Type.Merge)

                    }
                }
            }
        }
    }
    
    func resetUI()
    {
        for(key, tile) in tiles
        {
            tile.removeFromSuperview()
        }
        tiles.removeAll(keepCapacity: true)
        tileVals.removeAll(keepCapacity: true)
        
        score.changeScore(value: 0)
    }
    
    func genTapped()
    {
        println("genTapped")
        genNumber()
    }
    
    func genNumber()
    {
        let randv = Int(arc4random_uniform(10))
        println(randv)
        var seed:Int = 2
        if(randv == 1)
        {
            seed = 4
        }
        let col = Int(arc4random_uniform(UInt32(dimension)))
        let row = Int(arc4random_uniform(UInt32(dimension)))
        
        if(gmodel.isFull())
        {
            println("位置已经满了")
            return
        }
        if(gmodel.setPosition(row, col: col, value: seed)==false)
        {
            genNumber()
            return
        }
        
        insertTile((row, col), value:seed, atype: Animation2048Type.New)
    }
    
    func insertTile(pos:(Int, Int),value:Int, atype:Animation2048Type)
    {
        let (row, col) = pos;
        
        let x = 30 + CGFloat(col) * (width + padding)
        let y = 150 + CGFloat(row) * (width + padding)
        
        let tile = TileView(pos: CGPointMake(x, y), width: width, value: value)
        self.view.addSubview(tile)
        self.view.bringSubviewToFront(tile)
        
        var index = NSIndexPath(forRow: row, inSection: col)
        tiles[index] = tile
        tileVals[index] = value
        
        if(atype == Animation2048Type.None)
        {
            return
        }
        else if(atype == Animation2048Type.New)
        {
            tile.layer.setAffineTransform(CGAffineTransformMakeScale(0.1, 0.1))
        }
        else if(atype == Animation2048Type.Merge)
        {
            tile.layer.setAffineTransform(CGAffineTransformMakeScale(0.8, 0.8))
        }
        
        UIView.animateWithDuration(0.3, delay: 0.1, options: UIViewAnimationOptions.TransitionNone, animations:
            {
                () -> Void in
                    tile.layer.setAffineTransform(CGAffineTransformMakeScale(1, 1))
            },
            completion: {
                (finished:Bool) -> Void in
                UIView.animateWithDuration(0.08, animations: {
                    () -> Void in
                    tile.layer.setAffineTransform(CGAffineTransformIdentity)
                })
            })
    }
}

