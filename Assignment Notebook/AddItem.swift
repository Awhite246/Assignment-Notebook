//
//  AddItem.swift
//  Assignment Notebook
//
//  Created by Student on 1/20/22.
//

import SwiftUI

struct AddItem: View {
    @ObservedObject var assignments: Assignment
    @State private var subject = ""
    @State private var homework = ""
    @State private var dueDate = Date()
    @Environment(\.presentationMode) var presentationMode
    static let subjects = ["Math", "Science", "English", "World Language", "History", "PE", "Mobile Apps"]
    let backgroundImage : Int
    var body: some View {
        NavigationView {
            Image("background \(backgroundImage)")
                .resizable()
                .frame(width: 400, height: 800, alignment: .center)
                .overlay(
                    Form {
                        Picker("Subject", selection: $subject) {
                            ForEach(Self.subjects, id: \.self) { subject in
                                Text(subject)
                                    .foregroundColor(subjectColor(color: subject))
                            }
                            
                        }
                        TextField("Homework", text: $homework)
                        DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                    }
                    .navigationBarTitle("Add New Assignment", displayMode: .inline)
                    .navigationBarItems(
                        leading: Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "x.square")
                                .imageScale(.large)
                        },
                        trailing: Button("Save"){
                            let item = AssignmentItem(id: UUID(), subject: subject, homework: homework, dueDate: dueDate)
                            assignments.assignment.append(item)
                            presentationMode.wrappedValue.dismiss()
                        }
                        .disabled(!(subject.count > 0 && homework.count > 0)))
                    .onAppear {
                        // For list
                        UITableView.appearance().backgroundColor = .clear
                        // For list cells
                        UITableViewCell.appearance().backgroundColor = .clear
                        // navigation view
                        UITableView.appearance().backgroundColor = .clear
                    }
                )
        }
        .preferredColorScheme(.dark)
    }
    func subjectColor (color : String) -> Color {
        switch color {
        case "Math":
            return .red
        case "Science":
            return .green
        case "English":
            return .blue
        case "World Language":
            return .pink
        case "History":
            return .orange
        case "PE":
            return .purple
        case "Mobile Apps":
            return .yellow
        default:
            return .black
        }
    }
    
}

struct AddItem_Previews: PreviewProvider {
    static var previews: some View {
        AddItem(assignments: Assignment(), backgroundImage: 1)
    }
}
