//
//  loading.swift
//  CodeWithStoryBoard
//
//  Created by 사임팸 on 2022/03/14.
//

import Foundation
import UIKit

class Loading {
    static func show() {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.windows.last else { return }
            let loadingIndicatorView: UIActivityIndicatorView
            if let existedView = window.subviews.first(
                where: { $0 is UIActivityIndicatorView } ) as? UIActivityIndicatorView {
                loadingIndicatorView = existedView
            } else {
                loadingIndicatorView = UIActivityIndicatorView(style: .large)
                loadingIndicatorView.frame = window.frame
                window.addSubview(loadingIndicatorView)
            }
            loadingIndicatorView.startAnimating()
        }
    }

    static func hide() {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.windows.last else { return }
            window.subviews.filter({ $0 is UIActivityIndicatorView })
                .forEach { $0.removeFromSuperview() }
        }
    }
}
