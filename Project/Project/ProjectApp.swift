//
//  ProjectApp.swift
//  Project
//
//  Created by won soohyeon on 12/10/23.
//

import SwiftUI

import ComposableArchitecture

@main
struct ProjectApp: App {
    
    var body: some Scene {
        WindowGroup {
            RootView(store: Store(initialState: RootFeature.State()) {
                RootFeature()
            })
        }
    }
}
