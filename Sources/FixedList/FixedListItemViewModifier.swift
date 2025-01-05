/*
 FixedListItemViewModifier.swift
 FixedList

 Created by Takuto Nakamura on 2024/12/31.
 
*/

import SwiftUI

struct FixedListItemViewModifier<Item: FixedListItem>: ViewModifier {
    var index: Int
    @Binding var items: [Item]
    @Binding var draggingItem: Item?
    @Binding var hoveringIndex: Int?
    @State private var size = CGSize.zero

    func body(content: Content) -> some View {
        content
            .background {
                Color.clear.onGeometryChange(for: CGSize.self) { proxy in
                    proxy.size
                } action: { newValue in
                    size = newValue
                }
            }
            .onDrag {
                draggingItem = items[index]
                return NSItemProvider(
                    contentsOf: URL(string: items[index].id.hashValue.description)!,
                    contentType: .item
                )
            }
            .onDrop(
                of: [.item],
                delegate: FixedListItemDelegate(
                    index: index,
                    height: size.height,
                    items: $items,
                    draggingItem: $draggingItem,
                    hoveringIndex: $hoveringIndex
                )
            )
            .padding(.horizontal)
    }
}
