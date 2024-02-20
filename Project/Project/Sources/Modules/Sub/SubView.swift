//
//  SubView.swift
//  Project
//
//  Created by won soohyeon on 1/17/24.
//

import SwiftUI

import ComposableArchitecture

struct SubView: View {
    
    let store: StoreOf<MainReducer>
    
    @Dependency(\.dismiss) var dismiss
    
    var body: some View {
        WithViewStore(store, observe: {$0}) { viewStore in
            VStack {
                Button {
                    
                } label: {
                    Text("popToRoot")
                }
            }
        }
    }
}
