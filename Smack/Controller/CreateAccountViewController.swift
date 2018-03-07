//
//  CreateAccountViewController.swift
//  Smack
//
//  Created by Henry Chukwu on 3/2/18.
//  Copyright © 2018 Henry Chukwu. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    // Outlets
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var userImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func createAccountButtonPressed(_ sender: Any) {
        guard let email = emailText.text, emailText.text != ""
            else { return }
        guard let password = passwordText.text, passwordText.text != ""
            else { return }

        AuthService.instance.registerUser(email: email, password: password) { (success) in
            if success {
                AuthService.instance.loginUser(email: email, password: password, completion: { (success) in
                    if success {
                        print("logged in user!",
                              AuthService.instance.authToken)
                    }
                })
            }
        }
    }

    @IBAction func pickAvatarButtonPressed(_ sender: Any) {

    }

    @IBAction func pickBGButtonPressed(_ sender: Any) {

    }

    @IBAction func closeButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }

}
