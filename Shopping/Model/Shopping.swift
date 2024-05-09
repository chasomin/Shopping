//
//  Shopping.swift
//  Shopping
//
//  Created by 차소민 on 5/9/24.
//

import Foundation

struct Shopping: Decodable, Hashable {
    var total: Int
    let start: Int
    let display: Int
    var items: [Item]
    
    var totalCount: String {
        "\(total.formatted()) 개의 검색 결과"
    }
}

struct Item: Decodable, Hashable {
    var title: String
    let link: String
    let image: String
    let lprice: String
    let hprice: String
    let mallName: String
    let productId: String
    let productType: String
    let brand: String
    let maker: String
    let category1: String
    let category2: String
    let category3: String
    let category4: String
    
    var titleFilter: String {
        let filterTitle = title.replacingOccurrences(of: "<b>", with: "")
        let resultTitle = filterTitle.replacingOccurrences(of: "</b>", with: "")
        return resultTitle
    }
}
