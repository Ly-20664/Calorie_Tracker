//
//  FoodItem.swift
//  CalorieTracker
//
//  Created by Justin Ly on 12/26/24.
//
import Foundation

struct FoodItem: Identifiable {
    let id = UUID()
    let name: String
    let calories: Int
    let servings: Int

    var totalCalories: Int {
        return calories * servings
    }
}

