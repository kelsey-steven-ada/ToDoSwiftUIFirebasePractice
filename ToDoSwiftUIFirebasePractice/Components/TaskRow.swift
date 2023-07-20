//
//  TaskRow.swift
//  ToDoSwiftUIFirebasePractice
//
//  Created by Kelsey Steven on 7/18/23.
//

import SwiftUI

struct TaskRow: View {
    @EnvironmentObject var taskManager: TaskManager
    var task: Task
    
    var body: some View {
        HStack {
            // Show green checkmark if completed
            // and an empty black square if incomplete
            if task.isComplete {
                Image(systemName:"checkmark.square" )
                    .background(.green)
                    .cornerRadius(5)
                    .foregroundColor(.white)
            } else {
                Image(systemName: "square")
                    .foregroundColor(.black)
            }
            
            Text(task.text)
                .strikethrough(task.isComplete ,color: .green)
            
            Spacer()
            
            Button {
                taskManager.deleteTask(toDelete: task)
            } label: {
                Image(systemName: "trash.fill")
                    .foregroundColor(.red)
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 5)
        .background(.white)
        .cornerRadius(8)
    }
}

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        let manager: TaskManager = TaskManagerMock()
        List {
            TaskRow(
                task: Task(
                    id: "2",
                    text: "Pet the dogs",
                    isComplete: false
                )
            )
            .environmentObject(manager)
            TaskRow(
                task: Task(
                    id: "1",
                    text: "Go for a Walk",
                    isComplete: true
                )
            )
            .environmentObject(manager)
        }
    }
}
