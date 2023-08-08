//
//  BMIViewController.swift
//  BMI
//
//  Created by 김서연 on 2023/08/08.
//

import UIKit

class BMIViewController: UIViewController {
    @IBOutlet weak var resultValue: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var recalculateButton: UIButton!
    
    var bmi: Double?
    override func viewDidLoad() {
        super.viewDidLoad()

        makeUI()
        // Do any additional setup after loading the view.
    }
    
    func makeUI(){
        
        resultValue.clipsToBounds = true
        resultValue.layer.cornerRadius = 8
        
        recalculateButton.clipsToBounds = true
        recalculateButton.layer.cornerRadius = 5
        
        guard let bmi = bmi else { return }
        resultValue.text = String(bmi)
        resultValue.backgroundColor = getBackGroundColor()
        infoLabel.textColor = getBackGroundColor()
    }
    func getBackGroundColor() -> UIColor{
        guard let bmi = bmi else { return UIColor.black }
        switch bmi{
        case ..<18.6:
            infoLabel.text = "저체중"
            return UIColor.systemBlue
        case 18.6..<23.0:
            infoLabel.text = "표준"
            return UIColor.systemGreen
        case 23.0..<25.0:
            infoLabel.text = "과체중"
            return UIColor.systemPurple
        case 25.0..<30.0:
            infoLabel.text = "중도비만"
            return UIColor.systemPink
        case 30.0...:
            infoLabel.text = "비만"
            return UIColor.systemRed
        default:
            return UIColor.black
        }
    }
    
    @IBAction func recalculateButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    

}
