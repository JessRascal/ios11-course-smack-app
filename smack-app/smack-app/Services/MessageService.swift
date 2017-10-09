//
//  MessageService.swift
//  smack-app
//
//  Created by Jess Rascal on 08/10/2017.
//  Copyright © 2017 jessrascal. All rights reserved.
//

import Foundation
import Alamofire

class MessageService {
    
    static let instance = MessageService()
    
    var channels = [Channel]()
    var selectedChannel: Channel?
    
    func getAllChannels(completion: @escaping CompletionHandler) {
        Alamofire.request(URL_CHANNELS_GET, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER_AUTH).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                do {
                    self.channels = try JSONDecoder().decode([Channel].self, from: data)
                    NotificationCenter.default.post(name: NOTIF_USER_CHANNELS_LOADED, object: nil)
                    completion(true)
                } catch let err {
                    debugPrint(err as Any)
                }
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func clearChannels() {
        channels.removeAll()
    }
    
}
