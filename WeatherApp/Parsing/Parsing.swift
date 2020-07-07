import Foundation
import Combine

func decode(_ data: Data) -> AnyPublisher<WeeklyForecastResponse, WeatherError> {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970

    return Just(data)
        .decode(type: WeeklyForecastResponse.self, decoder: decoder)
        .print("decode")
        .mapError { error in
            .parsing(description: error.localizedDescription)
    }.eraseToAnyPublisher()
}


