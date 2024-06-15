//
//  OrderableListTestApp.swift
//  OrderableListTest
//
//  Created by Eric Kampman on 6/14/24.
//

import SwiftUI
import SwiftData

@main
struct OrderableListTestApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
		@State var itemManager = ItemManager()
		
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
		.environment(itemManager)
    }
}
