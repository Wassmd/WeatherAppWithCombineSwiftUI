import Foundation
import Combine

protocol WeatherFetchable {
    func weeklyWeatherForecast(for city: String) -> AnyPublisher<WeeklyForecastResponse, WeatherError>
}

class WeatherFetcher: WeatherFetchable {
    private enum Contants {
        static let scheme = "https"
        static let host = "api.openweathermap.org"
        static let path = "/data/2.5"
        static let key = "c308ccf01e124e4451d30cb70dfdcc85"
    }

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func makeWeeklyForecastComponents(for city: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = Contants.scheme
        components.host = Contants.host
        components.path = Contants.path + "/forecast"

        components.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "mode", value: "json"),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "APPID", value: Contants.key),
        ]

        return components
    }

    func weeklyWeatherForecast(for city: String) -> AnyPublisher<WeeklyForecastResponse, WeatherError> {
        return forcast(with: makeWeeklyForecastComponents(for: city))
    }

    private func forcast(with components: URLComponents) -> AnyPublisher<WeeklyForecastResponse, WeatherError> {
        guard let url = components.url else {
            let error = WeatherError.network(description: "Couldn't create URL")

            return Fail(error: error).eraseToAnyPublisher()
        }

        return session.dataTaskPublisher(for: URLRequest(url: url))
            .mapError { error in
                 WeatherError.network(description: error.localizedDescription)
        }.flatMap(maxPublishers: .max(1)) { output in
            decode(output.data)
        }.eraseToAnyPublisher()
    }
}
