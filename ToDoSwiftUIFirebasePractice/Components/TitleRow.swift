//
//  TitleRow.swift
//  ToDoSwiftUIFirebasePractice
//
//  Created by Kelsey Steven on 7/18/23.
//

import SwiftUI

struct TitleRow: View {
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "checkmark.square")
                .background(.green)
                .cornerRadius(5)
                .foregroundColor(.white)
                .padding(.leading)

            Text("To-Do List")
                .font(.title).bold()
                .frame(maxWidth: .infinity)
            
            Image(systemName: "checkmark.square")
                .background(.green)
                .cornerRadius(5)
                .foregroundColor(.white)
                .padding(.trailing)
        }
        .padding()
    }
}

struct TitleRow_Previews: PreviewProvider {
    static var previews: some View {
        TitleRow()
            .background(Color("LightBlue"))
    }
}
