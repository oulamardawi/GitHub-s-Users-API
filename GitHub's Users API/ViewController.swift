//
//  ViewController.swift
//  GitHub's Users API
//
//  Created by Oula mardawi on 27/04/2022.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet var usersTableView: UITableView!
    let userCellModel: UserCellViewModel! = nil
    let userCellIdentifier = "userCell"
    var users = [MyResults]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "https://api.github.com/users?since=0"
        getData(from: url)
        usersTableView.delegate = self
        usersTableView.dataSource = self
        // usersTableView.register(UserTableViewCell.self, forCellReuseIdentifier: userCellIdentifier )
        usersTableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: userCellIdentifier)
        
    }
    
    private func getData(from url: String) {
        
        //Request
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            
            guard let data = data, error == nil else {
                print("sth is nil")
                return
            }
            //have data :convert it to struct
            var result: [MyResults]?
            do {
                result = try JSONDecoder().decode([MyResults].self, from: data)
            }
            catch {
                print("failed to convert \(error.localizedDescription)")
            }
            guard let json = result else {
                return
            }
            self.users = json
            
            DispatchQueue.main.async {
                self.usersTableView.reloadData()
            }
            print ("------")
        })
        task.resume()
    }
    //codable protocol: convert data we get from url to struct
    
    struct MyResults: Codable {
        let login: String
        let id: Int
        let node_id: String
        let avatar_url: String
        let gravatar_id: String
        let url: String
        let html_url: String
        let followers_url: String
        let following_url: String
        let gists_url: String
        let starred_url: String
        let subscriptions_url: String
        let organizations_url: String
        let repos_url: String
        let events_url: String
        let received_events_url: String
        let type: String
        let site_admin: Bool
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let userTableCell = usersTableView.dequeueReusableCell(withIdentifier: userCellIdentifier) as? UserTableViewCell {
            userTableCell.userIdLabel.text = (users[indexPath.row].id).codingKey.stringValue
            userTableCell.userNameLabel.text = users[indexPath.row].login
            userTableCell.userImageView.kf.setImage(with: URL(string: users[indexPath.row].avatar_url))
                return userTableCell
                     }
                return UITableViewCell()
        }
          }
                
