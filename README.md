Try
=====

[![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat
)](https://developer.apple.com/swift)
[![CocoaPods](https://img.shields.io/cocoapods/v/Future.svg)]()
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)]
(https://github.com/Carthage/Carthage)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat
)](http://mit-license.org)
[![Issues](https://img.shields.io/github/issues/nghialv/Try.svg?style=flat
)](https://github.com/nghialv/Try/issues?state=open)


Swift µframework providing Try&lt;T>.

This library is inspired by the `Try` implementation in Scala.

##### Without `Try`

``` swift
enum FileError: ErrorType {
	case FileNotFound
	case Unknown
}
	
func lineCountOfFile(filename: String) throws -> Int {
	if exists(filename) {
		let file = open(filename)
		return file.lineCount
	} else {
		throw FileError.FileNotFound
	}
}
	
// traditional way with Swift 2.0
do {
	let lineCount = try lineCountOfFile("data.text")
	// do something
} catch {
	// error handling
}
 
```

##### Code with `Try`

``` swift
let t = Try(try lineCountOfFile("data.text"))

switch t {
 	case .Success(let lines): print(lines)
	case .Failure(let error): print(error)
}
```

- `map` `<^>`

```swift
let t = Try(try lineCountOfFile("data.text")).map { $0 * 5 }

switch t {
	case .Success(let lines): print(lines)
	case .Failure(let error): print(error)
}
```

- `flatMap` `>>-`

```swift
let t = Try(try lineCountOfFile("data.text")).flapMap { Try(try doSomething($0)) }

switch t {
 	case .Success(let lines): print(lines)
	case .Failure(let error): print(error)
}
```

- Operators

``` swift
let t = Try(try lineCountOfFile("data.text")) <^> { $0 * 5} >>- { Try(try doSomething($0)) }

switch t {
	case .Success(let lines): print(lines)
	case .Failure(let error): print(error)
}
```

Installation
-----

- Using Carthage
>	- Insert `github "nghialv/Try"` to your Cartfile
>	- Run `carthage update`


- Using Cocoapods
>	- Insert `use_frameworks!` to your Podfile
>	- Insert `pod "Try"` to your Podfile
>	- Run `pod install`

- Using Submodule


Requirements
-----

- Swift 2.0 (Xcode 7.0 or later)
- iOS 8.0 or later

