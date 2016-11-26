# AuthyStore
Two factor authentication with authy

[![SPM compatible](https://img.shields.io/badge/spm-supported-orange.svg)](https://swift.org/package-manager/)


### Installation

#### Swift Package Manager

Add the following line 

```swift
.Package(url: "https://github.com/rchatham/AuthyStore.git", majorVersion: 0) 
```

to your Package.swift file as illustrated below. 

```swift
import PackageDescription

let package = Package(
    name: "YourAppName",
    targets: [],
    dependencies: [
        .Package(url: "https://github.com/rchatham/AuthyStore.git", majorVersion: 0),
        ]
)
```
