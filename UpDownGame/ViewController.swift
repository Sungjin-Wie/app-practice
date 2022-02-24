//
//  ViewController.swift
//  UpDownGame
//
//  Created by 사임팸 on 2022/02/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        slider.setThumbImage(#imageLiteral(resourceName: "slider_thumb"), for: .normal)
    }

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        print(sender.value)
    }
    
    @IBAction func touchUpHitButton (_ sender: UIButton) {
        print(slider.value)
    }
    
    @IBAction func touchUpResetButton (_ sender: UIButton) {
        slider.value = (slider.maximumValue + slider.minimumValue) / 2
    }

}

