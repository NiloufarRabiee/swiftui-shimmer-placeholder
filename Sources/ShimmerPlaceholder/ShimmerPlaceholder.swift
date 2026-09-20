import SwiftUI

/// Configuration values used by the shimmer animation.
public struct ShimmerConfiguration {
    public let duration: TimeInterval
    public let highlightOpacity: Double
    public let angle: Angle

    public init(
        duration: TimeInterval = 1.25,
        highlightOpacity: Double = 0.55,
        angle: Angle = .degrees(20)
    ) {
        self.duration = ShimmerConfiguration.normalizedDuration(duration)
        self.highlightOpacity = ShimmerConfiguration.normalizedOpacity(highlightOpacity)
        self.angle = angle
    }

    static let minimumDuration: TimeInterval = 0.2
    static let fallbackDuration: TimeInterval = 1.25

    static func normalizedDuration(_ duration: TimeInterval) -> TimeInterval {
        guard duration.isFinite else {
            return fallbackDuration
        }

        return max(duration, minimumDuration)
    }

    static func normalizedOpacity(_ opacity: Double) -> Double {
        guard opacity.isFinite else {
            return 0.55
        }

        return min(max(opacity, 0), 1)
    }
}

/// Adds a lightweight animated shimmer highlight to any SwiftUI view.
public struct ShimmerModifier: ViewModifier {
    private let isActive: Bool
    private let configuration: ShimmerConfiguration

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var phase: CGFloat = -1.2

    public init(
        isActive: Bool = true,
        configuration: ShimmerConfiguration = .init()
    ) {
        self.isActive = isActive
        self.configuration = configuration
    }

    public func body(content: Content) -> some View {
        content
            .overlay {
                if isActive && !reduceMotion {
                    GeometryReader { proxy in
                        LinearGradient(
                            colors: [
                                .clear,
                                .white.opacity(configuration.highlightOpacity),
                                .clear
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .frame(width: max(proxy.size.width * 0.65, 44))
                        .rotationEffect(configuration.angle)
                        .offset(x: phase * proxy.size.width * 1.7)
                        .blendMode(.screen)
                        .onAppear {
                            startAnimation()
                        }
                    }
                    .mask(content)
                    .allowsHitTesting(false)
                }
            }
            .onChange(of: isActive) { newValue in
                if newValue && !reduceMotion {
                    startAnimation()
                } else {
                    phase = -1.2
                }
            }
    }

    private func startAnimation() {
        phase = -1.2

        withAnimation(
            .linear(duration: configuration.duration)
            .repeatForever(autoreverses: false)
        ) {
            phase = 1.2
        }
    }
}

public extension View {
    /// Applies an animated shimmer effect.
    func shimmer(
        isActive: Bool = true,
        configuration: ShimmerConfiguration = .init()
    ) -> some View {
        modifier(
            ShimmerModifier(
                isActive: isActive,
                configuration: configuration
            )
        )
    }
}

/// A simple rounded placeholder that already includes the shimmer effect.
public struct ShimmerPlaceholder: View {
    private let height: CGFloat
    private let cornerRadius: CGFloat
    private let configuration: ShimmerConfiguration

    public init(
        height: CGFloat = 16,
        cornerRadius: CGFloat = 8,
        configuration: ShimmerConfiguration = .init()
    ) {
        self.height = max(height, 1)
        self.cornerRadius = max(cornerRadius, 0)
        self.configuration = configuration
    }

    public var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            .fill(Color.secondary.opacity(0.16))
            .frame(height: height)
            .shimmer(configuration: configuration)
            .accessibilityHidden(true)
    }
}

#Preview {
    VStack(alignment: .leading, spacing: 14) {
        HStack(spacing: 12) {
            Circle()
                .fill(Color.secondary.opacity(0.16))
                .frame(width: 52, height: 52)
                .shimmer()

            VStack(alignment: .leading, spacing: 8) {
                ShimmerPlaceholder(height: 16)
                    .frame(width: 150)

                ShimmerPlaceholder(height: 12)
                    .frame(width: 100)
            }
        }

        ShimmerPlaceholder(height: 120, cornerRadius: 14)

        ShimmerPlaceholder(height: 14)
        ShimmerPlaceholder(height: 14)
            .frame(width: 220)
    }
    .padding()
}
