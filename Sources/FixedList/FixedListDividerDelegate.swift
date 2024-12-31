/*
 FixedListDividerDelegate.swift
 FixedList

 Created by Takuto Nakamura on 2024/12/31.
 
*/

import SwiftUI

struct FixedListDividerDelegate<Item: FixedListItem>: DropDelegate {
    var index: Int
    @Binding var items: [Item]
    @Binding var draggingItem: Item?
    @Binding var hoveringIndex: Int?

    func performDrop(info: DropInfo) -> Bool {
        if let draggingItem, info.hasItemsConforming(to: [.item]),
           let fromIndex = items.firstIndex(of: draggingItem),
           fromIndex != index && fromIndex + 1 != index {
            let offset = index
            items.move(fromOffsets: IndexSet(integer: fromIndex), toOffset: offset)
            self.draggingItem = nil
            return true
        } else {
            self.draggingItem = nil
            return false
        }
    }

    func dropEntered(info: DropInfo) {
        hoveringIndex = index
    }

    func dropUpdated(info: DropInfo) -> DropProposal? {
        DropProposal(operation: .move)
    }

    func dropExited(info: DropInfo) {
        hoveringIndex = nil
    }
}
