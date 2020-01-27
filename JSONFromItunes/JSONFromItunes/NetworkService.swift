//
//  NetworkService.swift
//  JSONFromItunes
//
//  Created by Никита Кузнецов on 20/10/2019.
//  Copyright © 2019 bykuznetsov. All rights reserved.
//

import Foundation


class NetworkService{
    func request(urlString:String, completion: @escaping (Result<Model, Error>)->Void){
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Some error: \(error)")
                    completion(.failure(error))
                    return
                }
                guard let data = data else {return}
                do {
                    let tracks = try JSONDecoder().decode(Model.self, from: data)
                    completion(.success(tracks))
                } catch let jsonError {
                    print("Failed to decode JSON: \(jsonError)")
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
}
