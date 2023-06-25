import Combine
import Foundation
import PocketCastsDataModel

class DownloadListViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var episodes = LazyEpisodeRowViewModels()
    let playSourceViewModel = PlaySourceHelper.playSourceViewModel
    private var cancellables = Set<AnyCancellable>()

    init() {
        Publishers.Notification.dataUpdated
            .sink(receiveValue: { [unowned self] _ in
                self.loadEpisodes()
            })
            .store(in: &cancellables)
    }

    public func loadEpisodes() {
        isLoading = episodes.isEmpty
        playSourceViewModel.fetchDownloadedEpisodes()
            .replaceError(with: [])
            .map {
                LazyEpisodeRowViewModels($0)
            }
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [unowned self] episodes in
                self.isLoading = false
                self.episodes = episodes
            })
            .store(in: &cancellables)
    }
}
