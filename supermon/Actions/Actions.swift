//
//  Actions.swift
//  supermon
//
//  Created by Aaron Granick on 12/7/17.
//

import Foundation
import ReSwift
import NDIKit

// all of the actions that can be applied to the state
struct SetNDISource: Action {
    let ndiSource:NDISource
}

