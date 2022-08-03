//
//  Extension+URLSessionError.swift
//  PreStart2
//
//  Created by Mauro Arantes on 08/02/2022.
//

import Foundation

extension URLSession {
    enum RequestError: Error {
        case badURL
        case badData
    }
}
