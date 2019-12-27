//
//  DCGradientLabel.swift
//  DigitalClub
//
//  Created by tezwez on 2019/9/5.
//  Copyright © 2019 xun.liu. All rights reserved.
//

import Foundation
import UIKit

enum GradientType {
    case Horizontal
    case Vertical
}

class DCGradientLabel: UIView {
    
    
    lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
    
    lazy var gradientLayer: CAGradientLayer = {

        return CAGradientLayer()
    }()
    
    //MARK: Setter
    var text: String?{
        didSet{
            self.label.text = text
            setNeedsLayout()
        }
    }
    
    var attributedText: NSAttributedString?{
        didSet{
            self.label.attributedText = attributedText
            setNeedsLayout()
        }
    }
    
    var font: UIFont? {
        didSet{
            self.label.font = font
            setNeedsLayout()
        }
    }
    
    var textAlignment: NSTextAlignment = .left{
        didSet{
            self.label.textAlignment = textAlignment
            setNeedsLayout()
        }
    }
    
    var colors: [UIColor] = ["#0A72B8".uiColor(), "#123183".uiColor()] {
        didSet {
//            gradientLayer.colors = colors.compactMap{
//                return $0.cgColor
//            }
            self.setNeedsLayout()
        }
    }
    
    var direct: GradientType = .Horizontal{
        didSet{
            self.setNeedsLayout()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        self.addSubview(label)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        switch direct{
        case .Horizontal:
            gradientLayer.startPoint = CGPoint(x: 0, y: 1)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
            break
        default:
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
            break
        }
        
        gradientLayer.colors = colors.compactMap{
            return $0.cgColor
        }
        
        let text = label.text ?? ""
        let txtWidth = getLabWidth(labelStr: text, font: label.font, height: 1000)
        let txtHeight = getLabHeight(labelStr: text, font: label.font, width: self.bounds.size.width)
        let width = min(txtWidth, self.bounds.size.width)
        let height = min(txtHeight, self.bounds.size.height)
        
        // 默认 center
        var frame = CGRect(x: (self.bounds.size.width-width)/2, y: (self.bounds.size.height-height)/2, width: width, height: height)
        if textAlignment == .left {
            frame = CGRect(x: 0, y: (self.bounds.size.height-height)/2, width: width, height: height)
        } else if textAlignment == .right{
            frame = CGRect(x: self.bounds.size.width-width, y: (self.bounds.size.height-height)/2, width: width, height: height)
        }
        
        // label.layer 作为 gradientLayer 的子layer
        // 设置label.layer的frame 需以 gradientLayer 作为参考
        gradientLayer.frame = frame
        label.layer.frame = gradientLayer.bounds
        
        self.layer.addSublayer(gradientLayer)

        gradientLayer.mask = label.layer
    }
    
    
    
}

extension DCGradientLabel{
    
    //获取字符串Label宽度
    func getLabWidth(labelStr: String, font: UIFont, height:CGFloat) -> CGFloat {
        let statusLabelText: NSString = labelStr as NSString
        let size = CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: height)
        let dic = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key : Any], context: nil).size
        return strSize.width
    }
    //获取字符串Label高度
    func getLabHeight(labelStr: String, font: UIFont, width:CGFloat) -> CGFloat {
        let statusLabelText: NSString = labelStr as NSString
        let size = CGSize.init(width: width, height: CGFloat.greatestFiniteMagnitude)
        let dic = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key : Any], context: nil).size
        return strSize.height
    }

}
