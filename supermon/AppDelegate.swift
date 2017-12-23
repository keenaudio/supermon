//
//  AppDelegate.swift
//  supermon
//
//  Created by Aaron Granick on 12/7/17.
//

import Cocoa
import ReSwift

// The global application store, which is responsible for managing the appliction state.
let mainStore = Store<AppState>(
    reducer: counterReducer,
    state: nil
)

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

