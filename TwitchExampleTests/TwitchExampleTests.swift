//
//  TwitchExampleTests.swift
//  TwitchExampleTests
//
//  Created by Kaustubh on 25/04/20.
//  Copyright © 2020 KaustubhtestApp. All rights reserved.
//

import XCTest
@testable import TwitchExample

class TwitchExampleTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testGetPosts() {
        let tokenExpectation = expectation(description: "Get Posts")
        let manager = TokenManager.shared
        manager.getToken(completion: { token, error in
            if error == nil && token!.count > 0 {
                tokenExpectation.fulfill()
            }
        })
        waitForExpectations(timeout: 3, handler: nil)
        
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
