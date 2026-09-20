import SwiftUI
import ShimmerPlaceholder

struct SkeletonCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 12) {
                Circle()
                    .fill(Color.secondary.opacity(0.16))
                    .frame(width: 48, height: 48)
                    .shimmer()

                VStack(alignment: .leading, spacing: 8) {
                    ShimmerPlaceholder(height: 15)
                        .frame(width: 140)

                    ShimmerPlaceholder(height: 11)
                        .frame(width: 90)
                }
            }

            ShimmerPlaceholder(height: 160, cornerRadius: 16)

            ShimmerPlaceholder(height: 13)
            ShimmerPlaceholder(height: 13)
                .frame(width: 230)
        }
        .padding()
    }
}
