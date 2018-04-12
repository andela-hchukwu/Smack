//
//  ChatViewController.swift
//  Smack
//
//  Created by Henry Chukwu on 3/1/18.
//  Copyright © 2018 Henry Chukwu. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    // Outlets
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var channelNameLabel: UILabel!
    @IBOutlet weak var messageTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindToKeyboard()
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatViewController.handleTap))
        view.addGestureRecognizer(tap)
        menuButton.addTarget(self.revealViewController(),
                             action: #selector(SWRevealViewController.revealToggle(_:)),
                             for: .touchUpInside)
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())

        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.userDataDidChange), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)

        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail(completion: { success in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            })
        }

    }

    @objc func userDataDidChange(_ notif: Notification) {
        if AuthService.instance.isLoggedIn {
            onLoginGetMessages()
        } else {
            channelNameLabel.text = "Please Log In"
        }
    }

    @objc func channelSelected(_ notif: Notification) {
        updateWithChannel()
    }

    @objc func handleTap() {
        view.endEditing(true)
    }

    @IBAction func sendMessagePressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            guard let channelId = MessageService.instance.selectedChannel?.id else { return }
            guard let message = messageTextField.text else { return }

            SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId, completion: { (success) in
                if success {
                    self.messageTextField.text = ""
                    self.messageTextField.resignFirstResponder()
                }
            })
        }
    }
    
    func updateWithChannel() {
        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
        channelNameLabel.text = "#\(channelName)"
    }

    func onLoginGetMessages() {
        MessageService.instance.findAllChannel { (success) in
            if success {
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateWithChannel()
                } else {
                    self.channelNameLabel.text = "No channels yet!"
                }
            }
        }
    }

    func getMessages() {
        guard let channelId = MessageService.instance.selectedChannel?.id else { return }
        MessageService.instance.findAllMessageForChannel(channelId: channelId) { (success) in
            
        }
    }
















}
