//
//  ToDoList.swift
//  ToDoSwiftUIFirebasePractice
//
//  Created by Kelsey Steven on 7/18/23.
//

import SwiftUI

struct ToDoList: View {
    @EnvironmentObject var taskManager: TaskManager
    
    var body: some View {
        ScrollView {
            ForEach(taskManager.tasks, id: \.id) { task in
                TaskRow(task: task)
                    .environmentObject(taskManager)
                    .onTapGesture {
                        taskManager.toggleTaskComplete(toUpdate: task)
                    }
            }
        }
    }
}

struct ToDoList_Previews: PreviewProvider {

    static var previews: some View {
        let manager: TaskManager = TaskManagerMock()
        ToDoList()
            .environmentObject(manager)
    }
}


