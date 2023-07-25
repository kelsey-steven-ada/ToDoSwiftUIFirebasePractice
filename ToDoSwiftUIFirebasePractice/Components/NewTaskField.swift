//
//  NewTaskField.swift
//  ToDoSwiftUIFirebasePractice
//
//  Created by Kelsey Steven on 7/18/23.
//

import SwiftUI

struct NewTaskField: View {
    @EnvironmentObject var taskManager: TaskManager
    @State private var newTask = ""
    
    var body: some View {
        HStack {
            // We pass empty functions for the callbacks since we don't
            // want to trigger actions from the text field
            TextField(
                "Type a new task here",
                text: $newTask,
                onEditingChanged: { _ in },
                onCommit: { }
            )
            .frame(height: 52)
            .disableAutocorrection(true)
            
            Button {
                taskManager.addTask(text: newTask)
                newTask = ""
            } label: {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color("LightBlue"))
                    .cornerRadius(50)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(Color("LightGray"))
        .cornerRadius(50)
        .padding()
    }
}

struct NewTaskField_Previews: PreviewProvider {
    static var previews: some View {
        let manager: TaskManager = TaskManagerMock()
        NewTaskField()
            .environmentObject(manager)
    }
}
