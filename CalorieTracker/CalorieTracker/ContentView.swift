import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: CalorieTrackerViewModel
    @State private var foodName: String = ""
    @State private var calories: String = ""
    @State private var servings: String = ""
    @State private var editingIndex: Int? // Tracks the index of the item being edited

    var body: some View {
        NavigationView {
            VStack {
                // Title with Stylish Divider
                VStack(spacing: 10) {
                    Text("Calorie Tracker")
                        .font(.largeTitle)
                        .bold()
                        .shadow(color: .gray, radius: 2, x: 0, y: 2) // Shadow effect
                    
                    // Custom Divider
                    Divider()
                        .frame(height: 2)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(1)
                        .padding(.horizontal, 40) // Add padding for aesthetics
                }
                .padding(.top)

                // Total Calories with Shadow
                VStack {
                    Text("Total Calories")
                        .font(.headline)
                    Text("\(viewModel.totalCalories) cal")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(viewModel.totalCalories > Int(viewModel.dailyCalorieGoal) ? .red : .green)
                }
                .padding()

                // Adjustable Daily Goal with Shadow
                VStack {
                    Text("Set Your Daily Calorie Goal")
                        .font(.headline)
                    
                    Text("\(Int(viewModel.dailyCalorieGoal)) cal")
                        .font(.title2)
                        .foregroundColor(.blue)
                    Slider(value: $viewModel.dailyCalorieGoal, in: 500...5000, step: 100)
                        .padding()
                }

                // Add or Edit Food Items with Button Shadow
                VStack(spacing: 10) {
                    TextField("Food Name", text: $foodName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Calories per Serving", text: $calories)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                    
                    TextField("Servings", text: $servings)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                    
                    Button(action: {
                        if let cal = Int(calories), let serv = Int(servings), !foodName.isEmpty {
                            if let index = editingIndex {
                                // Update the existing item
                                viewModel.updateFoodItem(at: index, name: foodName, calories: cal, servings: serv)
                                editingIndex = nil
                            } else {
                                // Add a new item
                                viewModel.addFoodItem(name: foodName, calories: cal, servings: serv)
                            }
                            // Reset input fields
                            foodName = ""
                            calories = ""
                            servings = ""
                        }
                    }) {
                        Text(editingIndex == nil ? "Add Food" : "Update Food")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(color: .blue.opacity(0.5), radius: 4, x: 0, y: 4) // Button shadow
                    }
                }
                .padding()

                // List of Food Items with Shadows
                List {
                    ForEach(viewModel.foodItems.indices, id: \.self) { index in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(viewModel.foodItems[index].name)
                                    .font(.headline)
                                    .shadow(color: .gray, radius: 1, x: 0, y: 1) // Shadow for name
                                Text("\(viewModel.foodItems[index].servings) servings x \(viewModel.foodItems[index].calories) cal/serving")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .shadow(color: .gray.opacity(0.5), radius: 1, x: 0, y: 1) // Subtle shadow
                            }
                            Spacer()
                            Text("\(viewModel.foodItems[index].totalCalories) cal")
                                .font(.headline)
                                .foregroundColor(viewModel.foodItems[index].totalCalories > Int(viewModel.dailyCalorieGoal) ? .red : .green)
                                .shadow(color: .red.opacity(0.5), radius: 2, x: 0, y: 2) // Shadow for calories
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                viewModel.removeFoodItem(at: index)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            Button {
                                let item = viewModel.foodItems[index]
                                foodName = item.name
                                calories = "\(item.calories)"
                                servings = "\(item.servings)"
                                editingIndex = index
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}
