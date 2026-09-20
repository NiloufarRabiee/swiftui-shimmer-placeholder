# ShimmerPlaceholder

A tiny reusable **SwiftUI shimmer loading effect and skeleton placeholder** for iOS and macOS.

Use it when content is still loading and you want a lightweight visual placeholder instead of a spinner.

## Features

- Native SwiftUI
- No third-party dependencies
- Reusable `.shimmer()` modifier
- Ready-made `ShimmerPlaceholder`
- Configurable animation duration
- Configurable highlight opacity
- Configurable shimmer angle
- Works with any SwiftUI view
- Respects Reduce Motion
- iOS and macOS support
- Swift Package Manager support

## Requirements

- iOS 16+
- macOS 13+
- Swift 5.9+

## Installation

### Swift Package Manager

In Xcode:

1. Open your project.
2. Go to **File > Add Package Dependencies...**
3. Enter:

```
https://github.com/NiloufarRabiee/swiftui-shimmer-placeholder
```

4. Add the `ShimmerPlaceholder` package to your app target.

Then import it:

```swift
import ShimmerPlaceholder
```

## Basic Usage

Apply shimmer to any SwiftUI view:

```swift
RoundedRectangle(cornerRadius: 12)
    .fill(Color.secondary.opacity(0.16))
    .frame(height: 120)
    .shimmer()
```

## Ready-Made Placeholder

```swift
ShimmerPlaceholder(height: 16)
    .frame(width: 180)
```

## Skeleton Card Example

```swift
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
```

## Customization

```swift
let configuration = ShimmerConfiguration(
    duration: 1.8,
    highlightOpacity: 0.4,
    angle: .degrees(15)
)

RoundedRectangle(cornerRadius: 16)
    .fill(Color.secondary.opacity(0.16))
    .frame(height: 120)
    .shimmer(configuration: configuration)
```

## Disable the Effect

```swift
content
    .shimmer(isActive: isLoading)
```

## Accessibility

The shimmer animation automatically stops when the user enables **Reduce Motion**.

The ready-made placeholder is hidden from accessibility because it represents loading decoration rather than meaningful content.

## Example

A complete skeleton card example is included in:

```
Examples/SkeletonCard.swift
```

## Testing

Run:

```bash
swift test
```

GitHub Actions CI is included.

## Contributing

Contributions and improvements are welcome.

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

This project is available under the MIT License.

See [LICENSE](LICENSE).

---

Created by **Niloufar Rabiee**
