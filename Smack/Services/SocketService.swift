//
//  SocketService.swift
//  Smack
//
//  Created by Henry Chukwu on 3/14/18.
//  Copyright © 2018 Henry Chukwu. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {

    static let instance = SocketService()

    override init() {
        super.init()
    }

//    var socket: SocketIOClient = SocketIOClient(manager: URL(string: BASE_URL)! as! SocketManagerSpec, nsp: <#String#>)
    var socket: SocketManager = SocketManager(socketURL: URL(string: BASE_URL)!, config: [SocketIOClientOption.extraHeaders(BEARER_HEADER)])
    lazy var defaultSocket = socket.defaultSocket

    func establishConnection() {
        socket.connect()
    }

    func closeConnection() {
        socket.disconnect()
    }

    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler) {
        defaultSocket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }

    func getChannel(completion: @escaping CompletionHandler) {
        defaultSocket.on("channelCreated", callback: { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else { return }
            guard let channelDescription = dataArray[1] as? String else { return }
            guard let channelID = dataArray[2] as? String else { return }

            let newChannel = Channel(channelTitle: channelName, channelDescription: channelDescription, id: channelID)
            MessageService.instance.channels.append(newChannel)
            completion(true)

        })
    }

    func addMessage(messageBody: String, userId: String, channelId: String, completion: @escaping CompletionHandler) {
        let user = UserDataService.instance
        defaultSocket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
    }






}
