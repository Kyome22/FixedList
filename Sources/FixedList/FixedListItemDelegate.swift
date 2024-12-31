/*
 FixedListItemDelegate.swift
 FixedList

 Created by Takuto Nakamura on 2024/12/31.
 
*/

import SwiftUI

struct FixedListItemDelegate<Item: FixedListItem>: DropDelegate {
    var index: Int
    var height: CGFloat
    @Binding var items: [Item]
    @Binding var draggingItem: Item?
    @Binding var hoveringIndex: Int?

    func performDrop(info: DropInfo) -> Bool {
        if let draggingItem, info.hasItemsConforming(to: [.item]),
           let fromIndex = items.firstIndex(of: draggingItem),
           fromIndex != index {
            let offset = index + (fromIndex < index ? 1 : 0)
            items.move(fromOffsets: IndexSet(integer: fromIndex), toOffset: offset)
            self.draggingItem = nil
            return true
        } else {
            self.draggingItem = nil
            return false
        }
    }

    func dropEntered(info: DropInfo) {
        hoveringIndex = if info.location.y < (0.5 * height) {
            index
        } else {
            index + 1
        }
    }

    func dropUpdated(info: DropInfo) -> DropProposal? {
        hoveringIndex = if info.location.y < (0.5 * height) {
            index
        } else {
            index + 1
        }
        return DropProposal(operation: .move)
    }

    func dropExited(info: DropInfo) {
        hoveringIndex = nil
    }
}
