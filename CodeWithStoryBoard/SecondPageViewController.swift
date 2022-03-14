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
    let completed: Bool
    let id: Int
    let title: String
    let userId: Int
}


class SecondPageViewController: UIViewController {
    let tableView = UITableView()
    let scrollView = UIScrollView()
    let mainStackView = UIStackView()
    var todoLists: [Todo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        LoadingService.showLoading()
        setupScrollView()
        getData()
    }
    
    
    func setupMainStackView(){
        mainStackView.axis = .vertical
        mainStackView.distribution = .equalSpacing
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(mainStackView)
        let contentLayoutGuide = scrollView.contentLayoutGuide
        NSLayoutConstraint.activate([
            mainStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            mainStackView.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor)
        ])
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.spacing = 30
        stackView.axis = .vertical
        stackView.alignment = .center
        self.todoLists.forEach { todo in
            let button = createButtons(todo: todo)
            stackView.addArrangedSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -100).isActive = true
        }
        mainStackView.addArrangedSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),
            stackView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor)
        ])
    }
    
    func createButtons(todo: Todo, color: UIColor = .blue) -> UIButton{
        let button = UIButton(configuration: .filled())
        button.setTitle(todo.title, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.contentHorizontalAlignment = .center
        return button
    }
    
    
    func setupScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
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
            .responseData { (response) in
                switch response.result {
                case .success(let data):
                    do {
                        self.todoLists = try JSONDecoder().decode([Todo].self, from: data)
                        self.setupMainStackView()
                        LoadingService.hideLoading()
                    } catch {
                        print(error)
                    }
            default:
                break
            }
    }
}
}
