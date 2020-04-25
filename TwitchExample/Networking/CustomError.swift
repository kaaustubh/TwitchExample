//
//  Error.swift
//  Audi_list
//
//  Created by Kaustubh on 13/01/20.
//  Copyright © 2020 KaustubhtestApp. All rights reserved.
//

import Foundation

protocol ErrorProtocol {
    var code: Int { get }
    var type: String { get }
    var message: String { get }
}

struct CustomError: ErrorProtocol, Error, Decodable {
    var code: Int
    
    var type: String
    
    var message: String
    
    init(code: Int, type: String, message: String) {
        self.code = code
        self.type = type
        self.message = message
    }
}
