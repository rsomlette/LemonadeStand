//
//  Booth.swift
//  LemonStand
//
//  Created by Robin Somlette on 27-11-2014.
//  Copyright (c) 2014 Robin Somlette. All rights reserved.
//

import Foundation

class Booth {
   class func shakeLemonade (lemons: Int, iceCubes: Int) -> String {
        let ratioLemonIce = Double(lemons) / Double(iceCubes)
        var ratioMixLemonIce = ""
        if ratioLemonIce > 1 {
            ratioMixLemonIce = "Diluted"
        } else if ratioLemonIce == 1 {
            ratioMixLemonIce = "Neutral"
        } else {
            ratioMixLemonIce = "Acidic"
        }
        
        return ratioMixLemonIce
    }
    
    class func randomWeather () -> String {
        let randomNumber = Int(arc4random_uniform(UInt32(3)))
        var weather = ""
        switch randomNumber {
        case 0 :
            weather = "Cold"
        case 1:
            weather = "Warm"
        default:
            weather = "Mild"
        }
        return weather
    }
    class func randomNumberOfVisitors (weather: String) -> Int {
        var randomNumberOfCustomers = 0
        var maxNumberOfCustomers = 0
        if weather == "Cold" {
            maxNumberOfCustomers = 7
        } else if weather == "Mild" {
            maxNumberOfCustomers = 10
        } else if weather == "Warm" {
            maxNumberOfCustomers = 14
        }
        
        var numberOfCustomers = 0
        numberOfCustomers = Int(arc4random_uniform(UInt32(maxNumberOfCustomers))) + 1
//        var numberOfCustomers = 0
//        for i = 0; i < maxNumberOfCustomers; i++ {
//            
//        }
        return numberOfCustomers
    }
    
    class func randomPreferenceCustomer () -> String {
        var randomPref = Int(arc4random_uniform(UInt32(3)))
        var pref = ""
        
        switch randomPref {
        case 0:
            pref = "Acidic"
        case 1:
            pref = "Neutral"
        default:
            pref = "Diluted"
            
        }
        return pref
    }
    
    
    class func dailyVisitor (ratioMixLemonIce: String, weather: String) -> [Customer] {
        var numberOfCustomers = randomNumberOfVisitors(weather)
        var customers:[Customer] = []
        
        for var i = 0; i < numberOfCustomers; i++ {
            var visitor = Customer()
            visitor.index = i
            visitor.preference = randomPreferenceCustomer()
            
            if visitor.preference == ratioMixLemonIce {
                visitor.didpurchase = true
            } else {
                visitor.didpurchase = false
            }
            customers.append(visitor)
        }
        return customers
    }
    
    class func comptability (customers: [Customer]) -> Int {
        var winnings = 0
        for var i = 0; i < customers.count; i++ {
            if customers[i].didpurchase == true {
                winnings++
            }
        }
        return winnings
    }
    
    
    
}
