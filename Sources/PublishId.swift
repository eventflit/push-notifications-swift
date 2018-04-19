import Foundation

struct PublishId {
    let id: String?

    init(userInfo: [AnyHashable: Any]) {
        let data = userInfo["data"] as? Dictionary<String, Any>
        let eventflit = data?["eventflit"] as? Dictionary<String, Any>
        self.id = eventflit?["publishId"] as? String
    }
}
