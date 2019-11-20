//
//  HomeViewModel.swift
//  OpenWeatherTest
//
//  Created by Carolain Lenes Beltran on 19/11/19.
//  Copyright © 2019 Carolain Lenes Beltran. All rights reserved.
//

import Foundation
import UIKit


class HomeViewModel{

    // MARK: - Variable
    var homeViewController : HomeViewController?
    var weather: WeatherVO?
    var cities: [String] = ["Bogota,co","Mexico,mx","London,uk","Madrid,es","Canberra,au"]
    var cityInt: Int = 0
    var citiesObjects : [WeatherVO] = [WeatherVO]()
    
    
    func getWeather(_ homeViewController : HomeViewController ){
        self.homeViewController = homeViewController
        for city in cities {
            AlamofireREST.getWeatherRequest(city, completion: { (success, weatherVO, error) in
                if success {
                    DispatchQueue.main.async {
                        if weatherVO != nil{
                            self.weather = weatherVO
                            if city == self.cities[0]{
                                self.updateUiCurrentCity()
                            }else{
                                self.updateUiTableViewCities()
                            }
                        }
                    }
                }else{
                
                }
                DispatchQueue.main.async {
                    
                }
            })
        }
    }
    
    private func updateUiCurrentCity(){
        self.homeViewController!.cityLabel.text = self.weather?.name
        self.homeViewController!.tempMinMax.text = String(weather!.main!.tempMin!) + " / " + String(weather!.main!.tempMax!)
        self.homeViewController!.temperatureLabel.text = String(weather!.main!.temp!)
        self.homeViewController!.descriptionLabel.text = weather?.weather![0].weatherDescription
        self.homeViewController!.sunriseLabel.text = self.UTCToLocal(timestamp: Double(weather!.sys!.sunrise!), toFormat: "HH:mm:ss")
        self.homeViewController!.sunsetLabel.text = self.UTCToLocal(timestamp: Double(weather!.sys!.sunset!), toFormat: "HH:mm:ss") //String(weather!.sys!.sunset!)
        self.homeViewController!.speedLabel.text = String(weather!.wind!.speed!)
        
        self.homeViewController!.currentTimeLabel.text = self.currentTime()
           
       
        self.homeViewController!.dateLabel.text = self.currentDate()
        
            
        //self.homeViewController!.weekdayLabel.text =
        let urlString = Globals().urlIcon + weather!.weather![0].icon! + "@2x.png"
        
        let url = URL(string: urlString)
              
              
        self.homeViewController?.iconWeatherImage.af_setImage(withURL: url!, placeholderImage: nil, filter: nil, imageTransition: UIImageView.ImageTransition.crossDissolve(0.5), runImageTransitionIfCached: true) { (response) in
                  guard response.value != nil else {
                      return
                  }
                  let image = response.value
                  let size = CGSize(width: 80, height: 80)
                  let roundedImage = image?.af_imageRoundedIntoCircle()
                  let scaledImage = roundedImage?.af_imageScaled(to: size)
                  DispatchQueue.main.async {
                    self.homeViewController?.iconWeatherImage.image = scaledImage
                  }
              }
    }
    
    func currentDate() -> String{
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy"
        let currentDateString: String = dateFormatter.string(from: date)
        print("Current date is \(currentDateString)")
        
        return currentDateString
    }
    
    func currentTime() -> String{
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let currentDateString: String = dateFormatter.string(from: date)
        print("Current date is \(currentDateString)")
        
        return currentDateString
    }
    
    func UTCToLocal(timestamp:Double, toFormat: String) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = toFormat
        return dateFormatter.string(from: date)
    }
    
    
    private func updateUiTableViewCities(){
        self.citiesObjects.append(self.weather!)
        self.homeViewController?.otherCitiesTableView.reloadData()
    }
       
       
       //MARK: TABLEVIEW DELEGATE
       
    func createCellCities(_ tableView : UITableView, _ indexPath : IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell( withIdentifier : "HomeTableViewCell" , for : indexPath ) as! HomeTableViewCell
        cell.loadDataCity(self.citiesObjects[indexPath.row])
        
        return cell
    }
       
       func didSelectCell(_ tableView : UITableView, indexPath : IndexPath){
        
       }
       

    
}

    
