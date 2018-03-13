//
//  ChannelViewController.swift
//  Smack
//
//  Created by Henry Chukwu on 3/1/18.
//  Copyright © 2018 Henry Chukwu. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController {

    // Outlets
    @IBOutlet weak var loginButton: UIButton!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {}

    @IBOutlet weak var userImage: CircleImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ChannelViewController.userDataDidChange(_:)),
                                               name: NOTIF_USER_DATA_DID_CHANGE, object: nil)

    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }

    @objc func userDataDidChange(_ notif: Notification) {
        if AuthService.instance.isLoggedIn {
            loginButton.setTitle(UserDataService.instance.name, for: .normal)
            userImage.image = UIImage(named: UserDataService.instance.avatarName)
            userImage.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        } else {
            loginButton.setTitle("Login", for: .normal)
            userImage.image = UIImage(named: "menuProfileIcon")
            userImage.backgroundColor = UIColor.clear
        }
    }
}
