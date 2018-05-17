//
//  CreateGoalVC.swift
//  GoalPost
//
//  Created by Valentinas Mirosnicenko on 5/5/18.
//  Copyright © 2018 Valentinas Mirosnicenko. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var goalDescriptionTextView: UITextView!
    @IBOutlet weak var shortTermButton: UIButton!
    @IBOutlet weak var longTermButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var goalType: GoalType = .shortTerm
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.bindToKeyboard()
        goalDescriptionTextView.delegate = self
        
        shortTermButton.setSelectedColor()
        longTermButton.setDeselectedColor()
        
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        dismissDetail()
    }
    
    @IBAction func shortTermButtonPressed(_ sender: Any) {
        goalType = .shortTerm
        shortTermButton.setSelectedColor()
        longTermButton.setDeselectedColor()
    }
    
    @IBAction func longTermButtonPressed(_ sender: Any) {
        goalType = .longTerm
        shortTermButton.setDeselectedColor()
        longTermButton.setSelectedColor()
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        if goalDescriptionTextView.text != "" && goalDescriptionTextView.text != "What is your goal?" {
            guard let finishGoalVC = storyboard?.instantiateViewController(withIdentifier: "FinishGoalVC") as? FinishGoalVC else { return }
            finishGoalVC.initData(withDescription: goalDescriptionTextView.text, type: goalType)
            presentingViewController?.presentSecondaryDetail(finishGoalVC)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        goalDescriptionTextView.text = ""
        goalDescriptionTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
}
