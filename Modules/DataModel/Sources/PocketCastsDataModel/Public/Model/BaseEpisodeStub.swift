import Foundation

public protocol BaseEpisodeStub {
    var uuid: String { get set }

    func fetch() -> BaseEpisode
}

public class EpisodeStub: BaseEpisodeStub {
    public var uuid: String

    public init(uuid: String) {
        self.uuid = uuid
    }

    public func fetch() -> BaseEpisode {
        DataManager.sharedManager.findEpisode(uuid: uuid) ?? Episode()
    }
}

public class UserEpisodeStub: BaseEpisodeStub {
    public var uuid: String

    public init(uuid: String) {
        self.uuid = uuid
    }

    public func fetch() -> BaseEpisode {
        DataManager.sharedManager.findUserEpisode(uuid: uuid) ?? UserEpisode()
    }
}
