//
//  MovieDatabaseAPI.swift
//  Flixr
//
//  Created by Andre Creighton on 10/23/19.
//  Copyright © 2019 Andre Creighton. All rights reserved.
//

import Foundation

struct MovieDatabase {
  
  private let baseUrl = URL(string: "https://api.themoviedb.org/3")!
  private let apiKey = "8f302335f46a97c9429a570785a1aee3"
  
  var arrayOfMovies = [Movie]()
  
  enum APIError: Error {
      case noResponse
      case jsonDecodingError(error: Error)
      case networkError(error: Error)
  }
  
  enum Endpoint {
    case nowPlaying
    case topRated
    case upcoming
    case movieSearch
    
    func path() -> String{
        switch self{
        case .upcoming:
          return "movie/upcoming"
        case .topRated:
          return "movie/top_rated"
        case .nowPlaying:
          return "movie/now_playing"
        case .movieSearch:
          return "search/movie"
      }
    }
  }
  
  
  mutating func getInfoWithEndPoint(endpoint :Endpoint, params:[String : String]?, completionHandler: @escaping(Result<[Movie], Error>) ->()) {
    
    var arr : [Movie] = []
    
    let appendedURL = baseUrl.appendingPathComponent(endpoint.path())
    print(appendedURL)
    var components = URLComponents(url: appendedURL, resolvingAgainstBaseURL: true)!
    components.queryItems = [ URLQueryItem(name: "api_key", value: apiKey) ]
  
    if let params = params {
      for (_, value) in params.enumerated() {
        components.queryItems?.append(URLQueryItem(name: value.key, value: value.value))
      }
    }
    
    var request = URLRequest(url:components.url!)
    request.httpMethod = "GET"
    
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
      
      if let error = error {
        print(error.localizedDescription)
        completionHandler(.failure(error))
        
      }else{
        
        guard let data = data else {
          print("cant convert data")
          return
        }
        
        do {
           let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                  print(json)
     
          let jsonObject = json as? [String: Any] ?? [:]
          let resultsArrayOfObjects = jsonObject["results"] as? [Any] ?? []
          
          for movieObject in resultsArrayOfObjects {
            let dict = movieObject as! [String: Any]
            let movieInst = Movie(dict)
            print(movieInst.title)
            arr.append(movieInst)
          }
          completionHandler(.success(arr))
        }catch{
          print(error.localizedDescription)
          print("Cannot parse JSON")
        }
      }
    }
    
    task.resume()
    
  }
  
  
  
}
