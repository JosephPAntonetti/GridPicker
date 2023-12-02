//
//  SwiftUIView.swift
//  
//
//  Created by Joseph Antonetti on 12/2/23.
//

import SwiftUI

public struct GridPicker<Item, ItemView>: View where Item: Identifiable, Item : Equatable, ItemView : View {
    
    public let columns : Int
    public let items : [Item]
    
    @Binding public var selected : Item

    @ViewBuilder public let itemViewBuilder : (Item) -> ItemView
    
    private var gridItems : [GridItem] {
        (0...columns).map({_ in GridItem(.flexible())})
    }
    
    public init(columns: Int, items: [Item], selected: Binding<Item>, itemViewBuilder: @escaping (Item) -> ItemView) {
        self.columns = columns
        self.items = items
        self.itemViewBuilder = itemViewBuilder
        self._selected = selected
    }
    
    public var body: some View {
        LazyVGrid(columns: gridItems) {
            ForEach(items) {
                item in
                itemViewBuilder(item)
                    .padding(.all, 4.0)
                    .background(
                        item == selected ? Circle().stroke(lineWidth: 2.0) : nil
                    )
                    .onTapGesture {
                        withAnimation {
                            selected = item
                        }
                    }
            }
        }
    }
}
