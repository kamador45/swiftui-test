//
//  TextFields.swift
//  Agence
//
//  Created by Kevin Amador Rios on 9/1/22.
//

import SwiftUI

struct EmailField: View {
    var title:String
    @Binding var text: String
    @FocusState var isEnable: Bool
    var TypeField: UITextContentType = .emailAddress
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            TextField(title, text: $text)
                .frame(width: UIScreen.main.bounds.width - 50, height: 45, alignment: .center)
                .padding([.horizontal], 4)
                .textContentType(TypeField)
                .keyboardType(.emailAddress)
                .focused($isEnable)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
            
        }
        .padding(.top, 30)
    }
}
