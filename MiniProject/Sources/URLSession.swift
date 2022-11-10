//
//  URLSession.swift
//  MiniProject
//
//  Created by 최다혜 on 2022/11/10.
//

import Foundation

protocol MiniHttp {
    static func request(urlString: String, completion: @escaping ((Self) -> Void))
}

extension MiniHttp where Self: Decodable {
    static func request(urlString: String, completion: @escaping ((Self) -> Void)) {
        print("💚 urlString : \(urlString)")
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            
            do {
                let response = try JSONDecoder().decode(self.self, from: data)
                DispatchQueue.main.async {
                    completion(response)
                }
            } catch {
                print("error : \(String(describing: error))")
            }
        }.resume()
    }
}
