import Foundation

/**
 Error thrown by PushNotifications.

 *Values*

 `appId` The app id was already registered.
 */
public enum eventflitAlreadyRegisteredError: Error {
    /**
     app id was already registered with eventflit.

     - Parameter: appId
     */
    case appId(String)
}
