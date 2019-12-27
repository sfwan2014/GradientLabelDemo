//
//  ViewController.swift
//  GradientLabelDemo
//
//  Created by tezwez on 2019/12/27.
//  Copyright © 2019 tezwez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: DCGradientLabel!
    
    @IBOutlet weak var contentLabel: DCGradientLabel!
    
    
    @IBOutlet weak var text2: DCGradientLabel!
    
    @IBOutlet weak var btn: DCGradientButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        titleLabel.text = "渐变色标题-渐变色标题-渐变色标题"
        titleLabel.colors = [.red, .green]
        titleLabel.textAlignment = .right
        
        contentLabel.text = "渐变色内容"
        contentLabel.font = UIFont.systemFont(ofSize: 38)
        contentLabel.colors = [ .blue, .yellow, .cyan]
        contentLabel.direct = .Vertical
        
        text2.text = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        text2.textAlignment = .center
        text2.font = UIFont.systemFont(ofSize: 20)
        text2.colors = [.red, .green, .yellow, .purple]
        
        btn.setTitle("点击事件", state: .normal)
        btn.normalTitleColors = [.green, .magenta, .orange]
        
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.magenta.cgColor
        btn.layer.cornerRadius = 4
        btn.layer.masksToBounds = true
    }


}

