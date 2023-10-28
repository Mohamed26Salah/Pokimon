//
//  NetworkManager.swift
//  Pokimon
//
//  Created by Mohamed Salah on 28/10/2023.
//


import Foundation
import Alamofire

public enum NetworkError: Error {
    case parseError
    case badUrlError
    case badRequestError
    case initialDataError
    case numberVerificationError
    case registerError
}

public final class NetworkManager {
    public static var shared = NetworkManager()
    
    public func execute<M: Codable>(requestRoute: NetworkRouter, responseModel: M.Type, isLoaderActive: Bool = true, completion: @escaping (Swift.Result<M?, NetworkError>) -> Void) {
        
        do {
            let urlRequest = try requestRoute.asURLRequest()
            AF.request(urlRequest).responseDecodable(of: responseModel) { (response) in
                print("Response: ", response.value?.dictionary ?? [])
                
                if response.response?.statusCode == 200 {
                    if let resultValue = response.value {
                        completion(.success(resultValue))
                    } else {
                        completion(.failure(.parseError))
                    }
                } else  {
                    if let error =  response.error{
                        print(error.localizedDescription)
                    }
                    completion(.failure(.badRequestError))
                }
            }
        } catch {
            completion(.failure(.badUrlError))
        }
    }

}

struct CustomerImageDataResponse: Codable{
    let data: String?
    let statusCode: Int?
    let isSuccess: Bool?
}

