//
//  PasswordInputViewStyle.swift
//  TextInputDemo
//
//  Created by 壹九科技1 on 2020/3/27.
//  Copyright © 2020 YJKJ. All rights reserved.
//

import UIKit

struct PasswordInputViewStyle {
    var borderColor: UIColor?
    var lineColor: UIColor?
    var securityInput: Bool?
    var borderWidth: CGFloat?
    var gridCount: Int!
    var dotRadius: CGFloat!
    
    init(borderColor: UIColor? = .black, borderWidth: CGFloat? = 1, lineColor: UIColor? = .black, securityInput: Bool? = true, gridCount: Int? = 6, dotRadius: CGFloat? = 4) {
        self.borderColor = borderColor
        self.lineColor = lineColor
        self.securityInput = securityInput
        self.borderWidth = borderWidth
        self.gridCount = gridCount
        self.dotRadius = dotRadius
        
    }
}
