//
//  TokenManager.swift
//  TwitchExample
//
//  Created by Kaustubh on 25/04/20.
//  Copyright © 2020 KaustubhtestApp. All rights reserved.
//

import Foundation

let CLINT_ID = "jpgequam6ev2l6jdssn37dduuv02lc"
let CLIENT_SECRET = "46zu054ke58o81txe38bntxg42g77q"
let GRANT_TYPE = "client_credentials"
let REDIRECT_URL = "http://localhost"

struct TokenResponse: Codable{
    var access_token: String
    var refresh_token: String?
    var expires_in: Int
    var token_type: String
}

class TokenManager: NSObject {
    static let shared = TokenManager()
    private let client = NetworkEngine(baseUrl: "https://id.twitch.tv")
    @discardableResult
    func getToken(completion: @escaping (String?, CustomError?) -> ()) -> URLSessionDataTask?{
        let params: JSON = ["client_id": CLINT_ID, "client_secret": CLIENT_SECRET, "grant_type": GRANT_TYPE, "redirect_uri": REDIRECT_URL]
        return client.load(path: "/oauth2/token", method: .post, params: params) { result, error in
            if (error != nil) {
                completion(nil, error)
            }
            else if (result != nil) {
                let postResponse = try! JSONDecoder().decode(TokenResponse.self, from: result as! Data)
                completion(postResponse.access_token, nil)
            }
            else {
                completion(nil, CustomError(code: 405, type: "NoResult", message: "No results found"))
            }
        }
    }
}

