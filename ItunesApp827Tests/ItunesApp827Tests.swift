//
//  ItunesApp827Tests.swift
//  ItunesApp827Tests
//
//  Created by mac on 9/10/19.
//  Copyright © 2019 mac. All rights reserved.
//

import XCTest
@testable import ItunesApp827 //needed to use the project files, of your application

class ItunesApp827Tests: XCTestCase {

    let service = ItunesService.shared
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //each test case MUST start with "test", or it wont work
    func testTrackArray() {
        let viewModel = ViewModel()
        XCTAssertTrue(viewModel.tracks.isEmpty)
    }
    
    func testRandomThing() {
        
        var numbers = [1, 2]
        
        measure { //measure the amount of time for the code in the block to execute - to create a baseline
            for num in 3...10 {
                numbers.append(num)
            }
        }
        
        XCTAssertTrue(numbers.count > 9)
        
    }
    
    //MARK: How to - handle async test cases
    func testAlbumServiceCall() {
        
        var albums = [Album]()
        let promise = expectation(description: "wait for service call") //create expectation to wait for async call
        service.getAlbums(for: "prince") { albms in
            albums = albms
            promise.fulfill() //marks the point that the expectation is fulfilled
        }
        
        waitForExpectations(timeout: 3, handler: nil) // wait for expectation to be fulfilled for 3 seconds
        
        XCTAssert(albums.count > 0)
    }

}
