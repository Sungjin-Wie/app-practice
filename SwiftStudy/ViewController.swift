//
//  ViewController.swift
//  SwiftStudy
//
//  Created by 사임팸 on 2022/02/24.
//

import UIKit

class ViewController: UIViewController {
    var onClickCount: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClickButton(_ sender: UIButton) {
        onClickCount += 1
        showAlert(message: "외 \(onClickCount)번이나 눌름?")
    }
    
    func showAlert(message: String) {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            }
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
}

