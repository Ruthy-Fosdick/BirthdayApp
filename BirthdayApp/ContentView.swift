//
//  ContentView.swift
//  BirthdayApp
//
//  Created by Scholar on 6/6/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var friends: [Friend] = [Friend(name: "Gary",birthday: .now), Friend(name: "Bob",birthday: Date(timeIntervalSince1970:0))]
    @Environment(\.modelContext) private var context
    @State private var newname = ""
    @State private var newbirthday = Date.now
    var body: some View {
        NavigationStack{
            List(friends) {friend in
                HStack{
                    Text (friend.name)
                    Spacer()
                    Text(friend.birthday,format: .dateTime.month(.wide).day().year())
                } //end HStack
            }//end List
            .navigationTitle("Birthdays")
            .safeAreaInset(edge: .bottom) {
                VStack(alignment: .center, spacing: 20) {
                    Text ("newbirthday")
                        .font(.headline)
                    DatePicker(selection: $newbirthday,in:Date.distantPast...Date.now, displayedComponents: .date) {
                        TextField("Enter Name", text: $newname)
                            .textFieldStyle(
                             .roundedBorder)
                        
                        Button("save") {
                            let newfriend = Friend (name: newname, birthday: newbirthday)
                            context.insert(newfriend)
                            newname = ""
                            newbirthday = .now
                            }// button
                        .bold()
                    }//displayComponets
                    
                } //VStack
                .padding()
                .background(.bar)
            }// safeAreaInset
        }//end nav stack
    }//end body
}//end struct

#Preview {
    ContentView()
        .modelContainer(for: Friend.self, inMemory: true)
}
