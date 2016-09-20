//
//  SignUpManager.swift
//  Quick
//
//  Created by Stephen Fox on 15/08/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

class SignUpManager {
  
  fileprivate let network = Network()
  static let sharedInstace = SignUpManager()
  
  /// Closure type for a sign up response
  typealias SignUpCompletion = (_ success: Bool, _ session: Session?) -> Void
  
  /**
   Attempts to create a user account.
   - parameter user: A user object with information on the user for account creation
   - parameter completion: Completion handler.
   */
  func createUserAccount(_ user: User,
                         completion: @escaping SignUpCompletion) {
    let userJSON = JSONEncoder.encodeUser(user)
    let userJSONObject = JSONEncoder.createUserJSONObject(userJSON);
    
    
    network.postJSON(urlString: Network.NetworkingDetails.createUserEndPoint,
                     jsonParameters: userJSONObject as Dictionary<String, AnyObject>)
    { (success, data) in
      if success {
        // Pass control to network reponse to handle and parse the response.
        NetworkResponse.UserSignUpResponse.handleUserSignUpResponse(data, completion:
          { (success, signUpResponse) in
            if success {
              // Once the data has been handled and parsed, begin a new session.
              let sessionManager = SessionManager.sharedInstance
              do {
                try sessionManager.registerSessionFromSignUpResponse(signUpResponse!)
                try sessionManager.begin()
                let session = SessionManager.sharedInstance.activeSession
                completion(true, session)
              }
              catch {
                completion(false, nil)
              }
            }
            else {
              completion(false, nil)
            }
        })
      }
      else {
        // An error occurred during account creation.
        completion(false, nil)
      }
    }
  }
}
