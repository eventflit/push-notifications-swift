import Foundation

struct Instance {
    private static let key = "com.eventflit.sdk.appId"
    private static let userDefaults = UserDefaults(suiteName: "PushNotifications")!

    static func persist(_ appId: String) throws {
        guard let savedappId = Instance.getAppId() else {
            self.userDefaults.set(appId, forKey: key)
            return
        }

        guard appId == savedappId else {
            let errorMessage = """
            This device has already been registered with eventflit.
            Push Notifications application with app id: \(savedappId).
            If you would like to register this device to \(appId) please reinstall the application.
            """

            throw eventflitAlreadyRegisteredError.appId(errorMessage)
        }
    }

    static func getAppId() -> String? {
        return self.userDefaults.string(forKey: key)
    }
}
