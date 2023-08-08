//
//  ViewController.swift
//  BMI
//
//  Created by 김서연 on 2023/08/08.
//

import UIKit

class ViewController: UIViewController{
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var calculateButton: UIButton!
    
    var bmi: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        makeUI()
    }
    func makeUI(){
        heightTextField.delegate = self
        weightTextField.delegate = self
        
        mainLabel.text = "키와 몸무게를 입력해 주세요"
        heightLabel.text = "키"
        heightLabel.textColor = UIColor.label
        weightLabel.text = "몸무게"
        weightLabel.textColor = UIColor.label
        
        calculateButton.clipsToBounds = true
        calculateButton.layer.cornerRadius = 5
        
        calculateButton.setTitle("BMI 계산하기", for: .normal)
        heightTextField.placeholder = "cm 단위로 입력해주세요"
        weightTextField.placeholder = "kg 단위로 입력해주세요"
    }

    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        guard let height = heightTextField.text, let weight = weightTextField.text else {return}
        bmi = calculateBMI(height, weight)
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if heightTextField.text == "" || weightTextField.text == ""{
            mainLabel.text = "키와 몸무게를 정확히 입력해주세요"
            if heightTextField.text == ""{
                heightLabel.textColor = UIColor.red
            }
            if weightTextField.text == ""{
                weightLabel.textColor = UIColor.red
            }
            return false
        }
        mainLabel.text = "키와 몸무게를 입력해주세요"
        heightLabel.textColor = UIColor.label
        weightLabel.textColor = UIColor.label
        return true
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tobmiVC"{
            let bmiVC = segue.destination as! BMIViewController
            
            bmiVC.bmi = self.bmi
            
        }
        heightTextField.text = ""
        weightTextField.text = ""
    }
    
    func calculateBMI(_ height: String,_ weight: String) -> Double{
        guard let h = Double(height), let w = Double(weight) else { return 0.0}
        var bmi = w / (h*h) * 10000
        bmi = round(bmi*10)/10
        print("BMI 결과값 \(bmi)")
        return bmi
    }
}

extension ViewController: UITextFieldDelegate{ //확장하여 delegate를 구현
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if Int(string) != nil || string == ""{
            return true
        }
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if heightTextField.text != "", weightTextField.text != ""{
            // 두개의 텍스트 필드 모두 빈문자열이 아니라면
            // 키보드 내려가기
            weightTextField.resignFirstResponder()
            return true
        } else if heightTextField.text != ""{
            // height텍스트피드가 빈문자열이 아니라면
            // weight텍스트필드로 커서가 넘어감
            weightTextField.becomeFirstResponder()
            return true
        }
        return false
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        heightTextField.resignFirstResponder()
        weightTextField.resignFirstResponder()
    }
}
