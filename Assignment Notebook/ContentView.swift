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
    @State private var showingSettings = false
    //variable to be able to check the edit mode state
    @State var mode: EditMode = .inactive
    @State public var colorList = ColorList()
    @State private var backgroundImage = 4
    var body: some View {
        NavigationView {
            Image("background \(backgroundImage)")
                .resizable()
                .frame(width: 400, height: 800, alignment: .center)
                .overlay(
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
                                //hides date if in edit mode, so there is more room for homework
                                Text(mode.isEditing ? "" : "\(item.dueDate, style: .date)")
                            }
                        }
                        .onMove(perform: { indices, newOffset in
                            assignmentList.assignment.move(fromOffsets: indices, toOffset: newOffset)
                        })
                        .onDelete(perform: { indexSet in
                            assignmentList.assignment.remove(atOffsets: indexSet)
                        })
                    }
                    .navigationBarTitle("Assignment Notebook", displayMode: .inline)
                    .navigationBarItems(leading: EditButton())
                    .fullScreenCover(isPresented: $showingAddItem, content: {
                        AddItem(assignments: assignmentList, backgroundImage: backgroundImage)
                    })
                    .navigationBarItems(
                        leading:
                            EditButton(),
                        trailing:
                        Button(action: {
                            if (mode.isEditing) {
                                showingSettings = true
                            } else {
                                showingAddItem = true
                            }
                        }) {
                            Image(systemName: mode.isEditing ? "gearshape" : "plus.app")
                        .imageScale(.large)
                        })
                    //assignes mode variable to the current state edit mode is in
                    .environment(\.editMode, $mode)
                )
        }
        .preferredColorScheme(.dark)
    }
    
    //color codes subjects for easier reading
    func subjectColor (color : String) -> Color {
        switch color {
        case "Math":
            return colorList.cMath
        case "Science":
            return colorList.cScience
        case "English":
            return colorList.cEnglish
        case "World Language":
            return colorList.cWorld
        case "History":
            return colorList.cHistory
        case "PE":
            return colorList.cPE
        case "Mobile Apps":
            return colorList.cMobile
        default:
            return .black
        }
    }
    //Makes the background color of the list clear so you can see the image behind it
    init() {
        // For list
        UITableView.appearance().backgroundColor = .clear
        // For list cells
        UITableViewCell.appearance().backgroundColor = .clear
        // navigation view
        UITableView.appearance().backgroundColor = .clear
        
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
