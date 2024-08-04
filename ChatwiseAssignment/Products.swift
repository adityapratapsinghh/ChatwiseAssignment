//
//  Products.swift
//  ChatwiseAssignment
//
//  Created by Aditya on 05/08/24.
//

import Foundation

struct Product: Codable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let thumbnail: String
}

struct ProductsResponse: Codable {
    let products: [Product]
}

