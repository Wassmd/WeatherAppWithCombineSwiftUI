import Foundation
import Combine

class WeeklyWeatherViewModel: ObservableObject {
    private let weatherFetcher: WeatherFetchable
    private var disposables = Set<AnyCancellable>()

    @Published var city = ""
    @Published var dataSource = []

    init(weatherFetcher: WeatherFetchable = WeatherFetcher()) {
        self.weatherFetcher = weatherFetcher

        fetchWeather(for: "Munich")
    }

    func fetchWeather(for city: String) {
        weatherFetcher.weeklyWeatherForecast(for: city)
            .receive(on: DispatchQueue.main)
        .print()
            .sink(receiveCompletion: { value in
                switch value{
                case .finished:
                    break
                case .failure:
                    break
                }
            }, receiveValue: { forecast in
                print("forecast:\(forecast)")
            }).store(in: &disposables)
    }
}
