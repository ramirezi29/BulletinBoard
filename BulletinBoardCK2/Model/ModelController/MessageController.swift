//
//  MessageController.swift
//  BulletinBoardCK2
//
//  Created by Ivan Ramirez on 9/24/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import Foundation

class MessageController {
    
    //Shared instanace
    
    static let shared = MessageController()
    
    //source of truth
    
    var messages: [Message] = []
    
    //CRUD
    
    func createMessage(text: String) {
        let message = Message(text: text)
        messages.append(message)
    }
    
}
