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

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            if let scrollView = view.enclosingScrollView() {
                onResolve(scrollView)
            }
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

private extension UIView {
    func enclosingScrollView() -> UIScrollView? {
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
