//
//  TasksModel.swift
//  Bucket List IV
//
//  Created by admin on 26/12/2021.
//

import Foundation

class TaskModel {
    static func getAllTasks(completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        let url = URL(string: "http://localhost:8000/tasks")
        let session = URLSession.shared
        let task = session.dataTask(with: url!, completionHandler: completionHandler)
        task.resume()
    }
    static func addTaskWithObjective(objective: String, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
     // Create the url to request
            if let urlToReq = URL(string: "http://localhost:8000/tasks") {
                // Create an NSMutableURLRequest using the url. This Mutable Request will allow us to modify the headers.
                var request = URLRequest(url: urlToReq)
                // Set the method to POST
                request.httpMethod = "POST"
                // Create some bodyData and attach it to the HTTPBody
                let bodyData = "objective=\(objective)"
                request.httpBody = bodyData.data(using: .utf8)
                // Create the session
                let session = URLSession.shared
                let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
                task.resume()
            }
    }
    static func updateTask(task: NSDictionary, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        if let urlToReq = URL(string: "http://localhost:8000/tasks") {
            var request = URLRequest(url: urlToReq)
            // Set the method to PUT for update
            request.httpMethod = "PUT"
            do{
                let bodyData = try JSONSerialization.data(withJSONObject: task, options: .prettyPrinted)
                request.httpBody = bodyData
                
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let session = URLSession.shared
                let task = session.dataTask(with: request, completionHandler: completionHandler)
                task.resume()
            }catch{
                print(error)
            }
    }
}
    
    static func deleteTask(id: Int, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        if let urlToReq = URL(string: "http://localhost:8000/tasks") {
            var request = URLRequest(url: urlToReq)
            // Set the method to DELETE for delete
            request.httpMethod = "DELETE"
            let bodyData = "id\(id)"
            request.httpBody = bodyData.data(using: String.Encoding.utf8)
            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: completionHandler)
            task.resume()
        }
    }
}
