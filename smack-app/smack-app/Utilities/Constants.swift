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
let BASE_URL = "http://localhost:3005/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"

// Segues
let TO_LOGIN_VC = "toLoginVC"
let TO_CREATE_ACC_VC = "toCreateAccVC"
let UNWIND_TO_CHANNEL_VC = "unwindToChannelVC"

// User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"
