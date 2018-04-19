import XCTest
@testable import PushNotifications

class EventTypeHandlerTests: XCTestCase {
    #if os(iOS)
    func testEventTypeActive() {
        let userInfo = ["aps": ["content-available": 1], "data": ["eventflit": ["publishId": "pubid-33f3f68e-b0c5-438f-b50f-fae93f6c48df"]]]
        let eventType = EventTypeHandler.getNotificationEventType(userInfo: userInfo, applicationState: .active) as! DeliveryEventType

        XCTAssertTrue(eventType.event == "Delivery")
        XCTAssertFalse(eventType.appInBackground)
        XCTAssertFalse(eventType.hasDisplayableContent)
        XCTAssertFalse(eventType.hasData)
    }

    func testEventTypeActiveWithDisplayableContent() {
        let userInfo = ["aps": ["alert": ["title": "Hello", "body": "Hello, world!"], "content-available": 1], "data": ["eventflit": ["publishId": "pubid-33f3f68e-b0c5-438f-b50f-fae93f6c48df"]]]
        let eventType = EventTypeHandler.getNotificationEventType(userInfo: userInfo, applicationState: .active) as! DeliveryEventType

        XCTAssertTrue(eventType.event == "Delivery")
        XCTAssertFalse(eventType.appInBackground)
        XCTAssertTrue(eventType.hasDisplayableContent)
        XCTAssertFalse(eventType.hasData)
    }

    func testEventTypeActiveWithDisplayableContentAndData() {
        let userInfo = ["aps": ["alert": ["title": "Hello", "body": "Hello, world!"], "content-available": 1], "data": ["eventflit": ["publishId": "pubid-33f3f68e-b0c5-438f-b50f-fae93f6c48df"], "acme2": [ "bang", "whiz"]]]
        let eventType = EventTypeHandler.getNotificationEventType(userInfo: userInfo, applicationState: .active) as! DeliveryEventType

        XCTAssertTrue(eventType.event == "Delivery")
        XCTAssertFalse(eventType.appInBackground)
        XCTAssertTrue(eventType.hasDisplayableContent)
        XCTAssertTrue(eventType.hasData)
    }

    func testEventTypeBackground() {
        let userInfo = ["aps": ["content-available": 1], "data": ["eventflit": ["publishId": "pubid-33f3f68e-b0c5-438f-b50f-fae93f6c48df"]]]
        let eventType = EventTypeHandler.getNotificationEventType(userInfo: userInfo, applicationState: .background) as! DeliveryEventType

        XCTAssertTrue(eventType.event == "Delivery")
        XCTAssertTrue(eventType.appInBackground)
        XCTAssertFalse(eventType.hasDisplayableContent)
        XCTAssertFalse(eventType.hasData)
    }

    func testEventTypeBackgroundWithDisplayableContent() {
        let userInfo = ["aps": ["alert": ["title": "Hello", "body": "Hello, world!"], "content-available": 1], "data": ["eventflit": ["publishId": "pubid-33f3f68e-b0c5-438f-b50f-fae93f6c48df"]]]
        let eventType = EventTypeHandler.getNotificationEventType(userInfo: userInfo, applicationState: .background) as! DeliveryEventType

        XCTAssertTrue(eventType.event == "Delivery")
        XCTAssertTrue(eventType.appInBackground)
        XCTAssertTrue(eventType.hasDisplayableContent)
        XCTAssertFalse(eventType.hasData)
    }

    func testEventTypeBackgroundWithDisplayableContentAndData() {
        let userInfo = ["aps": ["alert": ["title": "Hello", "body": "Hello, world!"], "content-available": 1], "data": ["eventflit": ["publishId": "pubid-33f3f68e-b0c5-438f-b50f-fae93f6c48df"], "acme2": [ "bang", "whiz"]]]
        let eventType = EventTypeHandler.getNotificationEventType(userInfo: userInfo, applicationState: .background) as! DeliveryEventType

        XCTAssertTrue(eventType.event == "Delivery")
        XCTAssertTrue(eventType.appInBackground)
        XCTAssertTrue(eventType.hasDisplayableContent)
        XCTAssertTrue(eventType.hasData)
    }

    func testEventTypeInactive() {
        let userInfo = ["aps": ["alert": ["title": "Hello", "body": "Hello, world!"], "content-available": 1], "data": ["eventflit": ["publishId": "pubid-33f3f68e-b0c5-438f-b50f-fae93f6c48df"]]]
        let eventType = EventTypeHandler.getNotificationEventType(userInfo: userInfo, applicationState: .inactive) as! OpenEventType

        XCTAssertTrue(eventType.event == "Open")
    }
    #elseif os(OSX)
    func testEventTypeOpen() {
        let userInfo = ["aps": ["alert": ["title": "Hello", "body": "Hello, world!"], "content-available": 1], "data": ["eventflit": ["publishId": "pubid-33f3f68e-b0c5-438f-b50f-fae93f6c48df"]]]
        guard let eventType = EventTypeHandler.getNotificationEventType(userInfo: userInfo) else {
            return XCTFail()
        }

        XCTAssertTrue(eventType.event == "Open")
    }
    #endif
}
