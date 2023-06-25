import SwiftUI

struct EpisodeListView: View {
    let title: String
    let showArtwork: Bool
    @Binding var episodes: LazyEpisodeRowViewModels

    var body: some View {
        ForEach(episodes) { episodeViewModel in
            NavigationLink(destination: EpisodeView(viewModel: EpisodeDetailsViewModel(episode: episodeViewModel.build().episode), listTitle: title)) {
                EpisodeRow(viewModel: episodeViewModel.build(), showArtwork: showArtwork)
                    .padding(-4)
            }
        }
    }
}

struct EpisodeListView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeListView(title: "Test", showArtwork: true, episodes: .constant(LazyEpisodeRowViewModels()))
    }
}
