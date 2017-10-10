//
//  SquareCornerTextField.swift
//  smack-app
//
//  Created by Jess Rascal on 10/10/2017.
//  Copyright © 2017 jessrascal. All rights reserved.
//

import UIKit

@IBDesignable
class SquareCornerTextField: UITextField {
    
    let padding = UIEdgeInsetsMake(0, 10, 0, 10)
    
    override var isEnabled: Bool {
        willSet(newIsEnabled) {
            backgroundColor = newIsEnabled ? UIColor.white : #colorLiteral(red: 0.9019607843, green: 0.9137254902, blue: 0.9294117647, alpha: 1)
            layer.borderWidth = newIsEnabled ? 0.5 : 0
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func awakeFromNib() {
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    func setupView() {
        borderStyle = .none
    }
    
}
