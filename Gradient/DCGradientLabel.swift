//
//  DCGradientLabel.swift
//  DigitalClub
//
//  Created by tezwez on 2019/9/5.
//  Copyright © 2019 xun.liu. All rights reserved.
//

import Foundation

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
        self.addSubview(label)
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
        
        label.frame = self.bounds
        gradientLayer.frame = label.frame
        self.layer.addSublayer(gradientLayer)

        gradientLayer.mask = label.layer
    }
    
    
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
}

extension DCGradientLabel{
    
    

}
