import Foundation
import PocketCastsDataModel

class LazyEpisodeRowViewModels: RandomAccessCollection {
    private var viewModels: [EpisodeRowViewModel?]
    private var episodes: [BaseEpisode]

    init() {
        episodes = []
        viewModels = []
    }

    init(_ episodes: [BaseEpisode]) {
        self.episodes = episodes
        viewModels = Array(repeating: nil, count: episodes.count)
    }

    var startIndex: Int { viewModels.startIndex }
    var endIndex: Int { viewModels.endIndex }

    subscript(position: Int) -> Builder {
        Builder(id: episodes[position].uuid) { [weak self] in
            self?.index(position) ?? EpisodeRowViewModel(episode: Episode())
        }
    }

    private func index(_ position: Int) -> EpisodeRowViewModel {
        if viewModels[position] == nil {
            viewModels[position] = EpisodeRowViewModel(episode: episodes[position])
        }
        return viewModels[position]!
    }

    struct Builder: Identifiable {
        var id: String
        var build: () -> EpisodeRowViewModel

        init(id: String, build: @escaping () -> EpisodeRowViewModel) {
            self.id = id
            self.build = build
        }
    }
}
