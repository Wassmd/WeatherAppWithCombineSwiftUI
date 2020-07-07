import Foundation

struct WeeklyForecastResponse: Codable {
    let list: [Item]

    struct Item: Codable {
        let date: Date
        let main: Main
        let weather: [Weather]

        enum CodingKeys: String, CodingKey {
            case date = "dt"
            case main
            case weather
        }
    }

    struct Main: Codable {
        let temp: Double
    }

    struct Weather: Codable {
        let main: String
        let weatherDescription: String

        enum CodingKeys: String, CodingKey {
            case main
            case weatherDescription = "description"
        }
    }
}
