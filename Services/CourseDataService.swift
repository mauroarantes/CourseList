//
//  CourseDataService.swift
//  PreStart2
//
//  Created by Mauro Arantes on 09/02/2022.
//

import Foundation
import Combine

protocol CourseDataServiceProtocol {
    // Define name publisher
    var namePublisher: Published<[Course]>.Publisher { get }
    
    func getCourses()
}

class CourseDataService: CourseDataServiceProtocol {
    
    @Published var courses: [Course] = []
    
    // Manually expose name publisher in view model implementation
    var namePublisher: Published<[Course]>.Publisher { $courses }
    
    var courseSubscription: AnyCancellable?
    
    init() {
        getCourses()
    }
    
    internal func getCourses() {
        guard let url = URL(string: "https://iosacademy.io/api/v1/courses/index.php") else { return }
        
        courseSubscription = NetworkingManager.download(url: url)
            .decode(type: [Course].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCourses) in
                self?.courses = returnedCourses
                self?.courseSubscription?.cancel()
            })
    }
}
