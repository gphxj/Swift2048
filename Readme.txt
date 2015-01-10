Swith2048学习记录
2015.1.9

区间运算符分为闭区间 (...) 和左闭右开区间 (..<) 两种，前者是算头算尾，后者是算头不算尾。
区间运算符 “..<”  取代原先 “..”

在如下函数中

func emptyPositions() -> [Int]
{
    var emptytiles = Array<Int>()
    //var index:Int
    for i in 0..<(dimension * dimension)
    {
        if(tiles[i] == 0)
        {
            //emptytiles += i     提示错误：'Array<Int>' is not identical to 'UInt8'
            //将 i 修改为 [i] 后错误消失 ？？？
            emptytiles += [i]

        }
    }
    return emptytiles
}

2015.1.10

button.titleLabel.textColor = UIColor.whiteColor()        //提示错误： 'UILabel?' does not have a member named 'textColor'

button.titleLabel.font = UIFont.systemFontOfSize(14)      //提示错误： 'UILabel?' does not have a member named 'textColor'

//修改为如下代码后错误消失 ？？？
button.titleLabel?.textColor = UIColor.whiteColor()
button.titleLabel?.font = UIFont.systemFontOfSize(14)
