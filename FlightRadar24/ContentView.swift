
import SwiftUI
import MapKit

struct PlaneAnnotation: Identifiable {
    var id = UUID()
    var coordinate: CLLocationCoordinate2D
}
struct AirplaneView: View {
    var body: some View {
        Image(systemName: "airplane")
            .resizable()
            .frame(width: 20, height: 20)
            .foregroundColor(.black)
    }
}

struct ContentView: View {
    @StateObject var planeManager = PlaneManager()
    
    @State private var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
            span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0)
        )
    
    // Additional state for the plane annotations
       @State private var planeAnnotations: [PlaneAnnotation] = [
           PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)),
           // Add more PlaneAnnotations with their respective coordinates
           PlaneAnnotation(coordinate: CLLocationCoordinate2D(latitude: 37.8770, longitude: -122.4194))
       ]


    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                
                // Map
                                Map(coordinateRegion: $region, showsUserLocation: false, userTrackingMode: nil, annotationItems: planeAnnotations) { annotation in
                                    MapAnnotation(coordinate: annotation.coordinate) {
                                        AirplaneView()
                                    }
                                }
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

                        Spacer()

                        // Person icon (replace with your own icon)
                        Image(systemName: "person")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding(16)
                            .foregroundColor(.white)
                         .padding(.trailing, 0) // Set left padding to 30 pixels
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
                }
                Text("Playback")
                    .foregroundColor(.white)
                    .font(.system(size: 11))
            }
        }
        
    }
    
}

