//
//  HomeViewController.swift
//  OpenWeatherTest
//
//  Created by Carolain Lenes Beltran on 19/11/19.
//  Copyright © 2019 Carolain Lenes Beltran. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {
    

    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var tempMinMax: UILabel!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var centigradeLabel: UILabel!

    @IBOutlet weak var iconWeatherImage: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var sunriseLabel: UILabel!
    
    @IBOutlet weak var speedLabel: UILabel!
    
    @IBOutlet weak var sunsetLabel: UILabel!
    
    @IBOutlet weak var currentTimeLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var weekdayLabel: UILabel!
    
    @IBOutlet weak var otherCitiesTableView: UITableView!
    
    //variables
    var homeViewModel : HomeViewModel = HomeViewModel()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeViewModel.getWeather(self)
    }
    

}

extension HomeViewController: UITableViewDelegate,UITableViewDataSource{
    
    //MARK: TABLEVIEW DELEGATE
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.citiesObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return homeViewModel.createCellCities(tableView, indexPath)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView,heightForRowAt indexPath: IndexPath) -> CGFloat{
        return UITableView.automaticDimension
    }
}
