//
//  RoundButton.swift
//  Calculator
//
//  Created by Abigail Chin on 2/23/18.
//  Copyright © 2018 Abigail Chin. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class RoundButton: UIButton{
    @IBInspectable var roundButton:Bool = false {
        didSet {
            if roundButton {
                layer.cornerRadius = frame.height / 2
            }
        }
    }
    
    override func prepareForInterfaceBuilder() {
        if roundButton {
            layer.cornerRadius = frame.height / 2


        }
    }
    
}
