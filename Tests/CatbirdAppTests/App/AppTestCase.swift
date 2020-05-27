@testable import CatbirdApp
import XCTVapor

class AppTestCase: XCTestCase {

    let mocksDirectory = AppConfiguration.sourceDir + "/Tests/CatbirdAppTests/Files"

    private(set) var app: Application! {
        willSet { app?.shutdown() }
    }

    func setUpApp(mode: AppConfiguration.Mode) throws {
        let config = AppConfiguration(mode: mode, mocksDirectory: URL(string: mocksDirectory)!)
        app = Application(.testing)
        try configure(app, config)
    }

    override func setUp() {
        super.setUp()
        XCTAssertNoThrow(try setUpApp(mode: .read))
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }
}

class RequestTestCase: AppTestCase {

    private(set) var request: Request!

    override func setUp() {
        super.setUp()
        let eventLoop = app.eventLoopGroup.next()
        request = Request(application: app, on: eventLoop)
    }
}
