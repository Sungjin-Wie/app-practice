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
let url = "https://jsonplaceholder.typicode.com/todos"
let fetchTodos = AF.request(url,
                            method: .get,
                            parameters: nil,
                            encoding: URLEncoding.default,
                            headers: ["Content-Type":"application/json", "Accept":"application/json"])
    .validate(statusCode: 200..<300)
    .serializingDecodable([Todo].self)


class SecondPageViewController: UIViewController {
    let scrollView = UIScrollView()
    let mainStackView = UIStackView()
    let refreshButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("새로고침", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(onTouchRefreshButton), for: .touchUpInside)
        return button
    }()
    var todoLists: [Todo] = []
    @IBOutlet weak var secondTabBarbutton: UITabBarItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            Loading.show()
            setupScrollView()
            try? await getData()
            Loading.hide()
            setupMainStackView()
            putDataIntoStackView()
        }
    }
    
    func setupMainStackView() {
        mainStackView.axis = .vertical
        mainStackView.distribution = .equalSpacing
        mainStackView.spacing = 30
        mainStackView.axis = .vertical
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.alignment = .center
        scrollView.addSubview(mainStackView)
        let contentLayoutGuide = scrollView.contentLayoutGuide
        NSLayoutConstraint.activate([
            mainStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            mainStackView.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor)
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
        view.addSubview(refreshButton)
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.bounces  = true
//        scrollView.refreshControl = UIRefreshControl()
//        // add target to UIRefreshControl
//        scrollView.refreshControl?.addTarget(self, action: #selector(callPullToRefresh), for: .valueChanged)
        let frameLayoutGuide = scrollView.frameLayoutGuide
        NSLayoutConstraint.activate([
            frameLayoutGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            frameLayoutGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            frameLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            frameLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            refreshButton.topAnchor.constraint(equalTo: scrollView.bottomAnchor),
            refreshButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            refreshButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func onTouchRefreshButton() {
        Task {
            Loading.show()
            mainStackView.arrangedSubviews.forEach { subView in
                mainStackView.removeArrangedSubview(subView)
                subView.removeFromSuperview()
            }
            mainStackView.removeFromSuperview()
            Loading.show()
            try? await getData()
            self.todoLists = self.todoLists.shuffled()
            setupMainStackView()
            putDataIntoStackView()
            Loading.hide()
        }
    }
    
    func putDataIntoStackView() {
        print("putDataIntoStackView() started")
        self.todoLists.forEach { todo in
            let button = createButtons(todo: todo)
            mainStackView.addArrangedSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -100).isActive = true
        }
        print("putDataIntoStackView() completed")
        Loading.hide()
    }
    
    func getData() async throws -> Void {
        do {
            print("getData() started")
            let result = try await fetchTodos.value
            self.todoLists = result
            print("getData() completed")
        } catch (let error) {
            print(error)
        }
    }
}
