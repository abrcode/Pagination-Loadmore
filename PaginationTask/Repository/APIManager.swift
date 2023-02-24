//
//  APIManager.swift
//  PaginationTask
//
//  Created by Aniket Rao on 23/12/21.
//

import Foundation
import Alamofire

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

class APIManager {
    
    static let shared = APIManager()
    
    let connectivityManager = NetworkReachabilityManager()
    
    
    
    // MARK: - NORMAl API Call
    
    func  webAPICall <T: Codable> ( urlString : String! ,
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
    
    
    // MARK: - Anothe method for Webservice call
    func apiRequest <T: Decodable> (url : EndPoint,
                                   type : T.Type,
                                   httpMethod : HTTPMethod,
                                   params: [String:Any]? ,
                                   showLoader : Bool,
                                   completion : @escaping (Bool , T?) -> Void) {
        
        if showLoader {
            Loader.start()
        }
        var param = params
        if httpMethod == .get {
            param = nil
        }
        AF.request(url.path, method: httpMethod, parameters: param, encoding: JSONEncoding.default, headers: HTTPHeaders()).responseDecodable(of: type.self) { response in
            
            Loader.stop()
            if let data = response.data {
                do {
                    let statusCode = response.response?.statusCode
                    switch statusCode {
                    case 200:
                        let returnResponse = try JSONDecoder().decode(type.self, from: data)
                        print("Proper result--> : \(returnResponse)")
                        completion(true , returnResponse)
                    default:
                        break
                    }
                } catch (let error) {
                    // Errror
                    print("errorMsg-->", error.localizedDescription)
                }
            } else {
                //Error
                print("errorMsg-->", "Something went wrong")
            }
            
        }
        
    }
    
}
