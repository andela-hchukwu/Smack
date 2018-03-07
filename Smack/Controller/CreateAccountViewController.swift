//
//  CreateAccountViewController.swift
//  Smack
//
//  Created by Henry Chukwu on 3/2/18.
//  Copyright © 2018 Henry Chukwu. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func closeButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }

}
