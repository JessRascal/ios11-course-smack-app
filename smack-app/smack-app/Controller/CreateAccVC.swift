//
//  CreateAccVC.swift
//  smack-app
//
//  Created by Jess Rascal on 05/10/2017.
//  Copyright © 2017 jessrascal. All rights reserved.
//

import UIKit

class CreateAccVC: UIViewController {
    
    
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var avatarName = "smackProfileIcon"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    var bgColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
        }
        if avatarName.contains("light") && bgColor == nil {
            userImg.backgroundColor = UIColor.lightGray
        }
    }
    
    @IBAction func createAccPressed(_ sender: Any) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        guard let name = usernameText.text, usernameText.text != "" else { return }
        guard let email = emailText.text, emailText.text != "" else { return }
        guard let pass = passwordText.text, passwordText.text != "" else { return }
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                AuthService.instance.loginUser(email: email, password: pass, completion: { (success) in
                    if success {
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success {
                                self.activityIndicator.isHidden = true
                                self.activityIndicator.stopAnimating()
                                self.performSegue(withIdentifier: UNWIND_TO_CHANNEL_VC, sender: nil)
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                            }
                        })
                    }
                })
            }
        }
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER_VC, sender: nil)
    }
    
    @IBAction func pickBgColorPressed(_ sender: Any) {
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        UIView.animate(withDuration: 0.2) {
            self.userImg.backgroundColor = self.bgColor
        }
    }
    
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND_TO_CHANNEL_VC, sender: nil)
    }
    
    func setupView() {
        activityIndicator.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccVC.handleTap))
        view.addGestureRecognizer(tap)
        
        usernameText.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor: SMACK_PURPLE_PLACEHOLDER])
        emailText.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedStringKey.foregroundColor: SMACK_PURPLE_PLACEHOLDER])
        passwordText.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: SMACK_PURPLE_PLACEHOLDER])
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
}
