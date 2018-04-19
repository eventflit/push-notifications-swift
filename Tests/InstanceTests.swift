import XCTest
@testable import PushNotifications

class InstanceTests: XCTestCase {
    override func setUp() {
        super.setUp()
        XCTAssertNoThrow(try Instance.persist("abcd"))
    }

    override func tearDown() {
        UserDefaults(suiteName: "PushNotifications")?.removeObject(forKey: "com.eventflit.sdk.appId")
        super.tearDown()
    }

    func testappIdWasSaved() {
        XCTAssertNoThrow(try Instance.persist("abcd"))
        let appId = Instance.getAppId()

        XCTAssertNotNil(appId)
        XCTAssert("abcd" == appId)
    }

    func testPersistNewappId() {
        XCTAssertThrowsError(try Instance.persist("abcdefg")) { error in
            guard case eventflitAlreadyRegisteredError.appId(let errorMessage) = error else {
                return XCTFail()
            }

            let expectedErrorMessage = """
This device has already been registered with eventflit.
Push Notifications application with app id: abcd.
If you would like to register this device to abcdefg please reinstall the application.
"""
            XCTAssertEqual(errorMessage, expectedErrorMessage)
        }
    }
}
