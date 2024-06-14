//
//  ContentView.swift
//  Notes
//
//  Created by Shirley Averette on 6/7/24.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group {
            if viewModel.session != nil {
                NotesView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
