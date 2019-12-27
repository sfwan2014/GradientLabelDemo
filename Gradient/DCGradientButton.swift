//
//  DCGradientButton.swift
//  DigitalClub
//
//  Created by tezwez on 2019/9/5.
//  Copyright © 2019 xun.liu. All rights reserved.
//

import Foundation

/// 标题渐变色的按钮
class DCGradientButton: UIControl{
    
    var normalTitleColors:[UIColor] = [UIColor.white]{
        didSet{
            titleLabel.colors = normalTitleColors
            selectedTitleColors = normalTitleColors
            
        }
    }
    
    var selectedTitleColors:[UIColor] = [UIColor.white]{
        didSet{
            highlightTitleColors = selectedTitleColors
        }
    }
    
    var highlightTitleColors:[UIColor] = [UIColor.white]
    
    var direct: GradientType = .Horizontal{
        didSet{
            titleLabel.direct = direct
        }
    }
    
    open override var isSelected: Bool{
        didSet{
            if isSelected {
                titleLabel.text = selectedTitle
                titleLabel.colors = selectedTitleColors
                
            } else {
                titleLabel.text = normalTitle
                titleLabel.colors = normalTitleColors
            }
        }
    }
    
    
    lazy var titleLabel: DCGradientLabel = {
        let label = DCGradientLabel.init(frame: .zero)
        label.textAlignment = .center
        label.font = UIFont.init(name: pingFangRegular, size: 16)
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView(){
        self.addSubview(titleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = self.bounds
    }
    
    var selectedTitle: String?
    var normalTitle: String?
    func setTitle(_ title: String?, state: UIControl.State){
        switch state {
        case .normal:
            normalTitle = title
            if selectedTitle == nil{
                selectedTitle = title
            }
            titleLabel.text = title
            break
        case .selected:
            selectedTitle = title
        default:
            break
        }
        
        if self.isSelected {
            titleLabel.text = selectedTitle
            titleLabel.colors = selectedTitleColors
        } else{
            titleLabel.text = normalTitle
            titleLabel.colors = normalTitleColors
        }
    }
}

extension DCGradientButton{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.titleLabel.colors = highlightTitleColors
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isSelected {
            titleLabel.colors = selectedTitleColors
        } else{
            titleLabel.colors = normalTitleColors
        }
        self.sendActions(for: .touchUpInside)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isSelected {
            titleLabel.colors = selectedTitleColors
        } else{
            titleLabel.colors = normalTitleColors
        }
        
    }
}
