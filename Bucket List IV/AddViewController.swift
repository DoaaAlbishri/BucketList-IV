//
//  AddViewController.swift
//  Bucket List IV
//
//  Created by admin on 26/12/2021.
//

import UIKit


protocol AddDelegate{
    
}

class AddViewController: UIViewController {
    var delegate : TasksTableViewController?

    @IBOutlet weak var textField: UITextField!
    
    @IBAction func submitButton(_ sender: UIButton) {
        let text = textField.text!
        TaskModel.addTaskWithObjective(objective: text, completionHandler: {
            data, response , error in
            if data != nil{
                do{
                let task = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                DispatchQueue.main.async {
                    self.delegate?.tasks.append(task)
                    self.delegate?.tableView.reloadData()
                    let _ = self.navigationController?.viewControllers.popLast()
                }
                }catch{
                    print(error)
                }
            }else{
                print("no response")
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
