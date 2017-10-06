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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func createAccPressed(_ sender: Any) {
        guard let email = emailText.text, emailText.text != "" else { return }
        guard let pass = passwordText.text, passwordText.text != "" else { return }
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                print("registered user")
            }
        }
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
        
    }
    
    @IBAction func pickBgColorPressed(_ sender: Any) {
        
    }
    
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND_TO_CHANNEL_VC, sender: nil)
    }
}
