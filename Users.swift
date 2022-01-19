//
//  Users.swift
//  HttpRequests
//
//  Created by Jagadeesh on 29/12/21.
//

import Foundation

struct User : Codable {
    let data: [UserData]
}

struct  UserData : Codable {
    var avatar : String?
    var id     :  Int
    var email  : String
    var first_name : String
    var last_name  : String
    
    init(id: Int, email: String, firstName: String, lastName: String) {
        self.id = id
        self.email = email
        self.first_name = firstName
        self.last_name = lastName
    }
}
