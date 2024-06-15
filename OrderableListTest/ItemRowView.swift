//
//  ItemRowView.swift
//  OrderableListTest
//
//  Created by Eric Kampman on 6/14/24.
//

import SwiftUI
import SwiftData

struct ItemRowView: View {
	@Environment(ItemManager.self) private var itemManager
	@Bindable var item: Item
	var items: [Item]
	
    var body: some View {
		HStack	{
			VStack(alignment: .leading, spacing: 3) {
				Button {
					let prev = ItemManager.previous(item, items: items)
					// not checking for nil because of the disabled logic above
					_ = itemManager.switchWithPreviousItem(prev!, current: item)
				} label: {
					Image(systemName: "chevron.up")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: 12)
				}
				.frame(width: 16, height: 16)
				.disabled(ItemManager.previous(item, items: items) == nil)
				Button {
					let next = ItemManager.next(item, items: items)
					// not checking for nil because of the disabled logic above
					_ = itemManager.switchWithNextItem(next!, current: item)
				} label: {
					Image(systemName: "chevron.down")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: 12)
				}
				.frame(width: 16, height: 16)
				.disabled(ItemManager.next(item, items: items) == nil)
			}
			Text(item.text)
		}
    }
	
	
}

