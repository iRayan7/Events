//
//  EventViewDesign.swift
//  Events
//
//  Created by Rayan Aldafas on 23/05/2018.
//  Copyright © 2018 RayanAldafas. All rights reserved.
//

import UIKit

@IBDesignable class EventViewDesign: UIView {

        // cell shadow
        @IBInspectable var cornerRadius : CGFloat = 0
        @IBInspectable var shadowColor : UIColor? = UIColor.black
        @IBInspectable var shadowOffSetWidth : Int = 0
        @IBInspectable var shadowOffSetHeight : Int = 1
        @IBInspectable var shadowOpacity : Float = 0.2
        
        
        override func layoutSubviews() {

            layer.cornerRadius = cornerRadius
            layer.shadowColor = shadowColor?.cgColor
            layer.shadowOffset = CGSize(width: shadowOffSetWidth, height: shadowOffSetHeight)
            let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
            
            layer.shadowPath = shadowPath.cgPath
            
            layer.shadowOpacity = shadowOpacity
            

        }
    }


