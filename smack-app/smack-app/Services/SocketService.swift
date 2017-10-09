//
//  SocketService.swift
//  smack-app
//
//  Created by Jess Rascal on 08/10/2017.
//  Copyright © 2017 jessrascal. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {

    static let instance = SocketService()
    
    override init() {
        super.init()
    }
    
    var socket: SocketIOClient = SocketIOClient(socketURL: URL(string: BASE_URL)!)
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func addChannel(name: String, description: String, completion: @escaping CompletionHandler) {
        socket.emit("newChannel", name, description)
        completion(true)
    }
    
    func getChannel(completion: @escaping CompletionHandler) {
        socket.on("channelCreated") { (dataArray, ack) in
            guard let name = dataArray[0] as? String else { return }
            guard let desc = dataArray[1] as? String else { return }
            guard let id = dataArray[2] as? String else { return }
            
            let newChannel = Channel(_id: id, name: name, description: desc, __v: nil)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
    func addMessage(msgBody: String, userId: String, channelId: String, completion: @escaping CompletionHandler) {
        let user = UserDataService.instance
        socket.emit("newMessage", msgBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
    }
    
    func getMessage(completion: @escaping (_ message: Message)-> Void) {
        socket.on("messageCreated") { (dataArray, ack) in
            guard let msgBody = dataArray[0] as? String else { return }
            guard let userId = dataArray[1] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }
            guard let userName = dataArray[3] as? String else { return }
            guard let userAvatar = dataArray[4] as? String else { return }
            guard let userAvatarColor = dataArray[5] as? String else { return }
            guard let id = dataArray[6] as? String else { return }
            guard let timestamp = dataArray[7] as? String else { return }
            
            let newMessage = Message(_id: id, messageBody: msgBody, userId: userId, channelId: channelId, userName: userName, userAvatar: userAvatar, userAvatarColor: userAvatarColor, __v: nil, timeStamp: timestamp)
            
            completion(newMessage)
        }
    }
    
    func getTypingUsers(_ completionHandler: @escaping (_ typingUsers: Dictionary<String, String>) -> Void) {
        socket.on("userTypingUpdate") { (dataArray, ack) in
            guard let typingUsers = dataArray[0] as? Dictionary<String, String> else { return }
            completionHandler(typingUsers)
        }
    }
    
}
