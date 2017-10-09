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
    
}
