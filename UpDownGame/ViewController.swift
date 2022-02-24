//
//  ViewController.swift
//  UpDownGame
//
//  Created by 사임팸 on 2022/02/24.
//

import UIKit

class ViewController: UIViewController {
    
    var randomValue: Int = 0
    var tryCount: Int = 0
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var tryCountLabel: UILabel!
    @IBOutlet weak var currentValueLabel: UILabel!
    @IBOutlet weak var minimumValueLabel: UILabel!
    @IBOutlet weak var maximumValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        slider.setThumbImage(#imageLiteral(resourceName: "slider_thumb"), for: .normal)
        reset()
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        currentValueLabel.text = "\(Int(round(slider.value)))"
    }
    
    @IBAction func touchUpHitButton(_ sender: UIButton) {
        let hitValue: Int = Int(round(slider.value))
        slider.value = Float(hitValue)
        tryCount += 1
        tryCountLabel.text = "\(tryCount) / 5"
        
        if randomValue == hitValue {
            showAlert(message: "YOU WON")
        } else if tryCount >= 5 {
            showAlert(message: "YOU LOSE")
        } else if randomValue > hitValue {
            slider.minimumValue = Float(hitValue)
            minimumValueLabel.text = "\(hitValue)"
        } else {
            slider.maximumValue = Float(hitValue)
            maximumValueLabel.text = "\(hitValue)"
        }
        
    }
    
    @IBAction func touchUpResetButton(_ sender: UIButton) {
        showAlert(message: "리셋되었습니다.")
    }
    
    func reset() {
        randomValue = Int.random(in: 0...30)
        print("randomValue reset to \(randomValue)")
        tryCount = 0
        tryCountLabel.text = "\(tryCount) / 5"
        slider.minimumValue = 0
        slider.maximumValue = 30
        slider.value = (slider.maximumValue + slider.minimumValue) / 2
        minimumValueLabel.text = "\(Int(slider.minimumValue))"
        maximumValueLabel.text = "\(Int(slider.maximumValue))"
        currentValueLabel.text = "\(Int(slider.value))"
        
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.reset()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
}

