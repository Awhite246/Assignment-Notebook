//
//  Assignment.swift
//  Assignment Notebook
//
//  Created by Student on 1/19/22.
//

import Foundation

class Assignment: ObservableObject {
    @Published var assignment = [AssignmentItem(subject: "Math", homework: "Worksheet 5", dueDate: Date()), AssignmentItem(subject: "Science", homework: "Lab", dueDate: Date()), AssignmentItem(subject: "English", homework: "Y", dueDate: Date())]
}
