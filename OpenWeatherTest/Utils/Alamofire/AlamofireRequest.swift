//
//  AlamofireRequest.swift
//  OpenWeatherTest
//
//  Created by Carolain Lenes Beltran on 19/11/19.
//  Copyright © 2019 Carolain Lenes Beltran. All rights reserved.
//

import Foundation
import Alamofire


open class AlamofireREST{
    
    // MARK: - Funtions
    static func parametersRequest(_ methodFunction : String, _ parameters : [String: Any]?, _ requestType : String) -> URLRequest{
        
        let url = Globals().urlApi + methodFunction
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = requestType
        urlRequest.addValue( "application/json" , forHTTPHeaderField: "Content-Type")
      
        if parameters != nil{
            do {
                let jsonData = try? JSONSerialization.data(withJSONObject: parameters!)
                urlRequest.httpBody = jsonData
            }
        }
        return urlRequest
    }
    
    // getWeather Request
    
    static func getWeatherRequest(_ city: String, completion: @escaping (Bool,WeatherVO?, NSError?) -> Void){
        let url = "q=" + city + Globals().apiKey
        let urlRequest = self.parametersRequest(url, nil, HTTPMethod.get.rawValue)
        Alamofire.request(urlRequest).responseJSON{
            response in
            let statusCode = response.response?.statusCode
            print("Status Code", statusCode ?? Int())
            switch response.result{
                
            case .success(_):
                
                if let httpStatusCode = response.response?.statusCode {
                    switch(httpStatusCode) {
                    case 200:
                        guard let weather = try? JSONDecoder().decode(WeatherVO.self, from: response.data!) else{
                            completion(false, nil,nil)
                            return
                        }
                        completion(true, weather,nil)
                        break
                    case 400:
                        completion(false, nil, response.error! as NSError)
                        break
                    case 500:
                        completion(false, nil,response.error! as NSError)
                        break
                    default: break
                        
                    }
                } else {
                    completion(false, nil,response.error! as NSError)
                }
            case .failure(let error):
                print(error)
                completion(false, nil, error as NSError)
            }
            
        }
    }
    
    
}
