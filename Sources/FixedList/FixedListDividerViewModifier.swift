/*
 FixedListDividerViewModifier.swift
 FixedList

 Created by Takuto Nakamura on 2024/12/31.
 
*/

import SwiftUI

struct FixedListDividerViewModifier<Item: FixedListItem>: ViewModifier {
    var index: Int
    @Binding var items: [Item]
    @Binding var draggingItem: Item?
    @Binding var hoveringIndex: Int?

    func body(content: Content) -> some View {
        content
            .opacity((index == 0 || index == items.count) ? 0 : 1)
            .frame(height: 7)
            .onDrop(
                of: [.item],
                delegate: FixedListDividerDelegate(
                    index: index,
                    items: $items,
                    draggingItem: $draggingItem,
                    hoveringIndex: $hoveringIndex
                )
            )
            .padding(.leading)
            .overlay {
                if index == hoveringIndex {
                    Canvas { contex, cSize in
                        contex.stroke(
                            Path(ellipseIn: CGRect(x: 9, y: 1, width: 5, height: 5)),
                            with: .color(.accentColor.opacity(0.8)),
                            lineWidth: 2
                        )
                        var path = Path()
                        path.move(to: CGPoint(x: 15, y: 0.5 * cSize.height))
                        path.addLine(to: CGPoint(x: cSize.width, y: 0.5 * cSize.height))
                        contex.stroke(path, with: .color(.accentColor.opacity(0.8)), lineWidth: 2)
                    }
                }
            }
            .padding(.trailing)
    }
}
