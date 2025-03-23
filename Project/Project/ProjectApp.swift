//
//  ProjectApp.swift
//  Project
//
//  Created by won soohyeon on 12/10/23.
//

import SwiftUI

import ComposableArchitecture
import Firebase
import UserNotifications

@main
struct ProjectApp: App {
    
    init() {
        FirebaseApp.configure()
        configurePushNotifications()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView(store: Store(initialState: MainReducer.State()) {
                MainReducer()
            })
        }
    }
    
    private func configurePushNotifications() {
        let center = UNUserNotificationCenter.current()
        center.delegate = NotificationDelegate() // 커스텀 델리게이트 설정
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Push notification authorization error: \(error)")
            }
            print("Permission granted: \(granted)")
        }
        
        DispatchQueue.main.async {
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
}
