//
//  PasswordField.swift
//  Agence
//
//  Created by Kevin Amador Rios on 9/2/22.
//

import SwiftUI

struct PasswordField: View {
    
    var title: String
    @Binding var text:String
    @FocusState var isEnable: Bool
    var TypeField: UITextContentType = .password

    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            SecureField(title, text: $text)
                .frame(width: UIScreen.main.bounds.size.width - 50, height: 50, alignment: .center)
                .keyboardType(.default)
                .textContentType(TypeField)
                .focused($isEnable)
                .padding([.horizontal], 4)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
        }
    }
}
