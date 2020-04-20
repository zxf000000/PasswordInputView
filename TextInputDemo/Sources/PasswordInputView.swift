//
//  InputView.swift
//  TextInputDemo
//
//  Created by 壹九科技1 on 2020/3/26.
//  Copyright © 2020 YJKJ. All rights reserved.
//

import UIKit


typealias PasswordInputViewDidFilledIn = ((String) -> Void)

class PasswordInputView: UIView,UITextInputTraits {
    
    open var string: String = ""
    
    open var didFilledIn: PasswordInputViewDidFilledIn?
    
    private var didLayout: Bool = false
    
    var style: PasswordInputViewStyle = PasswordInputViewStyle()
    
    private var dotLayers: [CAShapeLayer] = [CAShapeLayer]()
    private var labels: [UILabel] = [UILabel]()
    
    private var indicator: UIView!
    
    private var displayLink: CADisplayLink!
    
    var keyboardType: UIKeyboardType = .numberPad
        
    
    convenience init(_ style: PasswordInputViewStyle) {
        
        self.init(frame: .zero)
             
        self.style = style
        setupUI()

    }
    
    public func setupPassword(_ password: String) {
        if password.count > 6 {
            return
        }
        for (index, _) in string.enumerated() {
            if index < dotLayers.count {
                dotLayers[index].isHidden = false
            }
        }
        string = password
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if didLayout {
            return
        }
        
        // 绘制中间的分割线
        let singleGridWidth = bounds.size.width / CGFloat(style.gridCount)
        for i in 1...style.gridCount {
            let x = singleGridWidth * CGFloat(i)
            let lineLayer = CAShapeLayer()
            let path = UIBezierPath()
            path.move(to: CGPoint(x: x, y: 0))
            path.addLine(to: CGPoint(x: x, y: bounds.size.height))
            lineLayer.lineWidth = style.borderWidth ?? 1
            lineLayer.strokeColor = style.lineColor?.cgColor
            lineLayer.path = path.cgPath
            layer.addSublayer(lineLayer)
            
//            if style.securityInput == true {
                let dotLayer = CAShapeLayer()
                dotLayer.fillColor = UIColor.black.cgColor
                dotLayer.opacity = 0
                let dotPath = UIBezierPath()
                dotPath.addArc(withCenter: CGPoint(x: x - singleGridWidth / 2, y: bounds.size.height/2), radius: style.dotRadius, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
                dotLayer.path = dotPath.cgPath
                dotLayers.append(dotLayer)
                layer.addSublayer(dotLayer)
//            } else {
                let label = UILabel()
                label.frame = CGRect(x: CGFloat(i - 1)*singleGridWidth, y: 0, width: singleGridWidth, height: bounds.size.height)
                label.textColor = .black
                label.font = UIFont.systemFont(ofSize: 16)
                label.isHidden = true
                label.textAlignment = .center
                addSubview(label)
                labels.append(label)
//            }
        }
        didLayout = true
    }
    
    func setupUI() {
        backgroundColor = .white
        layer.borderColor = style.borderColor?.cgColor
        layer.borderWidth = style.borderWidth ?? 1
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.becomeFirstResponder()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension PasswordInputView: UIKeyInput {
    var hasText: Bool {
        return string.lengthOfBytes(using: .utf8) > 0
    }
    
    func insertText(_ text: String) {
        insetText(text)
    }
    
    func deleteBackward() {
        if string.lengthOfBytes(using: .utf8) <= 0 {
            return
        }
        string.removeLast()
        let index = string.lengthOfBytes(using: .utf8)
        if style.securityInput == true {
            dotLayers[index].opacity = 0
        } else {
            labels[index].text = ""
            labels[index].isHidden = true
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    private func insetText(_ text: String) {
        if string.lengthOfBytes(using: .utf8) >= style.gridCount {
            return
        }
        let regex = "[0-9]"
        let predicate = NSPredicate(format: "self matches %@",regex)
        if predicate.evaluate(with: text) {
            // 是数字,可以拼接
            string.append(text)
            // 显示
            drawDot(atIndex: string.lengthOfBytes(using: .utf8) - 1, text: text)
        } else {
            
            return
        }
    }
    
    private func drawDot(atIndex index: Int, text: String) {
        didFilledIn?(text)
        if style.securityInput == true {
            dotLayers[index].opacity = 1
        } else {
            labels[index].text = text
            labels[index].isHidden = false
        }
    }
    
}

