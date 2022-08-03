//
//  PreStart2Tests.swift
//  PreStart2Tests
//
//  Created by Mauro Arantes on 07/02/2022.
//

import XCTest
@testable import PreStart2

class MockCourseDataService: CourseDataServiceProtocol {
    
    @Published var courses: [Course] = []
    
    // Manually expose name publisher in view model implementation
    var namePublisher: Published<[Course]>.Publisher { $courses }
    
    init() {
        getCourses()
    }
    
    func getCourses() {
        let c1 = Course(name: "Name1", image: "Image1")
        let c2 = Course(name: "Name2", image: "Image2")
        let c3 = Course(name: "Name3", image: "Image3")
        let c4 = Course(name: "Name4", image: "Image4")
        
        self.courses = [c1,c2,c3,c4]
    }
}

// Naming structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior

//Testing structure: Given, When, Then (Assert)

class PreStart2Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_CourseImageViewModel_isLoading_shouldBeTrue() {
        // Given
        let course: Course = Course(name: "Name", image: "Image")
        //When
        let vm = CourseImageViewModel(course: course)
        //Then
        XCTAssertTrue(vm.isLoading)
    }

    func test_CoursesListViewModel() {
        // Given
        var coursesListViewModel: CoursesListViewModel
        var mockCourseDataService: CourseDataServiceProtocol
        //When
        mockCourseDataService = MockCourseDataService()
        coursesListViewModel = .init(dataService: mockCourseDataService)
//        mockCourseDataService.getCourses()
        //Then
        XCTAssertEqual(coursesListViewModel.courses.count, 4)
        XCTAssertEqual(coursesListViewModel.courses[1].name, "Name2")
    }
}
