//
//  ProductDetail.swift
//  MiniProject
//
//  Created by 최다혜 on 2022/11/10.
//

import Foundation

public struct ProductDetail: Decodable, MiniHttp {
    public var productName: String
    public var thumbnail: String
    public var price: Int
    public var maker: String
    public var model: String
    
    init(
        productName: String,
        thumbnail: String,
        price: Int,
        maker: String,
        model: String
    ) {
        self.productName = productName
        self.thumbnail = thumbnail
        self.price = price
        self.maker = maker
        self.model = model
    }
}
