//
//  Task.swift
//  ToDoSwiftUIFirebasePractice
//
//  Created by Kelsey Steven on 7/18/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Task: Identifiable, Codable {
    @DocumentID var id: String?
    var text: String
    var isComplete: Bool
}
