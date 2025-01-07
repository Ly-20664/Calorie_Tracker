//
//  CalorieTrackerViewModel.swift
//  CalorieTracker
//
//  Created by Justin Ly on 12/26/24.
//

import Foundation
import Combine

class CalorieTrackerViewModel: ObservableObject {
    @Published var foodItems: [FoodItem] = [] {
        didSet {
            updateCalorieHistoryForToday()
        }
    }
    @Published var calorieHistory: [String: Int] = [:]
    @Published var dailyCalorieGoal: Float = 2000
    private var cancellables: Set<AnyCancellable> = []

    init() {
        print("Initializing CalorieTrackerViewModel.")
        scheduleDailySave()
    }

    var totalCalories: Int {
        return foodItems.reduce(0) { $0 + $1.totalCalories }
    }

    func addFoodItem(name: String, calories: Int, servings: Int) {
        let newItem = FoodItem(name: name, calories: calories, servings: servings)
        foodItems.append(newItem)
    }

    func removeFoodItem(at index: Int) {
        foodItems.remove(at: index)
    }

    func updateFoodItem(at index: Int, name: String, calories: Int, servings: Int) {
        foodItems[index] = FoodItem(name: name, calories: calories, servings: servings)
    }

    func saveCaloriesForDate(_ date: String, totalCalories: Int) {
        calorieHistory[date] = totalCalories
    }

    private func updateCalorieHistoryForToday() {
        let todayKey = getFormattedDate(Date())
        calorieHistory[todayKey] = totalCalories
    }

    private func scheduleDailySave() {
        let now = Date()
        let calendar = Calendar.current
        let nextMidnight = calendar.nextDate(after: now, matching: DateComponents(hour: 0, minute: 0), matchingPolicy: .nextTime)!

        let timeInterval = nextMidnight.timeIntervalSince(now)
        DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval) { [weak self] in
            guard let self = self else { return }

            // Log when the function is triggered
            print("Midnight reached. Saving calories and resetting tracker.")

            let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
            let yesterdayKey = self.getFormattedDate(yesterday)

            // Save yesterday's calorie total
            self.saveCaloriesForDate(yesterdayKey, totalCalories: self.totalCalories)

            // Clear food items for the new day
            self.foodItems.removeAll()

            // Confirm the reset
            print("Food items cleared for the new day.")

            // Schedule for the next day
            self.scheduleDailySave()
        }
    }

    private func getFormattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}
