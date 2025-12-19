//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Shehryar Manzar on 2025-12-18.
//

import Foundation

struct WeatherResponse: Codable {
    let name: String
    let main: MainWeatherData
    let rain: RainData?
    let weather: [GeneralWeatherData]
}

// sub structs
struct MainWeatherData: Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    
    enum CodingKeys: String, CodingKey { 
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct RainData: Codable {
    let oneHour: Double
    
    enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
    }
}

struct GeneralWeatherData: Codable {
    let main: String
    let description: String
    let icon: String
}


