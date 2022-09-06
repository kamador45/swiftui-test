//
//  ListProduct.swift
//  Agence
//
//  Created by Kevin Amador Rios on 9/2/22.
//

import SwiftUI
import StoreKit

struct ListProduct: View {
    
    //MARK: List products
    @State var data = [
        Products(id: 1,name: "Van Hallen", image: "van_hallen"),
        Products(id: 2,name: "Linkin Park", image: "linkin_park"),
        Products(id: 3,name: "AudioSlave", image: "audio_slave"),
        Products(id: 4,name: "Nirvana", image: "nirvana"),
    ]
    
    var adoptiveColumns = [
        GridItem(.adaptive(minimum: 170))
    ]
    
    //MARK: Init grid display
    @State var Grid: [Int] = []
    
    //MARK: Main View
    var body: some View {
        MainView(data: $data, adoptiveColumns: adoptiveColumns)
    }
}

//MARK: Creating Grid
struct Card: View {
    var data:Products
    var body: some View {
        VStack {
            Image(data.image)
                .resizable()
                .frame(width: (UIScreen.main.bounds.width - 100) / 2, height: 150)
                .cornerRadius(12)
            Text(data.name)
        
            //Navigation Link
            NavigationLink(destination: DetailsProducts(data: data)) {
                Image(systemName: "info")
                    .foregroundColor(.white)
                    .font(.system(size: 22))
                Text("Details")
                    .bold()
                    .foregroundColor(.white)
            }
            .frame(width: 160, height: 40)
            .background(.green)
        }
    }
}

struct Products: Hashable  {
    var id: Int
    var name: String
    var image: String
}

struct MainView: View {
    
    @Binding var data: [Products]
    var adoptiveColumns = [
        GridItem(.adaptive(minimum: 170))
    ]
    
    var body: some View {
        if !self.data.isEmpty {
            ScrollView(.vertical, showsIndicators: true) {
                LazyVGrid(columns: adoptiveColumns) {
                    ForEach(self.data, id:\.id) { i in
                        Card(data: i)
                    }
                }
            }
        }
    }
}

struct ListProduct_Previews: PreviewProvider {
    static var previews: some View {
        ListProduct()
    }
}
