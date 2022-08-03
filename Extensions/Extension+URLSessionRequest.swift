//
//  Extension+URLSessionRequest.swift
//  PreStart2
//
//  Created by Mauro Arantes on 08/02/2022.
//

import Foundation

extension URLSession {
    
    func getRequest<T:Decodable> (url: URL?, decoding: T.Type, completion: @escaping (Result<T, Error>) -> ()) {
        
        guard let url = url else {
            completion(.failure(RequestError.badURL))
            return
        }
        
        let task = self.dataTask(with: url) {data, _, error in
            
            guard data != nil else {
                completion(.failure(RequestError.badData))
                return
            }
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let jsonResult = try JSONDecoder().decode(decoding, from: data!)
                completion(.success(jsonResult))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
