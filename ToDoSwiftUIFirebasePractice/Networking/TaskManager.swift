//
//  TaskManager.swift
//  ToDoSwiftUIFirebasePractice
//
//  Created by Kelsey Steven on 7/19/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


class TaskManager: ObservableObject {
    @Published fileprivate(set) var tasks: [Task] = []

    // Create an instance of our Firestore database
    let db = Firestore.firestore()
    
    // On initialize of the TaskManager class, get the tasks from Firestore
    init() {
        getTasks()
    }
        
    func getTasks() {
        // Set up the snapshot listener
        db.collection("tasks").addSnapshotListener { querySnapshot, error in
            // If we don't have documents, exit the function
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(String(describing: error))")
                return
            }
            
            // Map the documents to our Task model
            self.tasks = documents.compactMap { document -> Task? in
                do {
                    // Converting each document into the Task model
                    // Note that data(as:) is a function available only in the
                    // FirebaseFirestoreSwift package - remember to import it at the top
                    return try document.data(as: Task.self)
                } catch {
                    // If we run into an error, print the error in the console
                    print("Error decoding document into Task: \(error)")

                    // Return nil if we run into an error.
                    // The compactMap will not include it in the final array
                    return nil
                }
            }
            
            // Sort the messages by whether they are completed, with incomplete at the top
            self.tasks.sort { !$0.isComplete && $1.isComplete }
        }
    }
    
    func addTask(text: String) {
        // If there is no message, just return
        guard !text.isEmpty else {
            return
        }
        
        // Create a new Task instance with the text parameter
        // and an isComplete value of false
        let newTask = Task(
            text: text,
            isComplete: false
        )
        
        do {
            // Create a new document in Firestore with the newTask variable above,
            // and use setData(from:) to convert the Task into Firestore data.
            try db.collection("tasks").document().setData(from: newTask)
            
        } catch {
            print("Error adding task to Firestore: \(error)")
        }
    }
    
    func toggleTaskComplete(toUpdate: Task) {
        guard let taskID = toUpdate.id else {
            print("Error: Task ID missing")
            return
        }
        
        let remoteRef = db.collection("tasks").document(taskID)
        remoteRef.updateData(["isComplete": !toUpdate.isComplete]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            }
        }
    }
    
    func deleteTask(toDelete: Task) {
        guard let taskID = toDelete.id else {
            print("Error: Task ID missing")
            return
        }
        
        db.collection("tasks").document(taskID).delete() { err in
            if let err = err {
                print("Error removing task: \(err)")
            }
        }
    }
}

internal class TaskManagerMock: TaskManager {
    override func getTasks() {
        self.tasks = [
            Task(
                id: "2",
                text: "Pet the dogs",
                isComplete: false
            ),
            Task(
                id: "1",
                text: "Go for a Walk",
                isComplete: true
            )
        ]
    }
    
    override func addTask(text: String) {
        self.tasks.append(
            Task(id: "\(UUID())", text: text, isComplete: false)
        )
        self.tasks.sort { !$0.isComplete && $1.isComplete }
    }
    
    override func toggleTaskComplete(toUpdate: Task) {
        tasks = tasks.map { currTask -> Task in
            if currTask.id == toUpdate.id {
                return Task(
                    id: toUpdate.id,
                    text: toUpdate.text,
                    isComplete: !toUpdate.isComplete
                )
            }
            
            return currTask
        }
        self.tasks.sort { !$0.isComplete && $1.isComplete }
    }
    
    override func deleteTask(toDelete: Task) {
        tasks = tasks.filter { task in
            return task.id != toDelete.id
        }
    }
}
