//
//  UserManager.swift
//  HttpRequests
//
//  Created by Jagadeesh on 29/12/21.
//

import Foundation
import Alamofire

protocol UserManagerDelegate {
    func dataReceived(usersList: [UserData])
    func errorReceived(error: String)
}

struct UserManager  {
    static let shared = UserManager()
    private init() {  }
    //  Get All Users Details through GetMethod
    let userURL = "https://reqres.in/api/users?per_page=20"
    var delegate : UserManagerDelegate?
    
    func userDetails(id: String) {
        let urlString = "\(userURL)"
        getListOfUsers(with: urlString)
    }
    
    func getUserDetails(completion: @escaping (_ list: [UserData]?, _ error: String?) -> Void) {
        AF.request(userURL).response { response in
            if let code = response.response?.statusCode, code == 200 {
                if let data = response.data {
                    if let user = self.parseUsersListJSON(person: data) {
                        completion(user.data,nil)
                    } else {
                        completion(nil,"something went wrong, please try again")
                    }
                } else {
                    completion(nil,"No data  available")
                }
            } else {
                completion(nil,response.error?.localizedDescription ?? "something went wrong, please try again")
            }
        }
        
    }
    
    func getListOfUsers(with urlString: String) {
       /* if  let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    self.delegate?.errorReceived(error: error!.localizedDescription)
                    }
                    return
                }
                if let safeData = data {
                    if let user = self.parseUsersListJSON(person: safeData) {
                        DispatchQueue.main.async {
                            self.delegate?.dataReceived(usersList: user.data)
                            print(user)
                        }
                    }
                }
            }
            task .resume()
        } */
    }
    
    func parseUsersListJSON(person: Data) -> User? {
    let decoder = JSONDecoder ()
        do {
            let userData = try  decoder.decode(User.self, from: person)
            return userData
        } catch let error as NSError {
            print(error.localizedDescription)
            DispatchQueue.main.async {
                self.delegate?.errorReceived(error: error.localizedDescription)
            }
            return nil
        }
        
    }
    
    
  // Update User Details through put method
     let  userUpdateURL = "https://reqres.in/api/users/"
    
     func updateUserDetails(user: UserData, _ completion: @escaping (_ status: Bool) -> Void) {
        let urlString = "\(UserManager.shared.userUpdateURL)\(user.id)"
        let request = AF.request(urlString, method: .put, parameters: ["id": "\(user.id)", "first_name": user.first_name, "last_name": user.last_name, "email": user.email], encoder: URLEncodedFormParameterEncoder.default, headers: nil, interceptor: nil, requestModifier: nil)
        request.response(completionHandler: { response in
            guard response.error == nil else {
                completion(false)
                return
            }
            if let statusCode = response.response?.statusCode, statusCode == 200 {
                completion(true)
            } else {
                completion(false)
            }
        })
    }
    
  
    func parseUserJSON(person: Data) -> UserData? {
    let decoder = JSONDecoder ()
        do {
            let userData = try  decoder.decode(UserData.self, from: person)
            return userData
        } catch let error as NSError {
            print(error.localizedDescription)
            DispatchQueue.main.async {
                self.delegate?.errorReceived(error: error.localizedDescription)
            }
            return nil
        }
        
    }
    
   
    // Create New User through post method
  static  let createUserURL = "https://reqres.in/api/users"
 static  func createNewUser(user: UserData, _ completion: @escaping (_ status: Bool) -> Void) {
    let urlString = "\(createUserURL)"
        let parameters = ["id": String(user.id), "first_name": user.first_name , "last_name": user.last_name, "email": user.email]
        let request = AF.request(urlString, method: .post, parameters:parameters , encoder: URLEncodedFormParameterEncoder.default, headers: nil, interceptor: nil, requestModifier: nil)
        request.response(completionHandler: { response in
            guard response.error == nil else {
                completion(false)
                return
            }
            if let statusCode = response.response?.statusCode, statusCode == 201 {
                completion(true)
            } else {
                completion(false)
            }
        })
    }
    

}



