
import SwiftUI
import MapKit

struct PlaneAnnotation: Identifiable {
    let id = UUID()
        let coordinate: CLLocationCoordinate2D
        let rotation: Double  // Rotation angle in degrees

        init(coordinate: CLLocationCoordinate2D, rotation: Double) {
            self.coordinate = coordinate
            self.rotation = rotation
        }
}
struct AirplaneView: View {
    var rotation: Double

    var body: some View {
        Image(systemName: "airplane")
            .resizable()
            .frame(width: 20, height: 20)
            .foregroundColor(.black)
            .rotationEffect(.degrees(rotation), anchor: .center) // Rotate the airplane image
    }
}

struct ResponseData: Codable {
    let response: [FlightData]
}

struct ContentView: View {
    @StateObject var planeManager = PlaneManager()

    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 44.8378, longitude: -0.5792), // Centered around Bordeaux
        span: MKCoordinateSpan(latitudeDelta: 20.0, longitudeDelta: 20.0) // Adjust the span as needed
    )
    
    // Additional state for the plane annotations
       @State private var planeAnnotations: [PlaneAnnotation] = [
           
        // Add more PlaneAnnotations with their respective coordinates and rotation
                PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 59.787784, longitude: 46.90878), rotation: 69),
                PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 56.349762, longitude: 52.926037), rotation: 90),
                PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 45.914239, longitude: 47.938499), rotation: 353.1),
                PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 46.700181, longitude: 46.565346), rotation: 302.4),
                PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 49.963632, longitude: 8.529548), rotation: 177),
                PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 50.058975, longitude: 13.662222), rotation: 90),
                PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 48.07457, longitude: 13.054504), rotation: 280.1),
                PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 44.679814, longitude: 3.466254), rotation: 58),
                PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 42.682304, longitude: -1.738203), rotation: 207),
                PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 40.041138, longitude: -3.6427), rotation: 42),
                PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 44.028671, longitude: 9.232795), rotation: 259.4),
                PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 39.587494, longitude: -4.234453), rotation: 45),
                PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 40.493103, longitude: -3.589034), rotation: 180),
                PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 41.291602, longitude: -8.692183), rotation: 349.1),
                PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 40.489775, longitude: -3.561427), rotation: 180),
                PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 38.730423, longitude: -8.410213), rotation: 240.8),
                PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 41.798241, longitude: 12.258299), rotation: 10),
                PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 40.32692, longitude: -4.145935), rotation: 25),
                PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 41.292138, longitude: 2.103039), rotation: 241),
                    PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 49.101242, longitude: 12.579416), rotation: 304.8),
                    PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 37.633209, longitude: -3.316001), rotation: 225.9),
                    PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 40.978725, longitude: 9.806484), rotation: 265.8),
                    PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 40.339516, longitude: -3.91569), rotation: 116),
                    PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 44.288132, longitude: 0.865108), rotation: 193.3),
                    PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 40.356228, longitude: 2.611875), rotation: 191.7),
                    PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 44.450823, longitude: -4.053754), rotation: 179),
                    PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 41.963118, longitude: -7.522952), rotation: 106),
                PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 41.292138, longitude: 2.103039), rotation: 241),
                   PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 49.101242, longitude: 12.579416), rotation: 304.8),
                   PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 37.633209, longitude: -3.316001), rotation: 225.9),
                   PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 40.978725, longitude: 9.806484), rotation: 265.8),
                   PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 40.339516, longitude: -3.91569), rotation: 116),
                   PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 44.288132, longitude: 0.865108), rotation: 193.3),
                   PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 40.356228, longitude: 2.611875), rotation: 191.7),
                   PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 44.450823, longitude: -4.053754), rotation: 179),
                   PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 41.963118, longitude: -7.522952), rotation: 106),
                   PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 47.988281, longitude: 14.907039), rotation: 303),
                   PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 47.771072, longitude: 11.927376), rotation: 213),
                   PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 34.667313, longitude: -8.568831), rotation: 218.8),
                   PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 48.56781, longitude: 2.686591), rotation: 192.8),
                   PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 45.126572, longitude: -3.203561), rotation: 177),
                   PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 47.135513, longitude: -1.157204), rotation: 58),
                   PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 45.971695, longitude: 10.086186), rotation: 224.6),
                   PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 41.291691, longitude: 2.085007), rotation: 154),
                   PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 9.33577, longitude: -78.936119), rotation: 229),
                PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 43.804492, longitude: 11.196507), rotation: 47.9),
                   PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 39.597427, longitude: 2.155291), rotation: 79),
                   PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 39.846313, longitude: -0.483279), rotation: 274.7),
                   PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 45.050125, longitude: 5.822362), rotation: 197.8),
                   PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 14.523134, longitude: -63.105854), rotation: 228.2),
                   PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 45.749588, longitude: 8.465234), rotation: 317.2),
                   PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 38.853287, longitude: -3.557003), rotation: 4),
                   PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 44.969555, longitude: 4.137759), rotation: 60),
                   PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 45.53954, longitude: 0.371592), rotation: 208.8),
                   PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 48.167038, longitude: 2.074233), rotation: 182.8),
                PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 48.692756, longitude: 2.092173), rotation: 139),
                   PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 44.176941, longitude: 1.663407), rotation: 232.9),
                   PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 40.494232, longitude: -3.570251), rotation: 177),
                   PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 40.493534, longitude: -3.566562), rotation: 270),
                   PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 39.413132, longitude: -1.627171), rotation: 323.9),
                   PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 46.543991, longitude: 6.813332), rotation: 209.4),
                   PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 40.472329, longitude: -3.569324), rotation: 119),
                   PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 43.550875, longitude: -93.474034), rotation: 240.3),
                   PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 43.233948, longitude: 5.425713), rotation: 230.9),
                   PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 50.01051, longitude: 3.505455), rotation: 211.3),
                   PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 48.432436, longitude: 3.822809), rotation: 104),
                   PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 44.475586, longitude: 10.763659), rotation: 61),
                   PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 45.737549, longitude: -3.650074), rotation: 189.8),
                PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: -7.736284, longitude: -34.891157), rotation: 32),
                    PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 40.814758, longitude: -2.066833), rotation: 210.9),
                    PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 41.294663, longitude: 2.061887), rotation: 5),
                    PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: -8.256365, longitude: -34.691462), rotation: 27),
                    PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 27.974442, longitude: -14.920226), rotation: 225),
                    PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 47.372349, longitude: 0.970811), rotation: 28),
                    PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 45.537073, longitude: 11.451505), rotation: 354.4),
                    PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 43.184784, longitude: 5.480006), rotation: 233.3),
                    PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 37.010751, longitude: -3.882592), rotation: 243.5),
                    PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 48.816696, longitude: 2.635099), rotation: 200.8),
                    PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 39.316298, longitude: 2.84314), rotation: 33),
                    PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 48.314147, longitude: 2.761327), rotation: 40),
                PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 46.227402, longitude: 0.498538), rotation: 19.2),
                    PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 42.883987, longitude: -5.103277), rotation: 29),
                    PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 48.902527, longitude: 2.212125), rotation: 85),
                    PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 39.997787, longitude: -4.381836), rotation: 75),
                    PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 40.399429, longitude: -3.489408), rotation: 322),
                    PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 47.653473, longitude: 0.796028), rotation: 17),
                    PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 40.449286, longitude: -3.511568), rotation: 322.3),
                    PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 46.550748, longitude: 0.409378), rotation: 26),
                    PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 5.566763, longitude: -73.617349), rotation: 227.6),
                    PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 46.165054, longitude: 6.249412), rotation: 49),
                    PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 43.192982, longitude: -4.021781), rotation: 183.3),
                    PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 16.397327, longitude: -60.922279), rotation: 228.8),
                    PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 48.457169, longitude: 2.165081), rotation: 48.5)
                    // Add more PlaneAnnotations with their respective coordinates and rotation
                
                ]


    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                
                Map(coordinateRegion: $region, showsUserLocation: false, userTrackingMode: nil, annotationItems: planeAnnotations) { annotation in
                    MapAnnotation(coordinate: annotation.coordinate) {
                        AirplaneView(rotation: annotation.rotation)
                    }
                }
        
                .accessibility(label: Text("Map"))
                              .edgesIgnoringSafeArea(.all)
                              .blur(radius: 0.1)
        

                // Gray overlay with status bar, search bar, and person icon
                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: 50) // Status bar height

                    HStack {
                        // Search bar with adjusted padding
                        TextField("Search", text: .constant(""))
                            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                            .background(Color.white)
                            .cornerRadius(8)
                            .padding(.leading, 20) // Set left padding to 30 pixels
                            .accessibility(label: Text("Search Bar"))

                        Spacer()

                        // Person icon (replace with your own icon)
                        Image(systemName: "person")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding(16)
                            .foregroundColor(.white)
                         .padding(.trailing, 0) // Set left padding to 30 pixels
                         .accessibility(label: Text("Profile"))
                    }
                    .background(Color.black.opacity(0.6))

                    Spacer()
                }
                .edgesIgnoringSafeArea(.top)

                // Rectangle with buttons at the bottom
                VStack {
                    Spacer()

                    Rectangle()
                        .fill(Color.black.opacity(0.6))
                    
                        .frame(width: 350, height: 70) // Adjust the height as needed
                        .cornerRadius(30)
                        .overlay(
                            HStack {
                                Spacer()

                                // Add your buttons here
                                CircleButtonsView()

                                Spacer()
                            }
                            .padding()
                        )
                }
            }
            .navigationBarHidden(true) // Hide navigation bar
            .gesture(MagnificationGesture()
                                    .onChanged { scale in
                                        let span = MKCoordinateSpan(
                                            latitudeDelta: region.span.latitudeDelta / Double(scale),
                                            longitudeDelta: region.span.longitudeDelta / Double(scale)
                                        )
                                        region.span = span
                                    }
                        )
        }
        .onAppear {
                     planeManager.startFetchingLiveFlightData(apiKey: PlaneManager.apiKey)
                 }
        
    }
}

// The rest of the code remains unchanged

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CircleButtonsView: View {
    var body: some View {
        HStack(spacing: 18) {
            VStack {
                Button(action: {
                    // Implement action for the first button
                }) {
                    Image(systemName: "gearshape")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                        .accessibility(label: Text("Settings"))
                }
                Text("Settings")
                    .foregroundColor(.white)
                    .font(.system(size: 11))
            }

            VStack {
                Button(action: {
                    // Implement action for the second button
                }) {
                    Image(systemName: "cloud.sun.bolt")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                        .scaleEffect(x: -1, y: 1) // Flip along the vertical axis
                        .accessibility(label: Text("Weather"))
                }
                Text("Weather")
                    .foregroundColor(.white)
                    .font(.system(size: 11))
            }

            VStack {
                Button(action: {
                    // Implement action for the third button
                }) {
                    Image(systemName: "flask")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                        .rotationEffect(Angle(degrees: 180))
                        .accessibility(label: Text("Filter"))
                }
                Text("Filter")
                    .foregroundColor(.white)
                    .font(.system(size: 11))
            }

            VStack {
                Button(action: {
                    // Implement action for the fourth button
                }) {
                    Image(systemName: "bell")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                        .accessibility(label: Text("Notifications"))
                }
                Text("Notifications")
                    .foregroundColor(.white)
                    .font(.system(size: 10))
            }

            VStack {
                Button(action: {
                    // Implement action for the fifth button
                }) {
                    Image(systemName: "clock.arrow.circlepath")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                        .accessibility(label: Text("Playback"))
                }
                Text("Playback")
                    .foregroundColor(.white)
                    .font(.system(size: 11))
            }
        }
        
    }
    
}

