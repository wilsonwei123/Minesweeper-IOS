//
//  BeginView.swift
//  Minesweeper-IOS
//
//  Created by Wilson Wei on 28/04/2025.
//

import SwiftUI

struct BeginView: View {
    @State var username: String = UserDefaults.standard.string(forKey: "username") ?? ""
    @State var difficulty: Int = 0
    @State var showGame: Bool = false
    @State var gridSize: Double = 3.0;
    @State var displayWarning: Bool = false
    var body: some View {
        NavigationStack {
            VStack (spacing: 10) {
                Text("Enter your name...")
                    .font(.system(size: 30))
                    .bold()
                TextField("Your name here",text: $username)
                    .autocorrectionDisabled(true)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(maxWidth: 350)
                    .padding(.top, 20)
                    .onChange(of: username) {
                        if username.count > 50 {
                            username = String(username.prefix(50))
                        }
                    }
                Text("\(username.count) characters (max 50)")
                Text("And select a difficulty:")
                    .padding(20)
                    .font(.system(size: 30))
                    .bold()
                HStack {
                    Button(action: {
                        difficulty = 1
                    }, label: {
                        ButtonView(text: "Easy")
                            .background((difficulty == 1) ? Color.mint : Color.cyan)
                            .cornerRadius(10)
                    })
                    Button(action: {
                        difficulty = 2
                    }, label: {
                        ButtonView(text: "Medium")
                            .background((difficulty == 2) ? Color.mint : Color.cyan)
                            .cornerRadius(10)
                    })
                    Button(action: {
                        difficulty = 3
                    }, label: {
                        ButtonView(text: "Hard")
                            .background((difficulty == 3) ? Color.mint : Color.cyan)
                            .cornerRadius(10)
                    })
                }
                .padding(.top, 20)
                HStack {
                    Button(action: {
                        difficulty = 4
                    }, label: {
                        ButtonView(text: "Very hard")
                            .background((difficulty == 4) ? Color.mint : Color.cyan)
                            .cornerRadius(10)
                    })
                    Button(action: {
                        difficulty = 5
                    }, label: {
                        ButtonView(text: "Hardest")
                            .background((difficulty == 5) ? Color.mint : Color.cyan)
                            .cornerRadius(10)
                    })
                }
                Text("Now choose the grid side length:")
                    .font(.system(size: 30))
                    .padding(.top, 40)
                    .bold()
                Slider(value: $gridSize, in: 3...20, step: 1) {
                } minimumValueLabel: {
                    Text("3")
                } maximumValueLabel: {
                    Text("20")
                }
                .padding([.top, .leading, .trailing], 16)
                Text(String(format: "%.0f", gridSize))
                    .padding(5)
                Spacer()
                if displayWarning {
                    Text("You forgot to add something!")
                        .font(.system(size: 20))
                }
                Spacer()
                Button(action: {
                    if username.count > 0 && difficulty != 0 {
                        showGame = true
                    } else {
                        displayWarning = true
                    }
                    UserDefaults.standard.set(username, forKey: "username")
                }, label: {
                    Text("Let's go!")
                        .font(.system(size: 30))
                        .bold()
                        .padding(30)
                        .background(Color.teal)
                        .cornerRadius(20)
                })
                NavigationLink(destination: GameView(gridSize: Int(gridSize), difficulty: difficulty), isActive: $showGame, label: { EmptyView() }
                )
                /*
                NavigationLink(destination: HistoryView(), label: {
                    Text("Go to history")
                        .font(.system(size: 20))
                })
                */
            }
            .navigationBarBackButtonHidden(true)
            .foregroundStyle(.black)
        }
    }
}

#Preview {
    BeginView()
}
