//
//  ShoppingView.swift
//  Shopping
//
//  Created by 차소민 on 5/9/24.
//

import SwiftUI

struct ShoppingView: View {
    @StateObject private var viewModel = ShoppingViewModel()
    
    private var columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, alignment: .leading, content: {
                ForEach(viewModel.output.shoppingData.items, id: \.self) { item in
                    rowView(data: item)
                }
            })
        }
        .task {
            viewModel.input.viewOnAppear.send(())
        }
    }
}

#Preview {
    ShoppingView()
}


struct rowView: View {
    let data: Item
    var body: some View {
        LazyVStack(alignment: .leading) {
            AsyncImage(url: URL(string: data.image)) { image in
                image
                    .resizable()
                    .frame(width: 100, height: 100)
                
            } placeholder: {
                Image(systemName: "smiley")
                    .frame(width: 100, height: 100)
            }
                
            Text(data.brand)
                .font(.body.bold())
            Text(data.titleFilter)
                .font(.callout)
        }
        .padding()
    }
}
