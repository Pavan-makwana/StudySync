# 📘 StudySync - Flutter Frontend

**StudySync** is a modern, mobile-friendly Flutter application designed to enhance student learning and academic organization. It allows learners to access courses, manage their study programs, and track progress — all within a clean, intuitive UI.  
This repository contains the **frontend Flutter application** for the StudySync project.

---

## Project Overview

StudySync aims to simplify digital learning for students while providing admins an efficient way to publish and manage educational programs.  
The **frontend app** focuses on responsive design, clear navigation, and smooth user experience built entirely with **Flutter**.

---

## Objectives

- Build a **user-friendly mobile interface** for students and admins.  
- Support **program discovery, enrollment, and progress tracking**.  
- Establish a scalable Flutter project structure for future extensions.  
- Implement a clean, modular, and maintainable codebase using **best practices** in Flutter UI development.

---

## Target Users

### Learners
High school and university students who want to manage tasks, collaborate with peers, and track their study progress

---

## Core Features (MVP)

User Authentication (Email/Google Sign-In)
1.  Personal Dashboard displaying tasks, streaks, and daily goals
2.  Task Management – Create, edit, and track study or project tasks
3.  Group Workspaces for collaboration and shared task boards
4.  Reminders and notifications for upcoming deadlines
5.  Progress Analytics showing completion charts and streaks (for future updates)
6.  Clean, responsive UI built with Flutter components


---

## App Navigation Flow

| Screen | Description | Navigation |
|:-------|:-------------|:------------|
| **Login** | Entry screen with sign-in fields | → Home |
| **Home** | Displays overview and quick links | → Program Listing / Profile |
| **Program Listing** | Shows all available courses | → Program Details |
| **Program Details** | Detailed info of a selected course | ← Back to Listing |
| **Profile** | User info and settings | ← Back to Home |

---

## Project Structure


```
lib/
├── main.dart                # Entry point of the app
├── screens/
│   ├── login_screen.dart
│   ├── home_screen.dart
│   ├── program_list_screen.dart
│   ├── program_detail_screen.dart
│   └── profile_screen.dart
├── widgets/
│   ├── custom_button.dart
│   ├── program_card.dart
│   └── navigation_bar.dart
├── models/
│   └── program_model.dart
└── utils/
└── constants.dart
```


---

## Tech Stack

- **Framework:** Flutter (Dart)
- **UI:** Material Design Widgets
- **State Management:** Provider (planned for later stages)
- **Version Control:** Git + GitHub

---

## Setup Instructions

1. **Clone this repository**
   bash
   git clone https://github.com/syedhuzyfaali/Flutter-Virtual-Internship.git
   cd studysphere-frontend


2. **Install dependencies**

   bash
   flutter pub get
   

3. **Run the app**

   bash
   flutter run
   

---




##  Roadmap (Next Steps)
* [ ] Build the app UI
* [ ] Integrate backend API for authentication and program data.
* [ ] Add persistent state management.
* [ ] Implement search and filter functionality.
* [ ] Add user settings and dark mode.

---

We have created the prototype, here are the screenshots

<img width="340" height="681" alt="login page" src="https://github.com/user-attachments/assets/8c1c4ea6-aa7d-4b98-85f0-ea0449c5c125" />
<img width="339" height="684" alt="dashboard" src="https://github.com/user-attachments/assets/ab34c964-d0f1-45eb-919e-44689ae3710f" />
<img width="340" height="680" alt="sign-up page" src="https://github.com/user-attachments/assets/65aa8421-df51-43c9-8d92-751dcc961e92" />
<img width="340" height="679" alt="program listing" src="https://github.com/user-attachments/assets/e3d2202e-aa29-485d-928c-39d3d6dbbedd" />
<img width="343" height="680" alt="program details page" src="https://github.com/user-attachments/assets/df54cc26-cb10-42df-b592-a6cf86ad04da" />



⭐ **If you find this useful, don’t forget to star the repo!**



---

