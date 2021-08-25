//
//  NetworkManager.swift
//  Organizations


import Foundation

enum NetworkError: Error {
    case error(err: String)
    case invalidResponse(response: String)
    case invalidData
    case decodingError(err: String)
}

final class NetworkManger<T: Codable> {
    func fetch(from url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
                
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            print("Got response for URL \(url)")
            guard error == nil else {
                completion(.failure(.error(err: error!.localizedDescription)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(.invalidResponse(response: response!.description)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let json = try JSONDecoder().decode(T.self, from: data)
                completion(.success(json))
            } catch let err {
                print(err)
                completion(.failure(.decodingError(err: err.localizedDescription)))
            }
        }.resume()
    }
}
