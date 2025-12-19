//
//  SecretsDecoder.swift
//  WeatherApp
//
//  Created by Shehryar Manzar on 2025-12-19.
//

import Foundation

enum Secrets {
    static var weatherAPIKey: String {
        // the API_KEY reference is the name of the key UNDER THE INFO.plist file -> MAKE SURE THESE ARE THE SAME
        guard let key = Bundle.main.infoDictionary?["API_KEY"] as? String else {
            fatalError("Weather API key not found. Check Secrets.xcconfig.")
        }
        return key
    }
}
