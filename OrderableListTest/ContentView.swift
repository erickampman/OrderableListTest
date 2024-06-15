//
//  ContentView.swift
//  OrderableListTest
//
//  Created by Eric Kampman on 6/14/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
	@Environment(ItemManager.self) private var itemManager
	@Query(sort: \Item.index) private var items: [Item]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
//					Text("\(item.text)")
					#if true
					NavigationLink(value: item.text, label: {
						ItemRowView(item: item, items: items)
					})
					#else
                    NavigationLink {
                        Text("Item at \(item.text)")
                    } label: {
                        Text("\(item.text)")
                    }
					#endif
                }
//                .onDelete(perform: deleteItems)
            }
#if os(macOS)
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
#endif
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
            }
        } detail: {
            Text("Select an item")
        }
		.onAppear {
			itemManager.setupSampleData(modelContext: modelContext)
		}

    }

//    private func addItem() {
//        withAnimation {
//            let newItem = Item(timestamp: Date())
//            modelContext.insert(newItem)
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
//        }

}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}