//
//  FirstPageViewController.swift
//  CodeWithStoryBoard
//
//  Created by 사임팸 on 2022/03/11.
//

import Foundation
import UIKit
import WebKit

class FirstPageViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configure()
    }
    
    func configure() {
        if let url = URL(string: "https://ontheflea.com") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
