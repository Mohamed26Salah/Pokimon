//
//  NetworkRouter.swift
//  Pokimon
//
//  Created by Mohamed Salah on 28/10/2023.
//


import Foundation
import Alamofire

//The header fields
enum HttpHeaderField: String {
    case contentType = "Content-Type"
    case authorization = "Authorization"
    case acceptLanguage = "Accept-Language"
    case platform = "Platform"
    case recaptcha = "Recaptcha"
}

//The content type (JSON)
enum ContentType: String {
    case json = "application/json; charset=utf-8"
    case multipart = "multipart/form-data"
}

public enum NetworkRouter: URLRequestConvertible {
    
    case pokimonData(request : String)
    case pokimon (request : String)
  

    
    // MARK: - HTTPMethod
    
    public var method: HTTPMethod {
        switch self {
        case  .pokimonData:
            return .get
        case .pokimon:
            return .get
     
        }
    }
    
    // MARK: - Path
    
    public var path: String {
        switch self {
        case .pokimonData:
            return ""
        case .pokimon :
            return ""
        }
    }
    
    // MARK: - Parameters
    
    public var parameters: Parameters? {
        switch self {
        case .pokimonData(request: let phone):
            return ["phone": phone]
        case .pokimon(request: let phone):
            return ["phoneNumber":phone]
        }
    }
    
    // MARK: - encoding
    
    public var encoding: ParameterEncoding {
        switch self {
       
        case .pokimonData:
            return URLEncoding.queryString
      
        case .pokimon:
            return URLEncoding.queryString
        }
    }
    
    // MARK: - URLRequestConvertible
    
    public func asURLRequest() throws -> URLRequest {
        let url = Constants.baseUrl
        let urlToGo = URL(string: url.appending(path))
        
        var urlRequest = URLRequest(url: urlToGo!)
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HttpHeaderField.contentType.rawValue)
        
        return try encoding.encode(urlRequest, with: parameters)
    }
}

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
    
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
