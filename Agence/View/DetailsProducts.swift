//
//  DetailsProducts.swift
//  Agence
//
//  Created by Kevin Amador Rios on 9/5/22.
//

import SwiftUI
import MapKit
import CoreLocation

struct DetailsProducts: View {
    
    @State var showAlert = false
    
    
    @State var descriptions = [
        Description(id:1,description: "Van hallen deluxe collection like Humans Beings"),
        Description(id:2,description: "Linking Park new metal collection"),
        Description(id:3,description: "Inspired on Nirvana, AudioSlave"),
        Description(id:4,description: "Nirvana, considered father of Grunge")
    ]
    
    //MARK: Get data from ListProducts Component
    @State var data:Products
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.331618, longitude: -121.891054), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    Map(coordinateRegion: $region, showsUserLocation: true)
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3, alignment: .top)
            GeometryReader { geometry in
                HStack {
                    ForEach(self.descriptions) { i in
                        if data.id == i.id {
                            Image(data.image)
                                .resizable()
                                .frame(width: (UIScreen.main.bounds.width - 100) / 2, height: 150)
                                .cornerRadius(12)
                            Text(i.description)
                                .font(.system(size: 22))
                                .bold()
                        }
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: 150, alignment: .top)
            Divider()
            GeometryReader { geometry in
                HStack {
                    Button {
                        showAlert = true
                    } label: {
                        Image(systemName: "creditcard")
                            .foregroundColor(.white)
                        Text("Buy")
                            .foregroundColor(.white)
                            .font(.system(size: 22))
                            .bold()
                    }
                    .frame(width: UIScreen.main.bounds.width, height: 50)
                    .cornerRadius(12)
                    .background(Color.green)
                    .alert("Do you want buy it \(data.name)?", isPresented: $showAlert) {
                        Button("Buy it", role: .none, action: {
                            print("Buying")
                        })
                        Button("Cancel", role: .cancel, action: {
                            print("Cancel")
                        })
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: 60, alignment: .top)
            Spacer()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct Description: Identifiable {
    var id: Int
    var description: String
}
