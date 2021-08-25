//
//  OrganizationManger.swift
//  Organizations
//
//  Created by Manjusha Sabu on 8/8/21.
//  Copyright © 2021 Manjusha Sabu. All rights reserved.
//

import Foundation

protocol OrganizationMangerProtocol {
    var organizations: [OrganizationsModel] { get set }
    func download(organization: [String], completion: @escaping(Result<[OrganizationsModel], NetworkError>) -> Void)
}


final class OrganizationManger: OrganizationMangerProtocol, ObservableObject {
    @Published var organizations: [OrganizationsModel] = []
    
    func download(organization: [String], completion: @escaping (Result<[OrganizationsModel], NetworkError>) -> Void) {
                
        let url = URL(string: API.baseUrl)
        NetworkManger<[OrganizationsModel]>().fetch(from: url!) { (result) in
            
            switch result {
            case .failure(let err):
                print("Got errore in the OrganizationManager")
                completion(.failure(err))

            case .success(let resp):
                completion(.success(resp))
            }
        }
    }
}
