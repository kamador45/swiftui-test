//
//  Home.swift
//  Agence
//
//  Created by Kevin Amador Rios on 9/2/22.
//

import SwiftUI
import Firebase
import GoogleSignIn

//MARK: Menu Items
struct MenuItems: Identifiable {
    var id = UUID()
    var name: String
    var iconName: String
    var handler: (_ destination: LocalizedStringKey ) -> Void = {destination in
        
    }
}

//Views for Menu
struct MenuContent: View {
    
    let items: [MenuItems] = [
        MenuItems(name: "Profile",iconName: "person.fill"),
        MenuItems(name: "My Products",iconName: "tag.square"),
        MenuItems(name: "Settings",iconName: "gear"),
    ]
    
    var body: some View {
        ZStack {
            Color(UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1))
            VStack(alignment: .leading, spacing: 0) {
                //MARK: Iterate menu items
                ForEach(items) { i in
                    HStack {
        
                        NavigationLink {
                            EmptyView()
                        } label: {
                            Image(systemName: i.iconName)
                                .foregroundColor(.white)
                                .font(.system(size: 22))
                            Text(i.name)
                                .font(.system(size: 22))
                                .foregroundColor(.white)
                                .bold()
                                .multilineTextAlignment(.leading)
                        }
                        Spacer()
                    }
                    .padding()
                    Divider().foregroundColor(.white)
                }
                Spacer()
            }
            .padding(.top, 110)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct SideMenu: View {
    let width: CGFloat
    var menuOpened: Bool
    let toggleMenu: () -> Void
    
    var body: some View {
        ZStack {
            //Dimmed background
            GeometryReader { _ in
                EmptyView()
            }
            .background(Color.gray.opacity(0.00))
            .opacity(self.menuOpened ? 1 : 0)
            .animation(.easeIn.delay(0.25))
            //MARK: Call toggle function
            .onTapGesture {
                self.toggleMenu()
            }
            //Menu Content
            HStack {
                MenuContent()
                    .frame(width: width)
                    .offset(x: menuOpened ? 0 : -width)
                    .animation(.easeIn.delay(0.25))
                Spacer()
            }
        }
    }
}

struct Home: View {
    @State var menuOpened = false
    //Manage status if user has an active session
    @AppStorage("log_status") var logStatus: Bool = false
    var body: some View {
        NavigationView {
            //MARK: Show menu and products
            VStack {
                if !menuOpened {
                    VStack {
                        ListProduct()
                    }
                } else {
                    ZStack {
                        VStack {
                            ListProduct()
                        }
                        SideMenu(width: UIScreen.main.bounds.width / 1.8, menuOpened: menuOpened, toggleMenu: toggleMenu)
                    }
                }
            }
            .navigationTitle("Product List")
            .toolbar {
                ToolbarItem {
                    Button {
                        do {
                            try Auth.auth().signOut()
                            GIDSignIn.sharedInstance.signOut()
                            withAnimation(.easeInOut) {
                                logStatus = false
                            }
                        } catch let error {
                            print(error.localizedDescription)
                        }
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .font(.system(size: 22))
                            .foregroundColor(.black)
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.menuOpened.toggle()
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.system(size: 22))
                            .foregroundColor(.black)
                    }

                }
            }
        }
    }
    
    //MARK: Function open close menu
    func toggleMenu() {
        menuOpened.toggle()
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
