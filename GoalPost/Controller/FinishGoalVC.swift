//
//  FinishGoalVC.swift
//  GoalPost
//
//  Created by Valentinas Mirosnicenko on 5/6/18.
//  Copyright © 2018 Valentinas Mirosnicenko. All rights reserved.
//

import UIKit
import CoreData

class FinishGoalVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var createGoalButton: UIButton!
    @IBOutlet weak var pointsTextField: UITextField!
    
    var goalDescription: String!
    var goalType: GoalType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGoalButton.bindToKeyboard()
        pointsTextField.delegate = self
        
        
    }

    @IBAction func createGoalButtonPressed(_ sender: Any) {
        
        if pointsTextField.text != "" {
            saveGoal { (finished) in
                if finished {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismissDetail()
    }
    
    func initData(withDescription description: String, type: GoalType) {
        self.goalDescription = description
        self.goalType = type
    }
    
    func saveGoal(completion: @escaping (_ finished:Bool) -> Void) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let goal = Goal(context: managedContext)
        
        goal.goalTerm = goalType.rawValue
        goal.goalDescription = goalDescription
        goal.completionValue = Int32(pointsTextField.text!)!
        goal.progress = 0
        
        do {
            try managedContext.save()
            debugPrint("Saved data: \(goal)")
            completion(true)
        } catch {
            debugPrint("Could not save: \(error.localizedDescription)")
            completion(false)
        }
        
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        pointsTextField.text = ""
    }
    
}
