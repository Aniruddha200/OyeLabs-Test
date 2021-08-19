//
//  OyeLabs_TestApp.swift
//  OyeLabs Test
//
//  Created by administrator on 19/08/2021.
//

import SwiftUI

@main
struct OyeLabs_TestApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
