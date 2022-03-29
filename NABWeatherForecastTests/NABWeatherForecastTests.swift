//
//  NABWeatherForecastTests.swift
//  NABWeatherForecastTests
//
//  Created by tringuyen3297 on 28/03/2022.
//

import XCTest
@testable import NABWeatherForecast

class NABWeatherForecastTests: XCTestCase {
    func testValidCityName() {
        let presenter = WeatherForecastPresenter()
        
        let result = presenter.isValid(cityName: "")
        XCTAssertFalse(result)
        
        let result2 = presenter.isValid(cityName: "abc")
        XCTAssertTrue(result2)
        
        let result3 = presenter.isValid(cityName: "london")
        XCTAssertTrue(result3)
    }
    
    func testRequestWeatherData() {
        guard var urlComponent = URLComponents(string: K.app_api_url) else {
            XCTAssert(false, "Fail on create URLComponents.")
            return
        }
        urlComponent.queryItems = [
            URLQueryItem(name: K.app_api_field_cityname, value: K.app_default_cityname),
            URLQueryItem(name: K.app_api_field_cnt, value: "\(K.app_api_default_cnt)"),
            URLQueryItem(name: K.app_api_field_appid, value: K.app_api_default_appid),
            URLQueryItem(name: K.app_api_field_units, value: K.app_api_default_units),
        ]
        
        NetworkManager.sharedInstance.requestWeatherForecastInfo(with: urlComponent.url!, completionHandler: { weatherDataList, appError in
            if appError != nil {
                XCTAssert(false, "Fail on request weather forecast data.")
                return
            }
            XCTAssert(weatherDataList.count != K.app_api_default_cnt)
        })
    }
}
