//
//  RestaurantModel.swift
//  Restaurants
//
//  Created by piotr koscielny on 30/5/25.
//

import Foundation

struct RestaurantModel: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let image: String
    let menu: [String]
    let details: String
    let rating: Int
    let distance: Double
    let type: String
}
