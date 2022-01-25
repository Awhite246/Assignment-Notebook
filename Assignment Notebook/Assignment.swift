//
//  Assignment.swift
//  Assignment Notebook
//
//  Created by Student on 1/19/22.
//

import Foundation

class Assignment: ObservableObject {
    @Published var assignment : [AssignmentItem] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(assignment) {
                UserDefaults.standard.set(encoded, forKey: "potato")
            }
        }
    }
    init() {
        if let assignment = UserDefaults.standard.data(forKey: "potato") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([AssignmentItem].self, from: assignment) {
                self.assignment = decoded
                return
            }
        }
        assignment = []
    }
}
