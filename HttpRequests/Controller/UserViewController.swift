//
//  ViewController.swift
//  HttpRequests
//
//  Created by Jagadeesh on 29/12/21.
//

import UIKit
import SDWebImage

class UserViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var listOfUsers = [UserData]()
    //var manager = UserManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        //manager.delegate = self
       // manager.getListOfUsers(with: manager.userURL )
        
        UserManager.shared.getUserDetails { (data, error) in
            if let UsersList = data {
                DispatchQueue.main.async {
                    self.listOfUsers = UsersList
                    self.tableView.reloadData()
                }
            } else if let error = error {
                print("error: \(error)")
            }
        }
        
  }

    @IBAction func AddButtonTapped(_ sender: Any) {
        let VC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "CreateUserViewController") as! CreateUserViewController
      
       present(VC,animated: true)
    }
    
}

extension UserViewController: UserManagerDelegate {
    func dataReceived(usersList: [UserData]) {
        self.listOfUsers = usersList
        tableView.reloadData()
    }
    
    func errorReceived(error: String) {
        print("Error :\(error)")
    }
    
    
}

extension UserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = listOfUsers[indexPath.row]
        guard user.email != nil else {
            return 
        }
        let VC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "ChangeUserViewController") as! ChangeUserViewController
        VC.user = user
       present(VC,animated: true)
       
    }
}

extension UserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as!   UserCell
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.systemBlue.cgColor
        
        let person = listOfUsers[indexPath.row]
        cell.userImage.sd_setImage(with: URL(string: person.avatar ?? ""), placeholderImage: nil, options: .progressiveLoad, context: nil)
        cell.userId?.text = "UserId:  \(String(person.id))"
        cell.userEmail?.text = "UserEmail:  \(person.email)"
        cell.userFirstName?.text = "UserFirstName:  \(person.first_name)"
        cell.userLastName?.text = "UserLastName:  \(person.last_name)"
        return cell
    }
    
    
}


