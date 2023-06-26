import Foundation
import PocketCastsDataModel

class LazyEpisodeRowViewModels: RandomAccessCollection {
    private var viewModels: [EpisodeRowViewModel?]
    private var episodes: [BaseEpisode?]
    private var stubs: [BaseEpisodeStub]

    init() {
        stubs = []
        episodes = []
        viewModels = []
    }

    init(_ stubs: [BaseEpisodeStub]) {
        self.stubs = stubs
        episodes = Array(repeating: nil, count: stubs.count)
        viewModels = Array(repeating: nil, count: stubs.count)
    }

    init(_ episodes: [BaseEpisode]) {
        stubs = []
        self.episodes = episodes
        viewModels = Array(repeating: nil, count: episodes.count)
    }

    var startIndex: Int { viewModels.startIndex }
    var endIndex: Int { viewModels.endIndex }

    subscript(position: Int) -> Builder {
        Builder(id: episodes[position]?.uuid ?? stubs[position].uuid) { [weak self] in
            self?.index(position) ?? EpisodeRowViewModel(episode: Episode())
        }
    }

    private func index(_ position: Int) -> EpisodeRowViewModel {
        if viewModels[position] == nil {
            if episodes[position] == nil {
                episodes[position] = stubs[position].fetch()
            }
            viewModels[position] = EpisodeRowViewModel(episode: episodes[position]!)
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
