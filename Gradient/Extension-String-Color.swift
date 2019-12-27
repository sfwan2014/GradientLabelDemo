//
//  Extension-String-Color.swift
//  GradientLabelDemo
//
//  Created by tezwez on 2019/12/27.
//  Copyright © 2019 tezwez. All rights reserved.
//

import Foundation
import UIKit
//MARK: 第一种方式是给String添加扩展
extension String {
    // MARK: - 将十六进制颜色转换为UIColor
    public func uiColor() -> UIColor {
        
        var hexColorString = self
        
        if hexColorString.contains("#") {
            hexColorString = hexColorString[1..<7]
        }
        
        // 存储转换后的数值
        var red:UInt32 = 0, green:UInt32 = 0, blue:UInt32 = 0
        
        // 分别转换进行转换
        Scanner(string: hexColorString[0..<2]).scanHexInt32(&red)
        
        Scanner(string: hexColorString[2..<4]).scanHexInt32(&green)
        
        Scanner(string: hexColorString[4..<6]).scanHexInt32(&blue)
        
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1.0)
    }
    
}

//MARK: 两种方式都需要用到的扩展

extension String {
    
    // MARK: - String使用下标截取字符串， 例: "示例字符串"[0..<2] 结果是 "示例"
    public subscript (r: Range<Int>) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            
            return String(self[startIndex..<endIndex])
        }
    }
}
