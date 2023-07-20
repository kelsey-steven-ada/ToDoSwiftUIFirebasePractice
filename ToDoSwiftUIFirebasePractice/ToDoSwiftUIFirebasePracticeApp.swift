//
//  ToDoSwiftUIFirebasePracticeApp.swift
//  ToDoSwiftUIFirebasePractice
//
//  Created by Kelsey Steven on 7/18/23.
//

import SwiftUI
import Firebase

@main
struct ToDoSwiftUIFirebasePracticeApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(taskManager: TaskManager())
        }
    }
}
