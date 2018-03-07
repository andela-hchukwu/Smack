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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60

    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
}
