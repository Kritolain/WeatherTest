//
//  Globals.swift
//  OpenWeatherTest
//
//  Created by Carolain Lenes Beltran on 19/11/19.
//  Copyright © 2019 Carolain Lenes Beltran. All rights reserved.
//

import Foundation

open class Globals {
    
    //Url_Api
    public var urlApi: String {
        return "https://api.openweathermap.org/data/2.5/weather?"
    }
    
    // Api Key
    public var apiKey: String {
        return "&appid=d7e6204225106a26ef35751b8e152076&units=metric&lang=es"
    }
    
    // URL Icon
    public var urlIcon: String {
        return "https://www.openweathermap.org/img/wn/"
    }
}
