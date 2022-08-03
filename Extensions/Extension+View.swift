//
//  Extension+View.swift
//  PreStart2
//
//  Created by Mauro Arantes on 08/02/2022.
//

import SwiftUI

extension View {
    
    func getImage(imageURL: String) -> Data? {
        var imageData: Data?
        let semaphore = DispatchSemaphore(value: 0)
        guard let url = URL(string: imageURL) else { return nil }
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            imageData = data
            print("..",imageData ?? "No data")
            semaphore.signal()
        }
        task.resume()
        print("//",imageData ?? "No data")
        semaphore.wait()
        return imageData
    }
}
