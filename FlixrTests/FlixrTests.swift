//
//  FlixrTests.swift
//  FlixrTests
//
//  Created by Andre Creighton on 11/25/19.
//  Copyright © 2019 Andre Creighton. All rights reserved.
//

import XCTest
@testable import Flixr


class FlixrTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

  
  // Example testing
  func testMovieViewModel(){
    
    let movie = Movie(id: 0, title: "Example", overview: "This is an overview..somewhat", releaseDate: "the beginning", posterPath: "path to", backdropPath: "backdrop")
    
    let movieViewModel = MovieViewModel(movie: movie)
    
    XCTAssertEqual(movie.title, movieViewModel.title)
    
    
  }
  
  
}
