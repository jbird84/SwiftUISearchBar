//
//  ContentView.swift
//  SwiftUISearchBar
//
//  Created by Kinney Kare on 5/19/21.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    let emojis = [
        "Happy ð",
        "Sad ð­",
        "Angry ðĄ",
        "Surprised ðģ",
        "Annoyed ð",
        "Sick ðĪ",
        "Cool ð",
        "Angel ð",
        "Silly ðĪŠ",
        "Hot ðĨĩ",
        "Tired ðĨą",
        "Cold ðĨķ"
    ]
    
    @State var searchText = ""
    @State var searching = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                SearchView(searchText: $searchText, searching: $searching).padding(.all, 10)
                
                List {
                    ForEach(emojis.filter({ (theEmoji: String) -> Bool in
                        return theEmoji.hasPrefix(searchText) || searchText == ""
                    }), id: \.self) { emoji in
                        Text(emoji)
                    }
                }
                .gesture(DragGesture()
                            
                            .onChanged({ _ in
                                UIApplication.shared.dismissKeyboard()
                            })
                )
                .listStyle(GroupedListStyle())
                .navigationTitle(searching ? "Searching" : "Emojis")
                .toolbar {
                    if searching {
                        Button("Cancel") {
                            searchText = ""
                            withAnimation {
                                searching = false
                                UIApplication.shared.dismissKeyboard()
                            }
                        }
                    }
                }
            }
        }
    }
}

extension UIApplication {
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
