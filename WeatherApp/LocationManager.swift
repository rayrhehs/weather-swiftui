//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Shehryar Manzar on 2025-12-18.
//

import SwiftUI

import Foundation
import MapKit
import SwiftUI

@Observable

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    var location: CLLocation?
    private let locationManager = CLLocationManager()
    var authorizationStatus: CLAuthorizationStatus = .notDetermined
    var errorMessage: String?
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        location = newLocation
        
//        manager.stopUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
        
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            print("LocationManager authorization granted.")
        case .denied, .restricted:
            print("LocationManager authorization denied.")
            manager.stopUpdatingLocation()
        case .notDetermined:
            print("LocationManager auhtorization not determined.")
            manager.requestWhenInUseAuthorization()
        @unknown default:
            manager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        errorMessage = error.localizedDescription
        print("ERROR Location Manager: \(errorMessage ?? "n/a")")
    }
}
