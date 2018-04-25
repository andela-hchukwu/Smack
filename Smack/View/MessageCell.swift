//
//  MessageCell.swift
//  Smack
//
//  Created by Henry Chukwu on 4/12/18.
//  Copyright © 2018 Henry Chukwu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    // Outlets

    @IBOutlet weak var userImage: CircleImage!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var messageBodyLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(message: Message) {
        messageBodyLabel.text = message.message
        userNameLabel.text = message.userName
        userImage.image = UIImage(named: message.userAvatar)
        userImage.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)

        guard var isoDate = message.timeStamp else { return }
        let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
//        isoDate = isoDate.substring(to: end)
        isoDate = String(isoDate[..<end])

        let isoFormatter = ISO8601DateFormatter()
        let chatDate = isoFormatter.date(from: isoDate.appending("Z"))

        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MMM d, h:mm a"
        if let finalDate = chatDate {
            let finalDate = newFormatter.string(from: finalDate)
            timeStampLabel.text = finalDate
        }
    }

}
