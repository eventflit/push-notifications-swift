import XCTest
@testable import PushNotifications

class RegisterTests: XCTestCase {
    #if os(iOS)
    let register = Register(token: "123", appId: "abc", bundleIdentifier: "com.eventflit", metadata: Metadata(sdkVersion: "0.4.0", iosVersion: "11.2.0", macosVersion: nil))
    #elseif os(OSX)
    let register = Register(token: "123", appId: "abc", bundleIdentifier: "com.eventflit", metadata: Metadata(sdkVersion: "0.4.0", iosVersion: nil, macosVersion: "10.9"))
    #endif

    #if os(iOS)
    func testRegisterModel() {
        let register = self.register
        XCTAssertNotNil(register)
        XCTAssertEqual(register.token, "123")
        XCTAssertEqual(register.appId, "abc")
        XCTAssertEqual(register.bundleIdentifier, "com.eventflit")
        XCTAssertEqual(register.metadata.sdkVersion, "0.4.0")
        XCTAssertEqual(register.metadata.iosVersion, "11.2.0")
        XCTAssertEqual(register.metadata.macosVersion, nil)
    }

    func testRegisterEncoded() {
        let registerEncoded = try! self.register.encode()
        XCTAssertNotNil(registerEncoded)
        let registerJSONExpected = "{\"metadata\":{\"sdkVersion\":\"0.4.0\",\"iosVersion\":\"11.2.0\"},\"appId\":\"abc\",\"token\":\"123\",\"bundleIdentifier\":\"com.eventflit\"}"
        let registerJSON = String(data: registerEncoded, encoding: .utf8)!
        XCTAssertEqual(registerJSONExpected, registerJSON)
    }
    #elseif os(OSX)
    func testRegisterModel() {
        let register = self.register
        XCTAssertNotNil(register)
        XCTAssertEqual(register.token, "123")
        XCTAssertEqual(register.appId, "abc")
        XCTAssertEqual(register.bundleIdentifier, "com.eventflit")
        XCTAssertEqual(register.metadata.sdkVersion, "0.4.0")
        XCTAssertEqual(register.metadata.iosVersion, nil)
        XCTAssertEqual(register.metadata.macosVersion, "10.9")
    }

    func testRegisterEncoded() {
        let registerEncoded = try! self.register.encode()
        XCTAssertNotNil(registerEncoded)
        let registerJSONExpected = "{\"metadata\":{\"sdkVersion\":\"0.4.0\",\"macosVersion\":\"10.9\"},\"appId\":\"abc\",\"token\":\"123\",\"bundleIdentifier\":\"com.eventflit\"}"
        let registerJSON = String(data: registerEncoded, encoding: .utf8)!
        XCTAssertEqual(registerJSONExpected, registerJSON)
    }
    #endif
}
