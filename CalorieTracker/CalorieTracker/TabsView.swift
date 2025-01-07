//
//  TabsView.swift
//  CalorieTracker
//
//  Created by Justin Ly on 12/26/24.
//
import SwiftUI

struct TabsView: View {
    @StateObject private var viewModel = CalorieTrackerViewModel()

    var body: some View {
        TabView {
            ContentView(viewModel: viewModel)
                .tabItem {
                    Label("Tracker", systemImage: "flame.fill")
                }

            CalorieHistoryView(viewModel: viewModel)
                .tabItem {
                    Label("History", systemImage: "calendar")
                }
        }
    }
}

