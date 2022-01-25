//
//  ContentView.swift
//  Assignment Notebook
//
//  Created by Student on 1/14/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var assignmentList = Assignment()
    @State private var showingAddItem = false
    //variable to be able to check the edit mode state
    @State var mode: EditMode = .inactive
    var body: some View {
        NavigationView {
            List {
                ForEach(assignmentList.assignment) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.subject)
                                .foregroundColor(subjectColor(color: item.subject))
                                .font(.headline)
                            Text(item.homework)
                        }
                        Spacer()
                        Text(item.dueDate, style: .date)
                    }
                }
                .onMove(perform: { indices, newOffset in
                    assignmentList.assignment.move(fromOffsets: indices, toOffset: newOffset)
                })
                .onDelete(perform: { indexSet in
                    assignmentList.assignment.remove(atOffsets: indexSet)
                })
            }
            .navigationBarTitle("To Do List", displayMode: .inline)
            .navigationBarItems(leading: EditButton())
            .sheet(isPresented: $showingAddItem, content: {
                AddItem(assignments: assignmentList)
            })
            .navigationBarItems(leading: EditButton(), trailing: Button(action: { showingAddItem = true}) {
                Image(systemName: "plus")
            })
            //assignes mode variable to the current state edit mode is in
            .environment(\.editMode, $mode)
        }
        .background(Image("notebook background"))
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
}
struct ColorList {
    var cMath = Color.red
    var cScience = Color.green
    var cEnglish = Color.blue
    var cWorld = Color.pink
    var cHistory = Color.orange
    var cPE = Color.purple
    var cMobile = Color.yellow
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
