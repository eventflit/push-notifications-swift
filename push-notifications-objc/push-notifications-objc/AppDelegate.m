#import "AppDelegate.h"
@import EventflitPushNotifications;

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[EventflitPushNotifications shared] startWithAppId:@"f918950d-476d-4649-b38e-6cc8d30e0827"];
    [[EventflitPushNotifications shared] registerForRemoteNotifications];

    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[EventflitPushNotifications shared] registerDeviceToken:deviceToken completion:^{
        NSError *anyError;
        [[EventflitPushNotifications shared] subscribeWithInterest:@"hello" error:&anyError completion:^{
            if (anyError) {
                NSLog(@"Error: %@", anyError);
            }
            else {
                NSLog(@"Subscribed to interest hello.");
            }
        }];
    }];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [[EventflitPushNotifications shared] handleNotificationWithUserInfo:userInfo];
    NSLog(@"%@", userInfo);
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Remote notification support is unavailable due to error: %@", error.localizedDescription);
}

@end
