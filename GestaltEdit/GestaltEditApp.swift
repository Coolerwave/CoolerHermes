//
//  GestaltEditApp.swift
//  GestaltEdit
//

import SwiftUI

@main
struct GestaltEditApp: App {
    @StateObject private var viewModel = GestaltViewModel()

    init() {
        AutomationCommand.runIfNeeded()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .tint(Color(red: 0.08, green: 0.62, blue: 0.82))
        }
    }
}
