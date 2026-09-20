import XCTest
@testable import ShimmerPlaceholder

final class ShimmerPlaceholderTests: XCTestCase {
    func testValidDurationIsPreserved() {
        XCTAssertEqual(
            ShimmerConfiguration.normalizedDuration(1.5),
            1.5,
            accuracy: 0.0001
        )
    }

    func testTooShortDurationIsClamped() {
        XCTAssertEqual(
            ShimmerConfiguration.normalizedDuration(0),
            ShimmerConfiguration.minimumDuration,
            accuracy: 0.0001
        )
    }

    func testInfiniteDurationUsesFallback() {
        XCTAssertEqual(
            ShimmerConfiguration.normalizedDuration(.infinity),
            ShimmerConfiguration.fallbackDuration,
            accuracy: 0.0001
        )
    }

    func testOpacityIsClampedToZeroAndOne() {
        XCTAssertEqual(
            ShimmerConfiguration.normalizedOpacity(-1),
            0,
            accuracy: 0.0001
        )

        XCTAssertEqual(
            ShimmerConfiguration.normalizedOpacity(2),
            1,
            accuracy: 0.0001
        )
    }

    func testValidOpacityIsPreserved() {
        XCTAssertEqual(
            ShimmerConfiguration.normalizedOpacity(0.45),
            0.45,
            accuracy: 0.0001
        )
    }
}
