//
//  GoalsVC.swift
//  GoalPost
//
//  Created by Valentinas Mirosnicenko on 5/5/18.
//  Copyright © 2018 Valentinas Mirosnicenko. All rights reserved.
//

import UIKit
import CoreData


let appDelegate = UIApplication.shared.delegate as? AppDelegate

class GoalsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var welcomeTextStack: UIStackView!
    
    var goals: [Goal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        fetch { (success) in
            if success {
                if goals.count > 0 {
                    tableView.isHidden = false
                    welcomeTextStack.isHidden = true
                    tableView.reloadData()
                } else {
                    tableView.isHidden = true
                    welcomeTextStack.isHidden = false
                }
            }
            
        }
        
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") else { return }
        presentDetail(createGoalVC)
    }
    
}


extension GoalsVC {
    
    func fetch(completion: (_ complete: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        
        do {
            goals = try managedContext.fetch(fetchRequest)
            completion(true)
        } catch {
            debugPrint("Something went wrong: \(error.localizedDescription)")
            completion(false)
        }
        
        
    }
    
    
}

extension GoalsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        guard let context = appDelegate?.persistentContainer.viewContext else { return nil }
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (action, indexPath) in
            
            let goal = self.goals[indexPath.row]
            
            context.delete(goal)
            self.fetch(completion: { (success) in
                if success {
                    if self.goals.count > 0 {
                        self.tableView.isHidden = false
                        self.welcomeTextStack.isHidden = true
                        tableView.deleteRows(at: [indexPath], with: .fade)
                        self.tableView.reloadData()
                    } else {
                        self.tableView.isHidden = true
                        self.welcomeTextStack.isHidden = false
                    }
                }
            })
            
            
//            self.tableView.reloadData()
            
            
        }
        
        let addProgressAction = UITableViewRowAction(style: .default, title: "Add Progress") { (action, indexPath) in
            let goal = self.goals[indexPath.row]
            if goal.progress < goal.completionValue {
                goal.progress += 1
                do {
                    try context.save()
                    self.tableView.reloadData()
                } catch {
                    debugPrint("Add Progress Failed: \(error.localizedDescription)")
                }
            }
            
        }
        
        addProgressAction.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        
        
        return [deleteAction, addProgressAction]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell", for: indexPath) as? GoalCell else { return UITableViewCell() }
        let goal = goals[indexPath.row]
        cell.configureCell(goal: goal)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    
}
