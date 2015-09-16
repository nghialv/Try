//
//  Try.swift
//  Try
//
//  Created by Le VanNghia on 6/11/15.
//  Copyright © 2015 Le Van Nghia. All rights reserved.
//

import Foundation

public enum Try<T> {
    case Success(T)
    case Failure(ErrorType)
    
    // MARK: Constructors
    
    // Init with the given success value
    public init(value: T) {
        self = .Success(value)
    }
    
    // Init with the given error
    public init(error: ErrorType) {
        self = .Failure(error)
    }
    
    // Init with the given throws method
    public init(@autoclosure _ f: () throws -> T) {
        do {
            self = .Success(try f())
        } catch {
            self = .Failure(error)
        }
    }
    
    
    // MAKR: Getters
    
    // Returns the value when `Success`, otherwise returns nil
    public var value: T? {
        if case .Success(let value) = self {
            return value
        }
        return nil
    }
    
    // Returns the error when `Failure`, otherwise returns nil
    public var error: ErrorType? {
        if case .Failure(let error) = self {
            return error
        }
        return nil
    }
    
    
    // MARK: Higher-order functions
    
    // map | you can also use `<^>` operator
    // Creates a new Try by applying a function to the successful result of this Try.
    // If this Try is completed with an error then the new Try will also contain this error.
    public func map<U>(f: T -> U) -> Try<U> {
        switch self {
        case .Success(let value): return .Success(f(value))
        case .Failure(let error): return .Failure(error)
        }
    }
    
    // flatMap | you can also use `>>-` operator
    // Creates a new Try by applying a function to the successful result of this Try,
    // and returns the result of the function as the new Try.
    // If this Try is completed with an error then the new Try will also contain this error.
    public func flatMap<U>(f: T throws -> Try<U>) -> Try<U> {
        switch self {
        case .Success(let value):
            do {
                return try f(value)
            } catch {
                return .Failure(error)
            }
        case .Failure(let error):
            return .Failure(error)
        }
    }
    
    // flatMap without throws | you can also use `>>-` operator
    // Creates a new Try by applying a function to the successful result of this Try,
    // and returns the result of the function as the new Try.
    // If this Try is completed with an error then the new Try will also contain this error.
    public func flatMap<U>(f: T -> Try<U>) -> Try<U> {
        switch self {
        case .Success(let value): return f(value)
        case .Failure(let error): return .Failure(error)
        }
    }
    
    // recover
    // Creates a new Try by applying a function to the error result of this Try.
    // If this Try is completed with an success then the new Try will also contain this success.
    // This is like map for the error.
    public func recover(f: ErrorType -> T) -> Try<T> {
        switch self {
        case .Success(let value): return .Success(value)
        case .Failure(let error): return .Success(f(error))
        }
    }
    
    // recoverWith
    // Creates a new Try by applying a function to the error result of this Try.
    // and returns the result of the function as the new Try.
    // If this Try is completed with an success then the new Try will also contain this success.
    // This is like flatMap for the error.
    public func recoverWith(f: ErrorType throws -> Try<T>) -> Try<T> {
        switch self {
        case .Success(let value): return .Success(value)
        case .Failure(let error):
            do {
                return try f(error)
            } catch {
                return .Failure(error)
            }
        }
    }
    
    // recoverWith | without throws
    // Creates a new Try by applying a function to the error result of this Try.
    // and returns the result of the function as the new Try.
    // If this Try is completed with an success then the new Try will also contain this success.
    // This is like flatMap for the error.
    public func recoverWith(f: ErrorType -> Try<T>) -> Try<T> {
        switch self {
        case .Success(let value): return .Success(value)
        case .Failure(let error): return f(error)
        }
    }
}


// MARK: Operators

infix operator <^> {
    // Left associativity
    associativity left

    // Precedence
    precedence 150
}

infix operator >>- {
    // Left associativity
    associativity left

    // Using the same `precedence` value in antitypical/Result
    precedence 120
}

// Operator for `map`
public func <^> <T, U> (t: Try<T>, f: T -> U) -> Try<U> {
    return t.map(f)
}

// Operator for `flatMap`
public func >>- <T, U> (t: Try<T>, f: T -> Try<U>) -> Try<U> {
    return t.flatMap(f)
}

public func >>- <T, U> (t: Try<T>, f: T throws -> Try<U>) -> Try<U> {
    return t.flatMap(f)
}
