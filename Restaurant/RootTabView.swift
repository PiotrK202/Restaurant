//
//  RootTabView.swift
//  Restaurants
//
//  Created by piotr koscielny on 2/6/25.
//

import SwiftUI

struct RootTabView: View {
    @State private var showSheet = false
    @State private var showPhoneEntry = false
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            RestaurantsView()
                .tabItem {
                    Image(systemName: "fork.knife")
                    Text("Restaurants")
                }
                .tag(0)
            
            Text("")
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Register")
                }
                .tag(1)
            
            NavigationView {
                List {
                    Section {
                        Label("Settings", systemImage: "gearshape")
                        Label("Help", systemImage: "questionmark.circle")
                    }
                }
                .listStyle(.insetGrouped)
                .navigationTitle("Settings")
            }
            
            .tabItem {
                Image(systemName: "gearshape")
                Text("settings")
            }
            .tag(2)
        }
        .onChange(of: selectedTab) { _, newValue in
            if newValue == 1 {
                showSheet = true
                selectedTab = 0
            }
        }
        .sheet(isPresented: $showSheet) {
            RegisterSheet(showPhoneEntry: $showPhoneEntry)
        }
    }
}
