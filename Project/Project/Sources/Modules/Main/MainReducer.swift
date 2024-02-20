//
//  MainReducer.swift
//  Project
//
//  Created by won soohyeon on 1/10/24.
//

import Foundation
import Combine

import ComposableArchitecture

@Reducer
struct MainReducer {
    
    struct State: Equatable {
        
        var isComplete = false
        @BindingState var description = ""
        var path = StackState<RootFeature.Path.State>()
    }
    
    enum Action: BindableAction, Sendable {
        case binding(BindingAction<State>)
        case tapBtn
    }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .tapBtn:
                state.path.append(.subView(state))
                return .none
            case .binding:
                return .none
            }
        }
    }
}


struct RootFeature: Reducer {
  struct State {
    var path = StackState<Path.State>()
  }
  enum Action {
    case mainViewBtnTapped
    case path(StackAction<Path.State, Path.Action>)
  }

  struct Path: Reducer {
      enum State: Equatable {
        case subView(MainReducer.State)
        case mainView(MainReducer.State)
      }
      enum Action {
        case subView(MainReducer.Action)
        case mainView(MainReducer.Action)
      }

      var body: some ReducerOf<Self> {
          Scope(state: /State.mainView, action: /Action.mainView) {
              MainReducer()
          }
          Scope(state: /State.subView, action: /Action.subView) {
              MainReducer()
      }
    }
  }

  var body: some ReducerOf<Self> {
    Reduce { state, action in
      // Core logic for root feature
        switch action {
        case .mainViewBtnTapped:
            state.path.append(.mainView(MainReducer.State()))
        case .path(_):
            return .none
        }
        return .none
    }
    .forEach(\.path, action: /Action.path) {
      Path()
    }
  }
}
