//
//  CalorieHistoryView.swift
//  CalorieTracker
//
//  Created by Justin Ly on 12/26/24.
//

import SwiftUI

struct CalorieHistoryView: View {
    @ObservedObject var viewModel: CalorieTrackerViewModel
    @State private var today = Date()

    var body: some View {
        NavigationView {
            VStack {
                headerView()
                calendarGrid()
            }
            .navigationTitle("Calorie History")
            .onAppear {
                startMidnightTimer()
            }
        }
    }

    private func headerView() -> some View {
        VStack {
            Text(currentMonth())
                .font(.largeTitle)
                .bold()
                .padding(.top)

            HStack {
                ForEach(["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"], id: \.self) { day in
                    Text(day)
                        .font(.headline)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal)
        }
    }

    private func calendarGrid() -> some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 50, maximum: 70)), count: 7), spacing: 20) {
            ForEach(generateDatesForCurrentMonth(), id: \.self) { date in
                calendarCell(for: date)
            }
        }
        .padding()
    }

    private func calendarCell(for date: Date) -> some View {
        let formattedDateKey = formattedDate(date)
        let isTodayDate = isToday(date)
        let calories = viewModel.calorieHistory[formattedDateKey] ?? 0
        let exceedsGoal = calories > Int(viewModel.dailyCalorieGoal)

        return VStack(spacing: 5) {
            Text("\(Calendar.current.component(.day, from: date))")
                .font(.subheadline)
                .foregroundColor(isTodayDate ? .blue : .primary)
                .frame(maxWidth: .infinity)

            if calories > 0 {
                Text("\(calories) cal")
                    .font(.footnote)
                    .foregroundColor(exceedsGoal ? .red : .green)
            } else {
                Text("--")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
        .frame(minWidth: 45, minHeight: 60)
        .background(isTodayDate ? Color.yellow.opacity(0.3) : Color.clear)
        .cornerRadius(8)
    }

    private func isToday(_ date: Date) -> Bool {
        Calendar.current.isDate(date, inSameDayAs: today)
    }

    private func generateDatesForCurrentMonth() -> [Date] {
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: today)!
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: today))!

        return range.compactMap { day in
            calendar.date(byAdding: .day, value: day - 1, to: startOfMonth)
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }

    private func currentMonth() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: today)
    }

    private func startMidnightTimer() {
        let calendar = Calendar.current
        let now = Date()
        let nextMidnight = calendar.nextDate(after: now, matching: DateComponents(hour: 0, minute: 0), matchingPolicy: .nextTime)!

        let timeInterval = nextMidnight.timeIntervalSince(now)

        DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval) {
            self.today = Date()
            self.startMidnightTimer()
        }
    }
}
