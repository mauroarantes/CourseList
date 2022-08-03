//
//  CoursesListViewModel.swift
//  PreStart2
//
//  Created by Mauro Arantes on 09/02/2022.
//

import SwiftUI
import Combine

class CoursesListViewModel: ObservableObject {
    
    @Published var courses : [Course] = []
    
    // Manually expose name publisher in view model implementation
    var namePublisher: Published<[Course]>.Publisher { $courses }
    
//    var courseSubscription: AnyCancellable?
    
    private let dataService: CourseDataServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(dataService: CourseDataServiceProtocol = CourseDataService()) {
        self.dataService = dataService
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.namePublisher
            .sink{ [weak self] (returnedCourses) in
                self?.courses = returnedCourses
            }
            .store(in: &cancellables)
    }
}
