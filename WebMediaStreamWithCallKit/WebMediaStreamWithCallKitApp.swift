//
//  WebMediaStreamWithCallKitApp.swift
//  WebMediaStreamWithCallKit
//
//  Created by Stefan Ceriu on 18/10/2024.
//

import SwiftUI

@main
struct WebMediaStreamWithCallKitApp: App {
    let callKitController = CallKitController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    await callKitController.setupCallKitSession()
                }
        }
    }
}
