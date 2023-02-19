//
//  APIManager.swift
//  PaginationTask
//
//  Created by Aniket Rao on 23/12/21.
//

import Foundation
import Alamofire



class APIManager {
    
    static let shared = APIManager()
    
    let connectivityManager = NetworkReachabilityManager()
    
    
    
    // MARK: - NORMAl GET API Call
    
    func  getRequestAPICall <T: Codable> ( urlString : String! ,
                                           method: HTTPMethod,
                                           parameters: Parameters,
                                           type: T.Type,
                                           completion : @escaping (T? , String?) -> Void ){
        
        
        AF.request(urlString, method: method, parameters: parameters).responseJSON { response in
            
            switch response.result{
            case .success(_):
                
                if response.value != nil , response.value is NSDictionary {
                    
                    
                    guard let data = response.data else { return completion(nil , response.error?.localizedDescription) }
                    
                    do {
                        let returnResponse = try JSONDecoder().decode(T.self, from: data)
                        
                        completion(returnResponse , nil)
                        
                    } catch {
                        
                        completion(nil , response.error?.localizedDescription)
                    }
                }
                break
            case .failure(let error):
                
                completion(nil, error.localizedDescription)
                
                break
            }
        }
    }
}
