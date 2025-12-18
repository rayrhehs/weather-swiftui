//
//  ContentView.swift
//  WeatherApp
//
//  Created by Shehryar Manzar on 2025-12-11.
//

import SwiftUI
internal import _LocationEssentials

extension Font {
    static let nunitoReg = Font.custom("Nunito", size: 20)
    static let nunitoTitle = Font.custom("Nunito", size: 34)
    static let nunitoSmall = Font.custom("Nunito", size: 17)
}

struct ContentView: View {
    
    @State var locationManager = LocationManager()
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("\(locationManager.location?.coordinate.latitude ?? 0.0), \(locationManager.location?.coordinate.longitude ?? 0.0)")
                }
                HStack {
                    Text("Oakville")
                        .font(.nunitoTitle)
                        .fontWeight(.bold)
                }
            }
        
            HStack {
                VStack(alignment: .trailing, spacing: 20) { // spacing useful for gaps in stacks
                    Image(systemName: "cloud.moon.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)  // set specific dimensions
                    VStack(alignment: .leading, spacing: -5) {
                        Text("24°")
                            .font(.nunitoTitle)
                            .fontWeight(.semibold)
                        Text("Feels like 21°")
                            .font(.nunitoSmall)
                            .fontWeight(.semibold)
                    }
                    .padding(.trailing, 5)
                    
                }
                .frame(width: 150, height: 180)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .foregroundStyle(Color.white) // text color

                VStack {
                    HStack (spacing: 8) {
                        Image(systemName: "cloud.rain.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                        Text("5%")
                            .font(.nunitoReg)
                            .fontWeight(.semibold)
                    }
                    .frame(width: 150, height: 85)
                    .background(Color.yellow)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .foregroundStyle(Color.black)

                    VStack (spacing: 0) {
                        HStack (spacing: 8){
                            Image(systemName: "arrow.up")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .fontWeight(.bold)
                            Text("28°")
                                .font(.nunitoReg)
                                .fontWeight(.semibold)
                        }
                        HStack (spacing: 8) {
                            Image(systemName: "arrow.down")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .fontWeight(.bold)
                            Text("21°")
                                .font(.nunitoReg)
                                .fontWeight(.semibold)
                        }
                    }
                    .frame(width: 150, height: 85)
                    .background(Color.green)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .foregroundStyle(Color.white)

                }
                
            }
        }
    }
}

#Preview {
    ContentView()
}
