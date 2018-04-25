//
//  AddChannelViewController.swift
//  Smack
//
//  Created by Henry Chukwu on 3/14/18.
//  Copyright © 2018 Henry Chukwu. All rights reserved.
//

import UIKit

class AddChannelViewController: UIViewController {

    // Outlets
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var descriptionText: UITextField!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()

    }

    @IBAction func createChannelPressed(_ sender: Any) {
        guard let channelName = nameText.text,   nameText.text != "" else { return }
        guard let channelDescription = descriptionText.text else { return }
        SocketService.instance.addChannel(channelName: channelName, channelDescription: channelDescription) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }


    @IBAction func closeModalPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    func setUpView() {
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelViewController.closeTapp(_:)))
        bgView.addGestureRecognizer(closeTouch)

        nameText.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
        descriptionText.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
    }

    @objc func closeTapp(_ recogniser: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }


}
