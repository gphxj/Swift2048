//
//  GameModel.swift
//  Swift2048-001
//
//  Created by gph on 15/1/9.
//  Copyright (c) 2015年 gph. All rights reserved.
//

import Foundation

class GameModel
{
    var dimension:Int = 0
    
    //4*4 =16
    
    var tiles:Array<Int>
    
    init(dimension:Int)
    {
        self.dimension = dimension
        self.tiles = Array<Int>(count:self.dimension * self.dimension, repeatedValue:0)
        
        initTiles()
    }
    
    func initTiles()
    {
        self.tiles = Array<Int>(count:self.dimension * self.dimension, repeatedValue:0)
    }
    //如果返回false，表示该位置已经有值
    func setPosition(row:Int, col:Int, value:Int) -> Bool
    {
        assert(row >= 0 && row < dimension)
        assert(col >= 0 && col < dimension)
        
        //3行4列，即 row=2，col=3， index=2*4+3=11
        //4行4列，即 3*4+3=15
        var index = self.dimension * row + col
        var val = tiles[index]
        if(val > 0)
        {
            println("该位置已经有值了")
            return false
        }
        tiles[index] = value
        return true
    }
    
    func emptyPositions() -> [Int]
    {
        var emptytiles = Array<Int>()
        //var index:Int
        for i in 0..<(dimension * dimension)
        {
            if(tiles[i] == 0)
            {
                emptytiles += [i]
            }
        }
        return emptytiles
    }
    
    func isFull()-> Bool
    {
        if(emptyPositions().count == 0)
        {
            return true
        }
        return false
    }
}