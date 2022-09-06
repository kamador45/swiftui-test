//
//  ContentView.swift
//  Agence
//
//  Created by Kevin Amador Rios on 9/1/22.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("log_status") var logStatus: Bool = false
    var body: some View {
        if logStatus {
            //MARK: Home
            Home(logStatus: logStatus)
        } else {
            SignIn()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
