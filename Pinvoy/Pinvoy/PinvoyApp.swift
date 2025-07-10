//
//  PinvoyApp.swift
//  Pinvoy
//
//  Created by Abbey Noble on 7/9/25.
//

import SwiftUI
import SwiftData

@main
struct PinvoyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Trip.self, Place.self])
    }
}
