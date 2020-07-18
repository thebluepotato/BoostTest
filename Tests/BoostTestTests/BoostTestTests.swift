import XCTest
@testable import BoostTest

final class BoostTestTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(BoostTest().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
