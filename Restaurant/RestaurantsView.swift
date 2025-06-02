//
//  ContentView.swift
//  Restaurants
//
//  Created by piotr koscielny on 30/5/25.
//
import SwiftUI

struct RestaurantsView: View {
    private let viewModel = RestaurantsViewModel()
    @State private var selectedIndex: Int? = nil
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                HStack(spacing: 12) {
                    ForEach(0..<4) { index in
                        let titles = ["fast food", "sandwitch", "Pizza", "Coffe"]
                        Button(titles[index]) {
                            selectedIndex = selectedIndex == index ? nil : index
                        }
                        .font(.subheadline)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(selectedIndex == index ? Color.purple : Color.white)
                        .foregroundColor(selectedIndex == index ? .white : .black)
                        .cornerRadius(10)
                    }
                }
                .padding(.horizontal)

                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.restaurants, id: \.id) { restaurant in
                            NavigationLink(destination: RestaurantDetailView(viewModel: RestaurantDetailViewModel(model: restaurant))) {
                                restaurantCard(restaurant: restaurant)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                }
                .navigationTitle("Restaurants")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $searchText)
            }
        }
    }

    @ViewBuilder
    private func restaurantCard(restaurant: RestaurantModel) -> some View {
        ZStack {
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(restaurant.name)
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)

                    Text(restaurant.type)
                        .foregroundColor(.white.opacity(0.85))
                        .font(.subheadline)

                    HStack(spacing: 4) {
                        ForEach(0..<5, id: \.self) { index in
                            Image(systemName: index < restaurant.rating ? "star.fill" : "star")
                                .resizable()
                                .frame(width: 12, height: 12)
                                .foregroundColor(.yellow)
                        }
                        HStack {
                            Image(systemName: "location")
                                .foregroundColor(.white)
                                .font(.caption)
                            
                            Text("\(String(format: "%.1f", restaurant.distance)) km")
                                .foregroundColor(.white)
                                .font(.caption)
                        }
                        .padding(.leading, 26)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)

                Image(restaurant.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 110, height: 120)
                    .clipShape(TrapezRightClip())
                    .clipped()
            }
        }
        .frame(height: 120)
        .background(Color.purple)
        .cornerRadius(15)
        .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 2))
    }
    private struct TrapezRightClip: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            path.move(to: CGPoint(x: rect.minX + 20, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.closeSubpath()
            return path
        }
    }
}

#Preview {
    RestaurantsView()
}
