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
    @State private var dummy = Color.black
    var body: some View {
        NavigationView {
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
                leading: Button("Cancel"){
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save"){
                    let item = AssignmentItem(id: UUID(), subject: subject, homework: homework, dueDate: dueDate)
                    assignments.assignment.append(item)
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(!(subject.count > 0 && homework.count > 0)))
        }
    }
    func subjectColor (color : String) -> Color {
        switch color {
        case "Math":
            return ColorList().cMath
        case "Science":
            return ColorList().cScience
        case "English":
            return ColorList().cEnglish
        case "World Language":
            return ColorList().cWorld
        case "History":
            return ColorList().cHistory
        case "PE":
            return ColorList().cPE
        case "Mobile Apps":
            return ColorList().cMobile
        default:
            return .black
        }
    }
    func changeColor (subject : String, color : Color) {
        switch subject {
        case "Math":
            //ColorList()
            break
        case "Science":
            break
        case "English":
            break
        case "World Language":
            break
        case "History":
            break
        case "PE":
            break
        case "Mobile Apps":
            break
        default:
            break
        }
    }
}

struct AddItem_Previews: PreviewProvider {
    static var previews: some View {
        AddItem(assignments: Assignment())
    }
}
