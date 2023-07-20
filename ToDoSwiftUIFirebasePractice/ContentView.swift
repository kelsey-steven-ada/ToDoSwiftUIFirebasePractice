//
//  ContentView.swift
//  ToDoSwiftUIFirebasePractice
//
//  Created by Kelsey Steven on 7/18/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var taskManager: TaskManager
    
    var body: some View {
        VStack {
            VStack {
                TitleRow()
                ToDoList()
                    .environmentObject(taskManager)
            }
            .background(Color("LightBlue"))
            NewTaskField()
                .environmentObject(taskManager)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let manager: TaskManager = TaskManagerMock()
        ContentView(taskManager: manager)
    }
}
