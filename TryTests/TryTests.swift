//
//  TryTests.swift
//  TryTests
//
//  Created by Le Van Nghia on 6/11/15.
//  Copyright © 2015 Le Van Nghia. All rights reserved.
//

import XCTest
import Try

enum TestError: ErrorType {
    case InvalidString(String)
    case Unknown
}

func stringToInt(s: String) throws -> Int {
    if let i = Int(s) {
        return i
    } else {
        throw TestError.InvalidString(s)
    }
}


final class TryTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSuccessTry() {
        let t = Try(try stringToInt("1"))
        switch t {
            case .Success(let value): print(value) //XCTAssertEqual(value, 1, "Try should return 1")
            case .Failure: XCTAssertFalse(true, "Try should not be failed")
        }
    }
    
    func testFailureTry() {
        let e = TestError.InvalidString("not number")
        let t = Try<Int>(error: e)
        
        switch t {
            case .Success: XCTAssertFalse(true, "Try should not be succeeded")
            case .Failure(let error): print(error) //XCTAssertEqual(error, e, "Try should return an error")
        }
    }
    
    func testSuccessRecover() {
        let t = Try(try stringToInt("2")).map { $0 * 2 }.recover { e in
            switch e {
            case TestError.InvalidString: return 1
            default: return 0
            }
        }
        
        switch t {
        case .Success(let value): print(value) //XCTAssertEqual(value, 4, "Try should return 4")
        case .Failure: XCTAssertFalse(true, "Try should not be failed")
        }
    }
    
    func testFailureRecover() {
        let t = Try(try stringToInt("a")).map { $0 * 2 }.recover { e in
            switch e {
            case TestError.InvalidString: return 1
            default: return 0
            }
        }
        
        switch t {
        case .Success(let value): print(value) //XCTAssertEqual(value, 1, "Try should return 1")
        case .Failure: XCTAssertFalse(true, "Try should not be failed")
        }
    }
}
