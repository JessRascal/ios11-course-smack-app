//
//  Constants.swift
//  smack-app
//
//  Created by Jess Rascal on 05/10/2017.
//  Copyright © 2017 jessrascal. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()

// URL Constants
let BASE_URL = "http://localhost:3005/v1"
let URL_REGISTER = "\(BASE_URL)/account/register"
let URL_LOGIN = "\(BASE_URL)/account/login"
let URL_USER_ADD = "\(BASE_URL)/user/add"
let URL_USER_BY_EMAIL = "\(BASE_URL)/user/byEmail/"
//let URL_LOG_OUT = "`\(BASE_URL)/account/logout"
let URL_CHANNELS_GET = "\(BASE_URL)/channel"
let URL_GET_MESSAGES_BY_CHANNEL = "\(BASE_URL)/message/byChannel/"

// Colors
let SMACK_PURPLE_PLACEHOLDER = #colorLiteral(red: 0.3254901961, green: 0.4196078431, blue: 0.7764705882, alpha: 0.5)

// Notifications
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("notifUserDataChanged")
let NOTIF_USER_CHANNELS_LOADED = Notification.Name("notifChannelsLoaded")
let NOTIF_USER_CHANNEL_SELECTED = Notification.Name("notifChannelSelected")

// Segues
let TO_LOGIN_VC = "toLoginVC"
let TO_CREATE_ACC_VC = "toCreateAccVC"
let TO_AVATAR_PICKER_VC = "toAvatarPickerVC"
let UNWIND_TO_CHANNEL_VC = "unwindToChannelVC"

// User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

// Headers
let HEADER = [
    "Content-Type": "application/json; charset=utf-8"
]
let HEADER_AUTH = [
    "Authorization": "Bearer \(AuthService.instance.authToken)",
    "Content-Type": "application/json; charset=utf-8"
]
