import XCTest

import crtestTests

var tests = [XCTestCaseEntry]()
tests += crtestTests.allTests()
XCTMain(tests)