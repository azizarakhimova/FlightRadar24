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
    static let apiKey = "your_airlabs_api_key"
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

                do {
                    let decoder = JSONDecoder()
                    let responseData = try decoder.decode(ResponseData.self, from: data)
                    DispatchQueue.main.async {
                        self.updateAnnotations(with: responseData.response)
                    }
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                    print("Failed JSON: \(String(data: data, encoding: .utf8) ?? "N/A")")
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


struct FlightData: Codable, Identifiable {
    let id = UUID()
    let hex: String
    let reg_number: String
    let flag: String
    let lat: Double
    let lng: Double
    let alt: Double?
    let dir: Double
    let speed: Double?
    let v_speed: Double
    let squawk: String
    let flight_number: String
    let flight_icao: String
    let flight_iata: String
    let dep_icao: String
    let dep_iata: String
    let arr_icao: String
    let arr_iata: String
    let airline_icao: String
    let airline_iata: String
    let aircraft_icao: String
    let updated: TimeInterval
    let status: String
}

struct FlightDataToPlaneAnnotationMapper {
    static func map(_ flightData: FlightData) -> PlaneAnnotation {
        let coordinate = CLLocationCoordinate2D(latitude: flightData.lat, longitude: flightData.lng)
        // Assuming 'dir' property represents the rotation angle
        let rotation = flightData.dir
        return PlaneAnnotation(coordinate: coordinate, rotation: rotation)
    }
}

