//
//  Services.swift
//  PaginationTask
//
//  Created by Aniket Rao on 24/02/23.
//

import Foundation
import Alamofire


struct APIs{
    // This for common Base url, Here URL is different for both API
    static var baseURL = ""
}

enum EndPoint {
    case posts(page:Int)
    
    var path: String {
        switch self {
           
        case .posts(let pageNo):
            return APIs.baseURL.appending("https://hn.algolia.com/api/v1/search_by_date?tags=story&page=\(pageNo)")
        }
    }
}


class Services : NSObject {
    
    static let shared = Services()
    
    // MARK: - APIs
    
    func getPosts(page : Int , params : Parameters , completion: @escaping(Posts) -> Void) {
        
        APIManager.shared.apiRequest(url: .posts(page: page),
                                     type: Posts.self,
                                     httpMethod: .get,
                                     params: [:],
                                     showLoader: true) { success , data in
            
            guard let data = data else {return}
            completion(data)
            
        }
    }
}
