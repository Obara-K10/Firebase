//
//  HomeController.swift
//  Register
//
//  Created by sendy on 13/08/2019.
//  Copyright © 2019 sendy. All rights reserved.
//

import UIKit
import Firebase

class HomeController : UIViewController {
    //App's properties
    
    var homeLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .orange
        label.font = UIFont.systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.alpha = 0
        
        return label
    }()

    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        authenticateUserAndConfigureView ()
    }
    
    //Handling signOut
    @objc func handleSignOut(){
        let alertController = UIAlertController(title: nil, message: "Do you really want to sign out?", preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Sign Out", style:.destructive, handler: {(_) in self.signOut ()}))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    
       present(alertController, animated: true, completion: nil)
        
        
    }
    
    //authentication and configuration API
    
    func loadUserData(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Database.database().reference().child("username").observeSingleEvent (of: .value) {
            (snapshot) in
            guard let username = snapshot.value as? String else {return}
            
            self.welcomeLabel.text = "You are welcome, \(username)"
            
            UIView.animate(withDuration: 0.7, animations: {self.welcomeLabel.alpha = 1
                
            })
        }
    }
    
    func signOut(){
        do{
            try Auth.auth().signOut()
            let navController = UINavigationController (rootViewController: LoginController())
            navController.navigationBar.barStyle = .black
            self.present(navController, animated: true, completion: nil)
        } catch let error{
            print ("Failed to sign out user", error)
        }
        
    }
    
    func authenticateUserAndConfigureView (){
       if  Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let navController = UINavigationController (rootViewController: LoginController())
                navController.navigationBar.barStyle = .black
                self.present(navController, animated: true, completion: nil)
            }
       }else{
            configureViewComponents()
            loadUserData()
        }
    }
    
    func configureViewComponents() {
        view.backgroundColor = UIColor.mainBlue()
        navigationItem.title = "Our Login"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image:#imageLiteral(resourceName: "back5") , style:.plain, target: self, action: #selector (handleSignOut))
        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationController?.navigationBar.barTintColor = UIColor.orange
        
        view.addSubview(homeLabel)
        homeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        homeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
