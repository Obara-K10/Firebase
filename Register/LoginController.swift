//
//  LoginController.swift
//  Register
//
//  Created by sendy on 13/08/2019.
//  Copyright © 2019 sendy. All rights reserved.
//

import UIKit
import TinyConstraints
import Firebase

class LoginController: UIViewController, UITextViewDelegate {
    
    // logincontroller properties
    let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "sendy")
        return iv
    }()
    
    lazy var emailContainerView: UIView = {
        let view = UIView()
        return view.textContainerView (view: view, image: #imageLiteral(resourceName: "email1"), textField: emailTextField)
    }()
    
    lazy var passwordContainerView: UIView = {
        let view = UIView()
        return view.textContainerView (view: view,image: #imageLiteral(resourceName: "Image.png"), textField: passwordTextField)
    }()
    
    lazy var emailTextField: UITextField = {
        let tfield = UITextField()
        tfield.placeholder = "Email"
        return tfield
    }()
    
    lazy var passwordTextField: UITextField = {
        let tfield = UITextField()
        tfield.placeholder = "Password"
        return tfield
    }()
    
    //the login button
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(UIColor.mainBlue(), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    //the dont have an account button
    let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account?", attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor.white])
        attributedTitle.append(NSAttributedString(string: " Sign Up", attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor.white]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        
        
        return button
    }()
    
    
    //App initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents ()
        
    }
    
        //App's selectors
    @objc func handleLogin(){
        guard let email = emailTextField.text else{return}
        guard let password = passwordTextField.text else{return}
        
        //calling the loginUser function
        logUserIn(withEmail: email, password: password)
        }
        
    @objc func handleShowSignUp(){
            navigationController?.pushViewController(SignUpController(), animated: true)
        }
    
    func logUserIn (withEmail email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            //handling error
            if let error = error{
                print ("user was not logged in...", error.localizedDescription)
                return
            }
            
            guard let navController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController else {return}
            
            guard let controller = navController.viewControllers[0]as? HomeController else {return}
            
            controller.configureViewComponents()
            
            self.dismiss(animated: true, completion: nil)
                
            }
    }
    
    //validating the email
    func isValidEmail(email:String?) -> Bool {
        
        guard email != nil else { return false }
        
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: email)
    }
    
    //validating the password
    func isValidPassword(testStr:String?) -> Bool {
        guard testStr != nil else { return false }
        
    
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        return passwordTest.evaluate(with: testStr)
    }
    
        //the helper functions and app constraints
        func configureViewComponents (){
            view.backgroundColor = UIColor.lightGray
            navigationController?.navigationBar.isHidden = true
            
            view.addSubview(logoImageView)
            logoImageView.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 60, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 150, height: 150)
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            
            view.addSubview(emailContainerView)
            emailContainerView.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 24, paddingLeft: 32, paddingBottom: 0, paddingRight: -32, width: 0, height: 50)
            //emailContainerView.leftToSuperview(offset: 15,usingSafeArea: true)
            //emailContainerView.rightToSuperview(offset: -15,usingSafeArea: true)
            
            view.addSubview(passwordContainerView)
            passwordContainerView.anchor(top: emailContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 16, paddingLeft: 32, paddingBottom: 0, paddingRight: -32, width: 0, height: 50)
            
            view.addSubview(loginButton)
            loginButton.anchor(top: passwordContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 24, paddingLeft: 90, paddingBottom: 0, paddingRight: -90, width: 0, height: 50)
            
            view.addSubview(dontHaveAccountButton)
            dontHaveAccountButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 32, paddingBottom: 12, paddingRight: -32, width: 0, height: 50)
        
    }
}

