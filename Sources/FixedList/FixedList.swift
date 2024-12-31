/*
 FixedList.swift
 FixedList

 Created by Takuto Nakamura on 2024/12/31.

*/

import SwiftUI

public typealias FixedListItem = Equatable & Identifiable

public struct FixedList<Content: View, Item: FixedListItem>: View {
    @Binding var items: [Item]
    var eachContent: (Item) -> Content
    @State private var draggingItem: Item?
    @State private var hoveringIndex: Int?

    public init(items: Binding<[Item]>, eachContent: @escaping (Item) -> Content) {
        _items = items
        self.eachContent = eachContent
    }

    public var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(0 ... items.count, id: \.self) { index in
                    Divider()
                        .modifier(FixedListDividerViewModifier(
                            index: index,
                            items: $items,
                            draggingItem: $draggingItem,
                            hoveringIndex: $hoveringIndex
                        ))
                    if index < items.count {
                        eachContent(items[index])
                            .modifier(FixedListItemViewModifier(
                                index: index,
                                items: $items,
                                draggingItem: $draggingItem,
                                hoveringIndex: $hoveringIndex
                            ))
                    }
                }
            }
            .fixedSize()
        }
    }
}
