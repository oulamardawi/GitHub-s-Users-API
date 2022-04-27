//
//  ViewController.swift
//  GitHub's Users API
//
//  Created by Oula mardawi on 27/04/2022.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "https://api.github.com/users?since=0"
        getData(from: url)
    }
    
    private func getData(from url: String) {
        
        //Request
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            
            guard let data = data, error == nil else {
                print("sth is nil")
                return
            }
            //have data :convert it to struct
            var result: [myResults]?
            do {
                result = try JSONDecoder().decode([myResults].self, from: data)
              }
            catch {
                print("failed to convert \(error.localizedDescription)")
               }
            guard let json = result else {
                return
               }
            for i in json{
                print ("\(i.id) \(i.login) \n")

            }
            print ("------")
        })
        task.resume()
    }
    //codable protocol: convert data we get from url to struct
 
    struct myResults: Codable {
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

