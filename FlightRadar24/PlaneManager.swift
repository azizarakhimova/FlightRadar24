//
//  PlaneManager.swift
//  FlightRadar24
//
//  Created by Aziza Rahimova on 18/11/23.
//

import Foundation
import SwiftUI
import MapKit

class PlaneManager: ObservableObject {
    static let apiKey = "6047d021-3df8-4e0e-bf70-a7d59ff6b8e8"
    @Published var planeAnnotations: [PlaneAnnotation] = []

    func fetchFlightData(apiKey: String) {
        guard let url = URL(string: "https://airlabs.co/api/v9/flights?api_key=\(apiKey)") else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            // Print the received JSON data
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Received JSON: \(jsonString)")
            }

            do {
                let decoder = JSONDecoder()
                let flightData = try decoder.decode([FlightData].self, from: data)
                DispatchQueue.main.async {
                    self.updateAnnotations(with: flightData)
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }

        task.resume()
    }


    private func updateAnnotations(with flightData: [FlightData]) {
        planeAnnotations = flightData.map { FlightDataToPlaneAnnotationMapper.map($0) }
    }

    func startFetchingLiveFlightData(apiKey: String, interval: TimeInterval = 1200) {
        // Initial fetch
        fetchFlightData(apiKey: apiKey)

        // Periodic fetch every 20 minutes (1200 seconds)
        Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
            self.fetchFlightData(apiKey: apiKey)
        }
    }
}

struct FlightData: Codable {
    let hex: String
    let regNumber: String
    let flag: String
    let lat: Double
    let lng: Double
    let alt: Int
    let dir: Int
    let speed: Int
    let vSpeed: Double
    let squawk: String
    let flightNumber: String
    let flightIcao: String
    let flightIata: String
    let depIcao: String
    let depIata: String
    let arrIcao: String
    let arrIata: String
    let airlineIcao: String
    let airlineIata: String
    let aircraftIcao: String
    let updated: TimeInterval
    let status: String
}

struct FlightDataToPlaneAnnotationMapper {
    static func map(_ flightData: FlightData) -> PlaneAnnotation {
        let coordinate = CLLocationCoordinate2D(latitude: flightData.lat, longitude: flightData.lng)
        return PlaneAnnotation(coordinate: coordinate)
    }
}
