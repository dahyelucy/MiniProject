//
//  Product.swift
//  MiniProject
//
//  Created by 최다혜 on 2022/11/10.
//

import Foundation

public struct Product: Decodable {
    public let id: Int
    public let productName: String
    public let thumbnail: String
    public let price: Int
    
    init(
        id: Int,
        productName: String,
        thumbnail: String,
        price: Int
    ) {
        self.id = id
        self.productName = productName
        self.thumbnail = thumbnail
        self.price = price
    }
}

public struct ProductList: Decodable, MiniHttp {
    var productList: [Product]
}
