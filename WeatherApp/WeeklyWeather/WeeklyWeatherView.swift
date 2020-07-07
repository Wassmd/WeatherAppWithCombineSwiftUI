import SwiftUI

struct WeeklyWeatherView: View {

    @ObservedObject var viewModel: WeeklyWeatherViewModel
    
    init(viewModel: WeeklyWeatherViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            List {
                searchField
//                if viewModel
            }
        }
    }
}

private extension WeeklyWeatherView {
    var searchField: some View {
        HStack(alignment: .center) {
            TextField("Münster", text: $viewModel.city)
        }
    }

    var emptySection: some View {
        Section {
            Text("No result")
                .foregroundColor(.gray)
        }
    }
}


