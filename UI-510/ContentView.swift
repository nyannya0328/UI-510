//
//  ContentView.swift
//  UI-510
//
//  Created by nyannyan0328 on 2022/03/17.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
       Home()
            .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
