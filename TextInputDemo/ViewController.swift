//
//  ViewController.swift
//  TextInputDemo
//
//  Created by 壹九科技1 on 2020/3/26.
//  Copyright © 2020 YJKJ. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    var switcher: UISwitch = UISwitch()
    var aInputView: PasswordInputView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switcher.frame = CGRect(x: 30, y: 300, width: 50, height: 30)
        view.addSubview(switcher)
        
        switcher.addTarget(self, action: #selector(switchChangeValue), for: .valueChanged)
        
        var style = PasswordInputViewStyle()
        style.securityInput = false
        
        aInputView = PasswordInputView(style)
        aInputView.frame = CGRect(x: 100, y: 100, width: 200, height: 50)
        aInputView.backgroundColor = .white
        view.addSubview(aInputView)
        
        aInputView.didFilledIn = {
            print($0)
        }

    }
    
    @objc
    func switchChangeValue() {
        aInputView.style.securityInput = switcher.isOn
    }


}

