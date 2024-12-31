# FixedList

This provides fixed List of SwiftUI.

## Requirements

- Development with Xcode 16.0+
- Written in Swift 6.0
- Compatible with macOS 14.0+

## Usage

```swift
import SwiftUI
import FixedList

struct Item: Equatable, Identifiable {
    var name: String
    var id: UUID = .init()
}

struct ContentView: View {
    @State var items: [Item] = [
        .init(name: "Apple"),
        .init(name: "Banana"),
        .init(name: "Cherry")
    ]

    var body: some View {
        FixedList(items: $items) { item in
            Text(item.name).fixedSize()
        }
    }
}
```
