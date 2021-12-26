//
//  TasksTableViewController.swift
//  Bucket List IV
//
//  Created by admin on 26/12/2021.
//

import UIKit

class TasksTableViewController: UITableViewController {

    var tasks = [NSDictionary]()
    
        override func viewDidLoad() {
                TaskModel.getAllTasks() {
                    data, response, error in
                    do {
                        if data != nil {
                        let tasks = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSArray
                            for task in tasks! {
                                self.tasks.append(task as! NSDictionary)
                            }
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    } catch {
                        print("Something went wrong")
                    }
                }
                super.viewDidLoad()
        }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]["objective"] as? String
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddViewController
        vc.delegate = self
    }

}
