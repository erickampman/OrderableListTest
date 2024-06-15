//
//  Item.swift
//  OrderableListTest
//
//  Created by Eric Kampman on 6/14/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class Item: Identifiable, Equatable {
	var text: String
	var index: Float
    
	var id: Float { index }
	
	init(text: String, index: Float) {
		self.text = text
		self.index = index
	}
}

@MainActor
@Observable
final class ItemManager {
	// first item should be index 1. Note that it's a float
	private var nextIndex: Float = 1
	private var setup = false
	
	func addItem(text: String, modelContext: ModelContext) {
		let item = Item(text: text, index: nextIndex)
		nextIndex += 1.0
		modelContext.insert(item)
	}
	
	// returns false if can't
	func switchWithPreviousItem(_ previous: Item, current: Item) -> Bool {
		let diff = current.index - previous.index
		if diff != 1.0 				{ return false }
		if previous.index < 1.0 	{ return false }
		
		// Move current index so it's less than previous.index
		current.index -= 1.5  // fraction needs to be power of 2 for this to work cleanly
		previous.index += 1.0
		current.index += 0.5
		
		return true
	}
	
	func switchWithNextItem(_ next: Item, current: Item) -> Bool {
		let diff = next.index - current.index
		if diff != 1.0 				{ return false }
		
		// Move current index so it's greater than next.index
		current.index += 1.5  // fraction needs to be power of 2 for this to work cleanly
		next.index -= 1.0
		current.index -= 0.5
		
		return true
	}
	
	func setupSampleData(modelContext: ModelContext) {
		if !setup {
			addItem(text: "Item A", modelContext: modelContext)
			addItem(text: "Item B", modelContext: modelContext)
			addItem(text: "CCCCC", modelContext: modelContext)
			addItem(text: "AAAAA", modelContext: modelContext)
			addItem(text: "ZZZ Item", modelContext: modelContext)
		}
		setup = true
	}
		
	// index is ones-based. Also, index is the member of
	// Item, not the array index itself.
	// Need better algorithm if there are a lot of items. FIXME
	// For now, don't assume the items are in item.index order
	static func previous(_ item: Item, items: [Item]) -> Item? {
		var ret = Item?.none
		for i in items {
			if i.index < item.index {
				if nil == ret {
					ret = i
					continue
				}
				if nil != ret && i.index > ret!.index {
					ret = i
				}
			}
		}
		return ret
	}
	
	static func next(_ item: Item, items: [Item]) -> Item? {
		var ret = Item?.none
		for i in items {
			if i.index > item.index {
				if nil == ret {
					ret = i
					continue
				}
				if nil != ret && i.index < ret!.index {
					ret = i
				}
			}
		}
		return ret
	}

}
