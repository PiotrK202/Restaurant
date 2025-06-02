//
//  RestaurantDetailViewModel.swift
//  Restaurants
//
//  Created by piotr koscielny on 30/5/25.
//

import Foundation
import UIKit

@Observable
final class RestaurantDetailViewModel {
    let model: RestaurantModel
    init(model: RestaurantModel) {
        self.model = model
    }
}
