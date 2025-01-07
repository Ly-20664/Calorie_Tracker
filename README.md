# Calorie_Tracker

## Overview
Calorie Tracker is an iOS application built with SwiftUI that allows users to manage their daily calorie intake. The app enables users to log food items, set calorie goals, and visualize their calorie consumption history in a calendar view.

## Features
- **Calorie Tracking**: Add, edit, and remove food items to track calorie intake for the current day.
- **Daily Goals**: Set a customizable daily calorie goal and see if the total exceeds the limit.
- **Calendar History**: View historical calorie consumption in a calendar format, with highlights for days when the goal was exceeded.
- **Automatic Reset**: Clears the tracker tab at midnight to start fresh for the new day, while preserving historical data in the calendar.

## Technologies Used
- **Swift**: Core programming language for the application.
- **SwiftUI**: Framework for building the app's user interface.
- **Combine**: Framework used for state management and reactive programming.

## Files
### Core Files
- `CalorieTrackerViewModel.swift`: Manages app logic, state, and daily resets.
- `FoodItem.swift`: Data model for individual food items.

### Views
- `ContentView.swift`: Main tracker view for adding and managing food items.
- `CalorieHistoryView.swift`: Calendar view to display calorie history.

## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/calorie-tracker.git
   ```
2. Open the project in Xcode:
   ```bash
   cd calorie-tracker
   open CalorieTracker.xcodeproj
   ```
3. Run the app on a simulator or device.

## Usage
1. Open the app.
2. Use the tracker tab to add, edit, or delete food items.
3. Adjust the daily calorie goal using the slider.
4. Switch to the calendar tab to view historical data and see if goals were exceeded.
5. At midnight, the tracker tab will automatically reset to a blank state.

## Contributing
Contributions are welcome! Please follow these steps:
1. Fork the repository.
2. Create a new branch (`git checkout -b feature-name`).
3. Commit your changes (`git commit -m 'Add feature'`).
4. Push to the branch (`git push origin feature-name`).
5. Create a pull request.

Images/Pictures of the program ~

Intial preview:
![Base](https://github.com/user-attachments/assets/3e7a4880-349f-4e42-8aca-45f0ad7ebc02)

Adding Item:
![Added_Item](https://github.com/user-attachments/assets/b96b960d-2506-498e-bc2b-1ef19f6f52e0)

Calorie Over Limit:
![Calorie_Over](https://github.com/user-attachments/assets/9115fe63-0a71-4dda-af3e-49d59a464660)

Calorie History:
![Calorie_History](https://github.com/user-attachments/assets/27a6cad9-9329-4b79-ab61-c59b5edd7523)

Calorie History Updated:
![Calender_Updated](https://github.com/user-attachments/assets/543d8c55-43a2-4202-8902-b09596bbac04)

Tracker Tab Updated:
![Tracker_Updated](https://github.com/user-attachments/assets/9415c7ae-306f-4965-b469-09d28338078f)

## Contact
For questions or feedback, please contact Justin Ly at Justinly0890@gmail.com


