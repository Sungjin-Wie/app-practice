//
//  SecondPageViewController.swift
//  CodeWithStoryBoard
//
//  Created by 사임팸 on 2022/03/11.
//

import Foundation
import UIKit
import Alamofire

struct Todo: Codable {
    let completed: Int
    let id: Int
    let title: String
    let userId: Int
}

struct APIResponse: Codable {
    let todos: [Todo]
}

class SecondPageViewController: UIViewController {
    let tableView = UITableView()
    var dataSource: [Todo] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        AF.request("https://jsonplaceholder.typicode.com/todos").responseJSON() { (response) in
            switch response.result {
            case .success(let res): do {
                let jsonData = try JSONSerialization.data(withJSONObject: res, options: .prettyPrinted)
                print(jsonData)
                let json = try JSONDecoder().decode(APIResponse.self, from: jsonData)
                print(json)
            } catch(let err) {
                print(err.localizedDescription)
            }
            case .failure(let error):
                print("Error: \(error)")
                return
            }
        }
    }
}
