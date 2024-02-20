//
//  MainView.swift
//  Project
//
//  Created by won soohyeon on 12/10/23.
//

import SwiftUI

import ComposableArchitecture

struct MainView: View {
    
    let store: StoreOf<MainReducer>
    
    var body: some View {
        WithViewStore(store, observe: {$0}) { viewStore in
            NavigationView {
                VStack {
                    Button(action: {
                        viewStore.send(.tapBtn)
                    }, label: {
                        Text("Toggle Button")
                    })
                    
                    Text("Toggle Button isComplete: \(String(describing: viewStore.state.isComplete))")
                    
                    TextField("텍스트 작성: ", text: viewStore.$description)
                    
                    Text("입력된 데이터: \(viewStore.description)")
                    
                    Button {
                        viewStore.send(.tapBtn)
                        
                    } label: {
                        Image(systemName: "c.square.fill")
                    }
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
                .navigationTitle("")
                
            }
        }
    }
}

#Preview {
    MainView(store: Store(initialState: MainReducer.State()) {
        MainReducer()
    })
}

struct RootView: View {
    let store: StoreOf<RootFeature>

  var body: some View {
      let navigationStore = store.scope(
            state: \.path,
            action: { RootFeature.Action.path($0) }
          )
      
    NavigationStackStore(navigationStore) {
      // Root view of the navigation stack
        MainView(store: Store(initialState: MainReducer.State()) {
            MainReducer()
        })
        
        Button {
            store.send(.mainViewBtnTapped)
        } label: {
            Text("메인화면이동")
        }


    } destination: { state in
        
        switch state {
        case .subView(let subViewState):
            SubView(store: Store(initialState: subViewState) {
                MainReducer()
            })
        case .mainView(let subViewState):
            MainView(store: Store(initialState: subViewState) {
                MainReducer()
            })
      }
    }
  }
}
