//
//  ContentView.swift
//  Assignment Notebook
//
//  Created by Student on 1/14/22.
//a

import SwiftUI

struct ContentView: View {
    @ObservedObject var assignmentList = Assignment()
    @State private var showingAddItem = false
    @State private var showingSettings = false
    //variable to be able to check the edit mode state
    @State var mode: EditMode = .inactive
    var body: some View {
        NavigationView {
            //background image
            Image("background 7")
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
                        AddItem(assignments: assignmentList)
                    })
                    .navigationBarItems(
                        leading:
                            EditButton(),
                        trailing:
                        Button(action: {
                            showingAddItem = true
                        }) {
                            Image(systemName: "plus.app")
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
    //Makes the background color of the list clear so you can see the image behind it
    init() {
        // For list
        UITableView.appearance().backgroundColor = .clear
        // For list cells
        UITableViewCell.appearance().backgroundColor = .clear
        
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
