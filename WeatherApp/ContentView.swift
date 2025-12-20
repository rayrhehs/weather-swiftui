import SwiftUI
internal import _LocationEssentials

extension Font {
    static let nunitoReg = Font.custom("Nunito", size: 20)
    static let nunitoTitle = Font.custom("Nunito", size: 34)
    static let nunitoSmall = Font.custom("Nunito", size: 15)
    static let nunitoXS = Font.custom("Nunito", size: 10)
}

struct ContentView: View {
    
    @State var locationManager = LocationManager()
    @State private var weatherData: WeatherResponse = WeatherResponse(
        name: "Loading...",
        main: MainWeatherData(temp: 0, feelsLike: 0, tempMin: 0, tempMax: 0),
        rain: nil,
        weather: []
    )
    let APIkey = Secrets.weatherAPIKey // api key is safely hidden
    
    func fetchWeather() async throws -> WeatherResponse {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(locationManager.location?.coordinate.latitude, default: "0.0")&lon=\(locationManager.location?.coordinate.longitude, default: "0.0")&appid=\(APIkey)") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let weatherData = try JSONDecoder().decode(WeatherResponse.self, from: data)
        
        return weatherData
    }
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text(weatherData.name)
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
                        Text("\(Int(weatherData.main.temp - 273.15))°")
                            .font(.nunitoTitle)
                            .fontWeight(.semibold)
                        Text("Feels like \(Int(weatherData.main.feelsLike - 273.15))°")
                            .font(.nunitoSmall)
                            .fontWeight(.semibold)
                            .frame(width: 100)
                    }
                    .padding(.trailing)
                    .frame(width: 100, alignment: .leading) // this fixes the width of the vstack, preventing it from scaling
                    
                }
                .frame(width: 150, height: 180)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .foregroundStyle(Color.white) // text color
                
                VStack {
                    HStack (spacing: 12) {
                        Image(systemName: "cloud.rain.fill")
                            .resizable()
                            .frame(width: 27.5, height: 27.5)
                        VStack (spacing: -5){ 
                            Text(weatherData.rain?.oneHour ?? 0.0,
                                 format: .number.precision(.fractionLength(2)))
                                .font(.nunitoReg)
                                .fontWeight(.semibold)
                            Text("mm/h")
                                .font(.nunitoSmall)
                                .fontWeight(.semibold)   
                        }
                    }
                    .frame(width: 150, height: 85)
                    .background(Color.yellow)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .foregroundStyle(Color.black)

                    VStack (spacing: 0) {
                        HStack (spacing: 0){
                            Image(systemName: "arrow.up")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .fontWeight(.bold)
                            Text("\(Int(weatherData.main.tempMax - 273.15))°")
                                .font(.nunitoReg)
                                .fontWeight(.semibold)
                                .frame(width: 50)
                        }
                        HStack (spacing: 0) {
                            Image(systemName: "arrow.down")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .fontWeight(.bold)
                            Text("\(Int(weatherData.main.tempMin - 273.15))°")
                                .font(.nunitoReg)
                                .fontWeight(.semibold)
                                .frame(width: 50)
                        }

                    }
                    .frame(width: 150, height: 85)
                    .background(Color.green)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .foregroundStyle(Color.white)

                }
                
            }
            .task {  // ← Attached to the VStack here!
                do {
                    weatherData = try await fetchWeather()
                } catch {
                    print("Error fetching weather: \(error)")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
