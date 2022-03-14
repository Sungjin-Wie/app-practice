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
    let scrollView = UIScrollView()
    let mainStackView = UIStackView()

    var userLists: [[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupScrollView()
        getData()
    }
    
    func createButtons(text: String, color: UIColor = .blue) -> UIButton{
        let button = UIButton(type: .system)
        button.setTitle(text, for: .normal)
        button.setTitleColor(color, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.contentHorizontalAlignment = .center
        return button
    }
    
    func setupButtons(list todoList: [[String: Any]]){
        print(todoList)
//        let buttonTitles = todos.map{ todo in
//            print(todo)
//            return todo["id"]
//        }
        let buttonTitles = todoList.map{ todo in
            todo["title"]
        }

        let buttonStack = UIStackView()
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.distribution = .equalSpacing
        buttonStack.axis = .vertical
        buttonStack.alignment = .fill
        buttonTitles.forEach { title in
            buttonStack.addArrangedSubview(createButtons(text: title as! String))
        }
        mainStackView.addArrangedSubview(buttonStack)
        NSLayoutConstraint.activate([
            buttonStack.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),
            buttonStack.heightAnchor.constraint(equalTo: mainStackView.heightAnchor)
        ])
    }
    func setupMainStackView(list todoList: [[String: Any]]){
        mainStackView.axis = .vertical
        mainStackView.distribution = .equalSpacing
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(mainStackView)
        // 1
        let contentLayoutGuide = scrollView.contentLayoutGuide
        NSLayoutConstraint.activate([
            // 2
            mainStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            mainStackView.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor)
        ])
        setupButtons(list: todoList)
    }

    func setupScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView) // 1
        let frameLayoutGuide = scrollView.frameLayoutGuide
        NSLayoutConstraint.activate([
            frameLayoutGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            frameLayoutGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            frameLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            frameLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    
    func getData() {
        let url = "https://jsonplaceholder.typicode.com/todos"
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
            .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    if let resArray = value as? [[String: Any]]{
                        self.userLists = resArray
                        self.setupMainStackView(list: resArray)
                        }
                default:
                    break
                }
            }
    }
}
