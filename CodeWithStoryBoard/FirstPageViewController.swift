//
//  FirstPageViewController.swift
//  CodeWithStoryBoard
//
//  Created by 사임팸 on 2022/03/11.
//

import Foundation
import UIKit
import WebKit

class FirstPageViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    let refreshControl = UIRefreshControl()
    @IBOutlet weak var wkWebView: WKWebView!
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureWebView()
    }
    
    func configureWebView() {
        wkWebView.uiDelegate = self
        wkWebView.navigationDelegate = self
        view.addSubview(wkWebView!)
        let url = URL(string: "https://ontheflea.com")!
        wkWebView.load(URLRequest(url: url))
        refreshControl.addTarget(self, action: #selector(reloadWebView(_:)), for: .valueChanged)
        wkWebView.scrollView.addSubview(refreshControl)
    }
    @objc func reloadWebView(_ sender: UIRefreshControl) {
           wkWebView.reload()
           sender.endRefreshing()
       }

    func webView(_ webView: WKWebView,
                 runJavaScriptAlertPanelWithMessage message: String,
                 initiatedByFrame frame: WKFrameInfo,
                 completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let title = NSLocalizedString("OK", comment: "OK Button")
        let ok = UIAlertAction(title: title, style: .default) { (action: UIAlertAction) -> Void in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(ok)
        present(alert, animated: true)
        completionHandler()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        wkWebView.evaluateJavaScript("""
//alert("안녕하세요.")
""", completionHandler: nil)
    }
    
}
