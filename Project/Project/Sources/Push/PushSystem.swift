//
//  PushSystem.swift
//  Project
//
//  Created by won soohyeon on 11/29/24.
//

import Foundation
import UserNotifications
import FirebaseMessaging

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    // 앱이 포그라운드 상태에서 알림 수신 처리
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        print("Received notification while in foreground: \(notification.request.content.userInfo)")
        completionHandler([.banner, .sound]) // 원하는 알림 스타일 반환
    }
    
    // 알림을 클릭했을 때의 처리
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        print("Notification clicked: \(response.notification.request.content.userInfo)")
        completionHandler()
    }
}

extension UIApplication {
    func registerAPNs() {
        DispatchQueue.main.async {
            self.registerForRemoteNotifications()
        }
    }
}

extension ProjectApp {
    private func setupFirebaseMessaging() {
        Messaging.messaging().delegate = self
    }
}

// FirebaseMessagingDelegate 채택
extension YourApp: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")
        // 서버로 FCM 토큰 전송 로직 추가
    }
}
