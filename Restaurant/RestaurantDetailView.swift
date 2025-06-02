//
//  RestaurantView.swift
//  Restaurants
//
//  Created by piotr koscielny on 30/5/25.
//

import SwiftUI
import MapKit

struct RestaurantDetailView: View {
    let viewModel: RestaurantDetailViewModel
    @State private var presentLeaveReview = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Image(viewModel.model.image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 280)
                    .ignoresSafeArea(edges: .top)
                
                ZStack {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Details")
                            .font(.title3)
                            .fontWeight(.semibold)

                        Text(viewModel.model.details)
                            .font(.body)

                        HStack {
                            Text("Rating")
                                .font(.body)

                            Spacer()

                            ForEach(1...5, id: \.self) { star in
                                Image(systemName: star <= viewModel.model.rating ? "star.fill" : "star")
                                    .foregroundColor(.yellow)
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .padding(.horizontal, 20)
                }
                .offset(y: -40)
                .padding(.bottom, 16)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Menu")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.horizontal)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach([RestaurantsImages.menu, RestaurantsImages.menu2], id: \.self) { imageName in
                                ZStack(alignment: .bottomLeading) {
                                    Image(imageName)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 300, height: 200)
                                        .clipped()
                                        .cornerRadius(12)

                                    VStack(alignment: .leading, spacing: 6) {
                                        Text("Price for this food: €4")
                                            .foregroundColor(.white)
                                            .fontWeight(.heavy)
                                            .font(.subheadline)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 35)
                                    .background(Color.black)
                                    .cornerRadius(8)
                                    .padding(.bottom, 12)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                VStack(alignment: .leading, spacing: 12) {
                    Text("Map")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                    
                    RoundedRectangle(cornerRadius: 12)
                        .frame(height: 200)
                        .padding(.horizontal)
                        .overlay {
                            Map()
                                .cornerRadius(12)
                                .padding(.horizontal)
                        }
                }
                opinions()
            }
        }
        .sheet(isPresented: $presentLeaveReview) {
            ReviewView()
                .presentationDetents([.medium])
                .presentationDragIndicator(.hidden)
        }
        .tint(.black)
        .navigationBarBackButtonHidden(false)
        .toolbarBackground(.white, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
    
    @ViewBuilder
    private func opinions() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Reviews")
                        .font(.title2)
                        .fontWeight(.black)
                    
                    HStack(spacing: 4) {
                        ForEach(0..<5) { i in
                            Image(systemName: i < 4 ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                        }
                    }
                    
                    Text("128 ratings")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Button("Leave a review") {
                    presentLeaveReview.toggle()
                }
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.purple)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Pepe Pérez")
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        ForEach(0..<5, id: \.self) { _ in
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        }
                    }
                }
                
                Text("The best food in Valladolid all in one place. Plus, the beers are cheap. I definitely recommend it.")
                    .font(.subheadline)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Daniel Eloy")
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        ForEach(0..<5, id: \.self) { _ in
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        }
                    }
                }
                
                Text("The best food in Valladolid all in one place. Plus, the beers are cheap. I definitely recommend it.")
                    .font(.subheadline)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
        }
        .padding()
    }
    
}

#Preview {
    let model =
    RestaurantModel(name: "Starbucks", description: "A premium coffeehouse chain offering specialty coffee, teas, and pastries. Known for its cozy ambiance and customizable drinks.", image: RestaurantsImages.starbucks, menu:["Pumpkin Spice Latte (Seasonal)","Caramel Macchiato","Iced White Chocolate Mocha","Vanilla Sweet Cream Cold Brew","Double Smoked Bacon Sandwich","Cheese & Fruit Protein Box","Lemon Loaf Cake","Impossible Breakfast Sandwich","Matcha Crème Frappuccino","Chocolate Croissant"], details: "Starbucks is a beverage retailer and the world's leading coffeehouse chain, known for its specialty coffee and other beverages. The company also offers a variety of food items, including pastries, sandwiches, and snacks. Beyond its core business, Starbucks is known for its strong brand presence, global reach, and commitment to sustainability and community engagement.", rating: 5, distance: 1, type: "coffe")
    RestaurantDetailView(viewModel: RestaurantDetailViewModel(model: model))
}
