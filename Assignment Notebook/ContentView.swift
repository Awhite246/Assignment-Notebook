//
//  ContentView.swift
//  Assignment Notebook
//
//  Created by Student on 1/14/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var assignmentList = Assignment()
    var body: some View {
        NavigationView {
            List {
                ForEach(assignmentList.assignment) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.subject)
                                .font(.headline)
                            Text(item.homework)
                        }
                        Spacer()
                        Text(item.dueDate, style: .date)
                    }
                }
                .onMove(perform: { indices, newOffset in assignmentList.assignment.move(fromOffsets: indices, toOffset: newOffset)
                })
                .onDelete(perform: { indexSet in assignmentList.assignment.remove(atOffsets: indexSet)
                })
            }
            .navigationBarTitle("To Do List")
            .navigationBarItems(leading: EditButton())
        }
    }
}

struct AssignmentItem: Identifiable, Codable {
    var id = UUID()
    var subject = String()
    var homework = String()
    var dueDate = Date()
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
