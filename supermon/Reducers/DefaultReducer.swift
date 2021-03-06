//
//  DefaultReducer.swift
//  supermon
//
//  Created by Aaron Granick on 12/7/17.
//

import Foundation
import ReSwift

// the reducer is responsible for evolving the application state based
// on the actions it receives
func counterReducer(action: Action, state: AppState?) -> AppState {
    // if no state has been provided, create the default state
    var state = state ?? AppState(ndiSource: nil)
    
    switch action {
    default:
        break
    }
    
    return state
}
