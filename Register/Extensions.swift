//
//  Extensions.swift
//  Register
//
//  Created by sendy on 13/08/2019.
//  Copyright © 2019 sendy. All rights reserved.
//

import UIKit

extension UIView{
    func anchor (top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top{
            
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left{
            
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom{
            
            self.bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        if let right = right{
            
            self.rightAnchor.constraint(equalTo: right, constant: paddingRight).isActive = true
        }
        if width != 0 {
            
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func textContainerView(view: UIView, image: UIImage, textField: UITextField) -> UIView {
        view.backgroundColor = .clear
        
        let imageView = UIImageView()
        imageView.image = image
        imageView.alpha = 0.9
        view.addSubview(imageView)
        imageView.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 24, height: 24)
        imageView.centerYAnchor.constraint(equalTo:view.centerYAnchor).isActive = true
        view.addSubview(textField)
        textField.anchor(top: nil, left: imageView.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        textField.centerYAnchor.constraint(equalTo:imageView.centerYAnchor).isActive = true
        //email,password/username seperator
        let  seperatorView = UIView()
        seperatorView.backgroundColor = UIColor(white: 2, alpha: 1)
        view.addSubview(seperatorView)
        seperatorView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.8)
        return view
        
    }
    
}

//UIColor extension
extension UIColor {
    static func rgb (red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor (red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    static func mainBlue() -> UIColor{
        return UIColor.rgb(red: 0, green: 150, blue: 255)
    }
}

//UITextField extension
extension UITextField {
    func textField(withPlaceholder: String, isSecureTextEntry: Bool) -> UITextField {
        let tfield = UITextField()
        tfield.borderStyle = .none
        tfield.font = UIFont.systemFont(ofSize: 15)
        tfield.textColor = .orange
        tfield.isSecureTextEntry = isSecureTextEntry
        tfield.attributedPlaceholder = NSAttributedString(string: "placeholder", attributes:[NSAttributedString.Key.foregroundColor: UIColor.white] )
    return tfield
    }
}

