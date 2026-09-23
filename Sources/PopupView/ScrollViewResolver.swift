//
//  ScrollViewResolver.swift
//  PopupView
//
//  Finds the SwiftUI ScrollView that contains the popup content.
//

#if os(iOS)
import SwiftUI

struct ScrollViewResolver: UIViewRepresentable {
    var onResolve: (UIScrollView) -> Void

    func makeUIView(context: Context) -> ResolverView {
        ResolverView()
    }

    func updateUIView(_ uiView: ResolverView, context: Context) {
        uiView.onResolve = onResolve
        uiView.resolveIfNeeded()
    }
}

final class ResolverView: UIView {
    var onResolve: ((UIScrollView) -> Void)?
    private weak var resolvedScrollView: UIScrollView?

    override func didMoveToWindow() {
        super.didMoveToWindow()
        resolveIfNeeded()
    }

    func resolveIfNeeded() {
        DispatchQueue.main.async { [weak self] in
            guard let self, let scrollView = enclosingScrollView(), scrollView !== resolvedScrollView else { return }
            resolvedScrollView = scrollView
            onResolve?(scrollView)
        }
    }

    private func enclosingScrollView() -> UIScrollView? {
        var view = superview
        while let currentView = view {
            if let scrollView = currentView as? UIScrollView {
                return scrollView
            }
            view = currentView.superview
        }
        return nil
    }
}
#endif
