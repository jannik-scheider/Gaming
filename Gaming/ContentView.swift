//
//  ContentView.swift
//  Gaming
//
//  Created by Jannik Scheider on 06.05.24.
//

import SwiftUI

struct ContentView: View {
    
    var platforms: [Platform] = [.init(name:"Xbox", imageName: "xbox.logo", color: .green),
                                .init(name:"Playstation", imageName: "playstation.logo", color: .indigo),
                                .init(name:"PC", imageName: "pc", color: .mint),
                                .init(name:"Mobile", imageName: "iphone", color: .pink)]
    
    var games: [Game] = [.init(name: "Fortnite", rating: "92"),
                        .init(name: "GTA", rating: "99"),
                        .init(name: "Fifa", rating: "100")]
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path){
            List{
                Section("Platforms"){
                    ForEach(platforms, id:\.name){
                        platform in
                        NavigationLink(value: platform){
                            Label(platform.name, systemImage:platform.imageName)
                                .foregroundColor(platform.color)
                        }
                    }
                }
                
                Section("Games"){
                    ForEach(games, id:\.name){
                        game in
                        NavigationLink(value: game){
                            Text(game.name)
                        }
                    }
                }
            }
            .navigationTitle("Gaming")
            .navigationDestination(for: Platform.self){ platform in
                ZStack {
                    platform.color.ignoresSafeArea()
                    VStack{
                        Label(platform.name, systemImage:  platform.imageName)
                            .font(.largeTitle).bold()
                        List{
                            ForEach(games, id:\.name){
                                game in
                                NavigationLink(value: game){
                                    Text(game.name)
                                }
                            }
                        }
                    }
                }
            }
            .navigationDestination(for: Game.self) { game in
                VStack(spacing: 20){
                    Text("\(game.name) - \(game.rating)")
                        .font(.largeTitle.bold())
                    
                    Button("next game"){
                        path.append(games.randomElement()!)
                    }
                    
                    Button("next platform"){
                        path.append(platforms.randomElement()!)
                    }
                    
                    Button("Go Home"){
                        path = NavigationPath()
                    }
                }
            }
        }
    }
}


struct Platform: Hashable{
    let name: String
    let imageName: String
    let color: Color
}

struct Game: Hashable {
    let name: String
    let rating: String
}

#Preview {
    ContentView()
}
