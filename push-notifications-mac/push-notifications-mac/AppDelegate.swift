import Cocoa
import EventflitPushNotifications

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let pushNotifications = EventflitPushNotifications.shared

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.pushNotifications.start(appId: "97c56dfe-58f5-408b-ab3a-158e51a860f2")
        self.pushNotifications.registerForRemoteNotifications()
    }

    func application(_ application: NSApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        self.pushNotifications.registerDeviceToken(deviceToken) {
            try? self.pushNotifications.subscribe(interest: "hello", completion: {
                print("Ready to receive notifications!")
            })
        }
    }

    func application(_ application: NSApplication, didReceiveRemoteNotification userInfo: [String: Any]) {
        self.pushNotifications.handleNotification(userInfo: userInfo)
        print(userInfo)
    }

    func application(_ application: NSApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Remote notification support is unavailable due to error: \(error.localizedDescription)")
    }
}
