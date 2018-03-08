

import XCTest
@testable import Navigation

class NavigationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetJSONFileURL() {
        do {
            _ = try DataManager.jsonFileURL()
        }
        catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testGetJSONData() {
        do {
            let jsonData = try DataManager.jsonData(from: DataManager.jsonFileURL())
            XCTAssert(!jsonData.isEmpty, "Failed to get JSONData")
        }
        catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
