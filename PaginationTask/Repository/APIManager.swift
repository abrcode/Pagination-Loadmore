//
//  APIManager.swift
//  PaginationTask
//
//  Created by Aniket Rao on 23/12/21.
//

import Foundation
//import Alamofire



class APIManager {
    
    
    func fetchData(){
       
        let url = URL(string: "http://hn.algolia.com/api/v1/search_by_date?tags=story&page=")
        var request = URLRequest(url: url!)
        
        request.setValue("authToken", forHTTPHeaderField: "Authorization")
        
        
//        let postBody = PostData.self
//        let postData = try? JSONSerialization.data(withJSONObject: postBody, options: [])
        
        request.httpMethod = "GET"
//        request.httpBody = postData
        
        
        let session = URLSession.shared
        session.dataTask(with: url!) { ( data, response , error) in
            
            if let data = data {
                do {
                    let response = try? JSONDecoder().decode(PostData.self, from: data)
                    print(response)
                } catch{
                    
                }
            }
            
        }.resume()
        
    }
    
    
}
