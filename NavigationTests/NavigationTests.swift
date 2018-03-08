

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
            _ = try DataManager.shared.jsonFileURL()
        }
        catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testGetJSONData() {
        do {
            let jsonData = try DataManager.shared.jsonData(from: DataManager.shared.jsonFileURL())
            XCTAssert(!jsonData.isEmpty, "Failed to get JSONData")
        }
        catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testGetCars() {
        do {
            let jsonData = try DataManager.shared.jsonData(from: DataManager.shared.jsonFileURL())
            XCTAssert(!jsonData.isEmpty, "Failed to get JSONData")
            
            let cars = try DataManager.shared.fetchCars()
            XCTAssert(!cars.isEmpty, "Failed to get cars")
        }
        catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
}
