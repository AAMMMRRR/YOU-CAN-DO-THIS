# YOU-CAN-DO-THIS

A Flutter-based To-Do List application that allows users to manage tasks with a user-friendly interface, Firebase authentication for secure access, and Hive for local data storage.

## Table of Contents
- [Features](#features)
- [Installation](#installation)
- [Dependencies](#dependencies)
- [Project Structure](#project-structure)
- [Logic Description](#logic-description)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Features
- **User Authentication**: Secure login and sign-up with email verification using Firebase Authentication.
- **Task Management**: Create, delete, and mark tasks as completed.
- **Local Storage**: Store tasks locally with Hive, linked to individual user accounts.
- **Responsive UI**: Clean design with gradient backgrounds and custom fonts for better readability.
- **Interactive Task List**: Tasks displayed with checkboxes for completion and swipe-to-delete functionality.
- **Task Creation Dialog**: Simple dialog for adding new tasks with input validation.

## Installation
1. **Clone the Repository**:
   - Clone the project from GitHub: `https://github.com/AAMMMRRR/YOU-CAN-DO-THIS`.
   - Navigate to the project directory.

2. **Install Flutter**:
   - Ensure Flutter is installed. Follow the official Flutter installation guide if needed.

3. **Install Dependencies**:
   - Run `flutter pub get` to install required packages.

4. **Set Up Firebase**:
   - Create a Firebase project in the Firebase Console.
   - Add your app (iOS, Android, or Web) to the Firebase project.
   - Download and place the Firebase configuration file (e.g., `google-services.json` for Android or `GoogleService-Info.plist` for iOS) in the appropriate directory.
   - Ensure Firebase project credentials are correctly configured.

5. **Run the App**:
   - Execute `flutter run` to launch the application.

## Dependencies
- Firebase Core: Initializes Firebase services.
- Firebase Authentication: Manages user login and sign-up.
- Hive and Hive Flutter: Handles local storage of tasks.
- Google Fonts: Provides custom typography.
- Flutter Slidable: Enables swipe-to-delete functionality for tasks.
- Flutter: Core framework for building the app.

Refer to the `pubspec.yaml` file for specific versions.

## Project Structure
- **Pages**:
  - Home Page: Displays the task list and allows task management.
  - Login Page: Handles user authentication (login and sign-up).
- **Utilities**:
  - Custom Button: Reusable button component.
  - Dialog Box: Interface for adding new tasks.
  - Task Tile: Displays individual tasks with interactive elements.
- **Data**:
  - Database: Manages task storage and retrieval using Hive.
- **Main**: Application entry point, initializes Firebase and Hive.
- **Firebase Options**: Stores Firebase configuration for different platforms.

## Logic Description
The application follows a straightforward logic flow to manage user authentication and task operations without delving into code specifics:

1. **App Initialization**:
   - The app starts by setting up Firebase for authentication and Hive for local storage.
   - It opens a storage box to save user-specific task data.

2. **User Authentication**:
   - **Login**:
     - Users enter their email and password.
     - The system checks if the credentials are valid and if the email is verified.
     - If valid and verified, the user is directed to the task list page.
     - If the email is not verified, a prompt to verify is shown with an option to resend the verification email.
     - Invalid inputs or credentials trigger error messages (e.g., "Incorrect password" or "User not found").
   - **Sign-Up**:
     - Users provide an email and password (minimum 6 characters).
     - The system validates the email format and password length.
     - If valid, a new user account is created, and a verification email is sent.
     - Users must verify their email before logging in.
   - **Sign-Out**:
     - Users can log out, returning to the login page.
     - The system ensures no tasks are accessible until the user logs in again.

3. **Task Management**:
   - **Task List Display**:
     - Upon successful login, the app loads tasks specific to the user from local storage.
     - If no tasks exist for the user, a default list (e.g., "Have Breakfast," "Attend meeting") is created.
     - Tasks are displayed as a list with a checkbox (to mark completion) and swipe-to-delete functionality.
   - **Adding Tasks**:
     - Users tap a button to open a dialog for entering a new task.
     - The system checks if the input is non-empty.
     - Valid tasks are added to the list and saved to local storage.
     - Empty inputs trigger a warning message.
   - **Updating Tasks**:
     - Checking/unchecking a task’s checkbox updates its completion status.
     - The updated task list is saved to local storage.
   - **Deleting Tasks**:
     - Swiping a task triggers its removal from the list.
     - The updated list is saved to local storage.
   - **Data Persistence**:
     - Tasks are stored locally and tied to the user’s unique ID, ensuring data is user-specific.
     - Changes (add, update, delete) are immediately saved to maintain consistency across sessions.

4. **User Interface**:
   - The login page shows input fields for email and password, a button to submit, and a toggle to switch between login and sign-up modes.
   - The home page features a task list, a logout button, and a floating button to add tasks.
   - Tasks are visually marked as completed (e.g., with a strikethrough) when checked.
   - The UI uses a gradient background and custom fonts for a polished look.

5. **Error Handling**:
   - Invalid inputs (e.g., empty fields, invalid email format) display user-friendly error messages.
   - Authentication errors (e.g., wrong password, email already in use) are caught and communicated clearly.
   - The app shows loading indicators during authentication or sign-out to prevent multiple submissions.

## Usage
1. **Accessing the App**:
   - Open the app and land on the login page.
   - Sign up with a valid email and password, then verify your email via the sent link.
   - Log in with verified credentials to access the task list.

2. **Managing Tasks**:
   - View all tasks on the home page.
   - Add a new task using the floating action button and entering a task description.
   - Mark tasks as completed by checking their checkboxes.
   - Delete tasks by swiping them.
   - Log out using the app bar’s logout button to return to the login page.

3. **Data Persistence**:
   - Tasks remain available across sessions for the same user account.
   - Each user’s tasks are isolated based on their unique ID.

## Contributing
Contributions are welcome! To contribute:
1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Make changes with clear, descriptive commits.
4. Push your branch and create a pull request.
5. Ensure your changes align with the app’s design and functionality.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.