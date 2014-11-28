//
//  ViewController.swift
//  LemonStand
//
//  Created by Robin Somlette on 25-11-2014.
//  Copyright (c) 2014 Robin Somlette. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var inventoryContainer: UIView!
    var purchaseContainer: UIView!
    var mixLemonadeContainer: UIView!
    var startSellingContainer: UIView!
    
    //constants
    
    let kFourth:CGFloat = 1.0/4.0
    let kHalf:CGFloat = 1.0/2.0
    let kThird:CGFloat = 1.0/3.0
    let kFifth:CGFloat = 1.0/5.0
    let kSixth:CGFloat = 1.0/6.0
    
    // label
    var titleInventoryLabel: UILabel!
    var moneyInventoryLabel: UILabel!
    var lemonsInventoryLabel: UILabel!
    var iceCubesInventoryLabel: UILabel!
    
    var mixTitleLabel: UILabel!
    var mixLemonsLabel: UILabel!
    var mixIceCubesLabel: UILabel!
    
    var titlePurchaseSuppliesLabel: UILabel!
    var lemonsLegendPurchaseLabel: UILabel!
    var iceCubesLegendPurchaseLabel: UILabel!
    var lemonsBoughtLabel: UILabel!
    var iceCubesBoughtLabel: UILabel!
    
    
    var titleMixLabel: UILabel!
    
    var startSellingTitleLabel: UILabel!
    var startSellingResultWinningsLabel: UILabel!
    var startSellingResultCustomersLabel: UILabel!
    var startSellingResultMixLabel: UILabel!
    var startSellingResultWeatherLabel: UILabel!
    
    var weather = ""
    
    // buttons
    var buyLemonsPlusButton: UIButton!
    var buyLemonsLessButton: UIButton!
    var buyIceCubesPlusButton: UIButton!
    var buyIceCubesLessButton: UIButton!
    
    var mixLemonsPlusButton: UIButton!
    var mixLemonsLessButton: UIButton!
    var mixIceCubesPlusButton: UIButton!
    var mixIceCubeLessButton: UIButton!
    
    var startSellingButton: UIButton!
    var resetLemonadeButton: UIButton!
    
    
    // inventory var
    var cashAvailable = 0
    var newCashAvailable = 0
    var lemonsAvailable = 0
    var newLemonsAvailable = 0
    var iceCubesAvailable = 0
    var newIceCubesAvailable = 0
    var lemonsToMix = 0
    var iceCubesToMix = 0
    
    // images
    
    var lemonsPurchaseIcon: UIImageView!
    var iceCubesPurchaseIcon: UIImageView!
    var mixerIcon: UIImageView!
    var weatherIcon: UIImageView!
    
    var lemonsMixIcon: UIImageView!
    var iceCubesMixIcon: UIImageView!
    
    var customersIcon: UIImageView!
    var earnCashIcon: UIImageView!
    var mixResultIcon: UIImageView!
    var previousWeatherIcon: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupContainerViews()
        setupPurchaseContainer(self.purchaseContainer)
        setupMixLemonadeContainer(self.mixLemonadeContainer)
 //       setupStartSellingContainer(self.startSellingContainer)
        weather = Booth.randomWeather()
        
        self.hardReset()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //IBActions
    //func resetButtonPressed (button: UIButton) {
    func buyLemonsPlusButtonPressed (button: UIButton) {
        println("BuyOneLemon")
        
        if cashAvailable == newCashAvailable && newCashAvailable >= 2 {
            newCashAvailable -= 2
            newLemonsAvailable++
            updateMainViewTemp()
        } else if newCashAvailable >= 2{
            newCashAvailable -= 2
            newLemonsAvailable++
            updateMainViewTemp()
        } else {
            showAlertWithText(message: "You don't have enough cash to buy more lemons")
        }
    }
    
    func buyLemonsLessButtonPressed (button: UIButton) {
        println("RemoveOneLemon")
        
        if lemonsAvailable == newLemonsAvailable && newLemonsAvailable >= 1 {
            showAlertWithText(message: "You can't sell your stock")
        } else if lemonsAvailable < newLemonsAvailable && newLemonsAvailable >= 1 {
            newLemonsAvailable--
            newCashAvailable += 2
            updateMainViewTemp()
        } else {
            showAlertWithText(message: "Nothing to remove")
        }
    }
    func buyIceCubesPlusButtonPressed (button: UIButton) {
        println("BuyIceCube")
        
        if cashAvailable == newCashAvailable && newCashAvailable >= 1 {
            newCashAvailable--
            newIceCubesAvailable++
            updateMainViewTemp()
        } else if newCashAvailable >= 1{
            newCashAvailable--
            newIceCubesAvailable++
            updateMainViewTemp()
        } else {
            showAlertWithText(message: "You don't have enough cash to buy more ice")
        }
    }
    func buyIceCubesLessButtonPressed (button: UIButton) {
        println("RemoveOneIceCube")
        if iceCubesAvailable == newIceCubesAvailable && newIceCubesAvailable >= 1 {
            showAlertWithText(message: "You can't sell your stock")
        } else if iceCubesAvailable < newIceCubesAvailable && newIceCubesAvailable >= 1 {
            newIceCubesAvailable--
            newCashAvailable++
            updateMainViewTemp()
        } else {
            showAlertWithText(message: "Nothing to remove")
        }
    }
    
    func mixLemonsPlusButtonPressed (button: UIButton) {
        println("MixOneLemon")
        if newLemonsAvailable >= 1 {
            newLemonsAvailable--
            lemonsToMix++
            updateMainViewTemp()
        } else {
            showAlertWithText(message: "No more Lemons left")
        }
    }
    
    func mixLemonsLessButtonPressed (button: UIButton) {
        println("RemoveOneMixLemon")
        if lemonsToMix >= 1 {
            newLemonsAvailable++
            lemonsToMix--
            updateMainViewTemp()
        } else {
            showAlertWithText(message: "Nothing to remove")
        }
    }
    
    func mixIceCubesPlusButtonPressed (button: UIButton) {
        println("MixOneIceCube")
        if newIceCubesAvailable >= 1 {
            newIceCubesAvailable--
            iceCubesToMix++
            updateMainViewTemp()
        } else {
            showAlertWithText(message: "No more Ice Cubes")
        }
    }
    
    
    func mixIceCubesLessButtonPressed (button: UIButton) {
        println("RemoveOneMixIceCube")
        if iceCubesToMix >= 1 {
            newIceCubesAvailable++
            iceCubesToMix--
            updateMainViewTemp()
        } else {
            showAlertWithText(message: "Nothing to remove")
        }
    }
    
    func startSellingButtonPressed (button: UIButton) {
        if iceCubesToMix >= 1 && lemonsToMix >= 1
        {
            var dailyRatio = Booth.shakeLemonade(lemonsToMix, iceCubes: iceCubesToMix)
            var customers:[Customer] = Booth.dailyVisitor(dailyRatio, weather: weather)
            var winnings = Booth.comptability(customers)
            
            println("You earn $\(winnings) Today")
            println("Your ratio was \(dailyRatio)")
            
            cashAvailable = newCashAvailable + winnings
            lemonsAvailable = newLemonsAvailable
            iceCubesAvailable = newIceCubesAvailable
            lemonsToMix = 0
            iceCubesToMix = 0
            
            if (cashAvailable == 0 && ( lemonsAvailable == 0 || iceCubesAvailable == 0)) || (cashAvailable <= 2 && lemonsToMix == 0 && iceCubesToMix == 00) {
                self.startSellingButton.setTitle("You're broke!", forState: UIControlState.Normal)
                self.startSellingButton.enabled = false

            }
            
            
            self.startSellingResultMixLabel.text = "\(dailyRatio)"
            self.startSellingResultWinningsLabel.text = "$\(winnings)"
            self.startSellingResultCustomersLabel.text = "\(customers.count)"
            self.previousWeatherIcon.image = UIImage(named: "\(weather)")
            updateMainView()
        } else {
            showAlertWithText(message: "Nothing to mix")
        }
        
    }
    
    func resetLemonadeStandButtonPressed (button: UIButton) {
        cashAvailable = 10
        lemonsAvailable = 1
        iceCubesAvailable = 1
        lemonsToMix = 0
        iceCubesToMix = 0
        
        self.startSellingButton.setTitle("Open Shop for the Day", forState: UIControlState.Normal)
        self.startSellingButton.enabled = true
        
        updateMainView()
    }
    
    
    
    
    
    func hardReset () {
        self.setupInventoryContainer(self.inventoryContainer)
        self.setupStartSellingContainer(self.startSellingContainer)
        
        cashAvailable = 10
        lemonsAvailable = 1
        iceCubesAvailable = 1
        lemonsToMix = 0
        iceCubesToMix = 0
        
        updateMainView()
    }
    
    func updateMainView () {
        newCashAvailable = cashAvailable
        newLemonsAvailable = lemonsAvailable
        newIceCubesAvailable = iceCubesAvailable
        
        
        self.moneyInventoryLabel.text = "$\(cashAvailable)"
        self.lemonsInventoryLabel.text = "\(lemonsAvailable) Lemons"
        self.iceCubesInventoryLabel.text = "\(iceCubesAvailable) Ice Cubes"
        self.mixLemonsLabel.text = "\(lemonsToMix) Lemons"
        self.mixIceCubesLabel.text = "\(iceCubesToMix) Ice Cubes"
        
        weather = Booth.randomWeather()
        self.weatherIcon.image = UIImage(named: "\(weather)")
    }
    func updateMainViewTemp () {
        self.moneyInventoryLabel.text = "$\(newCashAvailable)"
        self.lemonsInventoryLabel.text = "\(newLemonsAvailable) Lemons"
        self.iceCubesInventoryLabel.text = "\(newIceCubesAvailable) Ice Cubes"
        self.mixLemonsLabel.text = "\(lemonsToMix) Lemons"
        self.mixIceCubesLabel.text = "\(iceCubesToMix) Ice Cubes"
    }
    
    func setupContainerViews() {
        self.inventoryContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x, y: self.view.bounds.origin.y, width: self.view.bounds.width, height: self.view.bounds.height * kFourth))
        self.inventoryContainer.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.inventoryContainer)
        
        self.purchaseContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x, y: self.inventoryContainer.frame.height, width: self.view.bounds.width, height: self.view.bounds.height * kFourth))
        self.purchaseContainer.backgroundColor = UIColor.darkGrayColor()
        self.view.addSubview(self.purchaseContainer)
        
        self.mixLemonadeContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x, y: self.inventoryContainer.frame.height + self.purchaseContainer.frame.height, width: self.view.bounds.width, height: self.view.bounds.height * kFourth))
        self.mixLemonadeContainer.backgroundColor = UIColor.darkGrayColor()
        self.view.addSubview(self.mixLemonadeContainer)
        
        self.startSellingContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x, y: self.inventoryContainer.frame.height + self.purchaseContainer.frame.height + self.mixLemonadeContainer.frame.height, width: self.view.bounds.width, height: self.view.bounds.height))
        self.startSellingContainer.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.startSellingContainer)
    }

    func setupInventoryContainer(containerView: UIView) {
        self.titleInventoryLabel = UILabel()
        self.titleInventoryLabel.text = "Your Inventory:"
        self.titleInventoryLabel.textColor = UIColor.redColor()
        self.titleInventoryLabel.sizeToFit()
        self.titleInventoryLabel.center = CGPoint(x: containerView.frame.width * kHalf, y: containerView.frame.height * kFifth)
        self.titleInventoryLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.titleInventoryLabel)
        
        self.moneyInventoryLabel = UILabel()
        self.moneyInventoryLabel.text = "$xxxxxxx"
        self.moneyInventoryLabel.textColor = UIColor.greenColor()
        self.moneyInventoryLabel.sizeToFit()
        self.moneyInventoryLabel.center = CGPoint(x: containerView.frame.width * 1 * kSixth, y: containerView.frame.height * 2 * kFifth)
//        self.moneyInventoryLabel.sizeThatFits(CGSize(width: containerView.frame.width * kThird, height: 10.0/1.0))
        self.moneyInventoryLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.moneyInventoryLabel)
        
        self.lemonsInventoryLabel = UILabel()
        self.lemonsInventoryLabel.text = "xxxx Lemons"
        self.lemonsInventoryLabel.textColor = UIColor.blackColor()
        self.lemonsInventoryLabel.sizeToFit()
        self.lemonsInventoryLabel.center = CGPoint(x: containerView.frame.width * 3 * kSixth, y: containerView.frame.height * 2 * kFifth)
        self.lemonsInventoryLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.lemonsInventoryLabel)
        
        self.iceCubesInventoryLabel = UILabel()
        self.iceCubesInventoryLabel.text = "xxxx Ice Cubes"
        self.iceCubesInventoryLabel.textColor = UIColor.blackColor()
        self.iceCubesInventoryLabel.sizeToFit()
        self.iceCubesInventoryLabel.center = CGPoint(x: containerView.frame.width * 5 * kSixth, y: containerView.frame.height * 2 * kFifth)
        self.iceCubesInventoryLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.iceCubesInventoryLabel)
        
        self.mixTitleLabel = UILabel()
        self.mixTitleLabel.text = "Your Daily Mix:"
        self.mixTitleLabel.textColor = UIColor.redColor()
        self.mixTitleLabel.sizeToFit()
        self.mixTitleLabel.center = CGPoint(x: containerView.frame.width * kHalf, y: containerView.frame.height * 3 * kFifth)
        self.mixTitleLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.mixTitleLabel)
        
        self.mixerIcon = UIImageView()
        self.mixerIcon.image = UIImage(named: "Lemonade Icon")
        self.mixerIcon.frame = CGRect(x: containerView.frame.width * 1.0/15.0, y: containerView.frame.height * 3 * kFifth, width: containerView.frame.width * kFifth, height: containerView.frame.width * kFifth * 1.23)
        containerView.addSubview(self.mixerIcon)
        
//        println("-\(weather)-")
        
        self.weatherIcon = UIImageView()
        self.weatherIcon.image = UIImage(named: "\(weather)")
        self.weatherIcon.frame = CGRect(x: containerView.frame.width * 12.5/15.0, y: containerView.frame.height * 3 * kFifth, width: containerView.frame.width * kSixth, height: containerView.frame.width * kSixth)
        containerView.addSubview(self.weatherIcon)
        
        self.mixLemonsLabel = UILabel()
        self.mixLemonsLabel.text = "xxxx Lemons"
        self.mixLemonsLabel.textColor = UIColor.blackColor()
        self.mixLemonsLabel.sizeToFit()
        self.mixLemonsLabel.center = CGPoint(x: containerView.frame.width * 1 * kThird, y: containerView.frame.height * 4 * kFifth)
        self.mixLemonsLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.mixLemonsLabel)
        
        self.mixIceCubesLabel = UILabel()
        self.mixIceCubesLabel.text = "xxxx Ice Cubes"
        self.mixIceCubesLabel.textColor = UIColor.blackColor()
        self.mixIceCubesLabel.sizeToFit()
        self.mixIceCubesLabel.center = CGPoint(x: containerView.frame.width * 2 * kThird, y: containerView.frame.height * 4 * kFifth)
        self.mixIceCubesLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.mixIceCubesLabel)
        
    }
    
    func setupPurchaseContainer(containerView: UIView) {
        self.titlePurchaseSuppliesLabel = UILabel()
        self.titlePurchaseSuppliesLabel.text = "Step 1: Purchase Supplies for the Day"
        self.titlePurchaseSuppliesLabel.textColor = UIColor.blackColor()
        self.titlePurchaseSuppliesLabel.sizeToFit()
        self.titlePurchaseSuppliesLabel.center = CGPoint(x: containerView.frame.width * kHalf, y: containerView.frame.height * kSixth)
        self.titlePurchaseSuppliesLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.titlePurchaseSuppliesLabel)
        
        self.lemonsPurchaseIcon = UIImageView()
        self.lemonsPurchaseIcon.image = UIImage(named: "Lemon Inventory Icon")
        self.lemonsPurchaseIcon.frame = CGRect(x: containerView.frame.width * 1 * kFourth, y: containerView.frame.height * 3 * kFifth, width: containerView.frame.width * 1 * kFifth, height: containerView.frame.height * 1 * kThird)
        containerView.addSubview(self.lemonsPurchaseIcon)
        
        self.iceCubesPurchaseIcon = UIImageView()
        self.iceCubesPurchaseIcon.image = UIImage(named: "Ice Inventory Icon")
        self.iceCubesPurchaseIcon.frame = CGRect(x: containerView.frame.width * 2 * kFourth, y: containerView.frame.height * 3 * kFifth, width: containerView.frame.width * 1 * kFifth, height: containerView.frame.height * 1 * kThird)
        containerView.addSubview(self.iceCubesPurchaseIcon)

        
        
        self.buyLemonsPlusButton = UIButton()
        self.buyLemonsPlusButton.setTitle("+", forState: UIControlState.Normal)
        self.buyLemonsPlusButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.buyLemonsPlusButton.backgroundColor = UIColor.whiteColor()
        self.buyLemonsPlusButton.sizeToFit()
        self.buyLemonsPlusButton.center = CGPoint(x: containerView.frame.width * 1 * kSixth, y: containerView.frame.height * 3 * kFifth)
        self.buyLemonsPlusButton.addTarget(self, action: "buyLemonsPlusButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.buyLemonsPlusButton)
        
        self.buyLemonsLessButton = UIButton()
        self.buyLemonsLessButton.setTitle("-", forState: UIControlState.Normal)
        self.buyLemonsLessButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.buyLemonsLessButton.backgroundColor = UIColor.whiteColor()
        self.buyLemonsLessButton.sizeToFit()
        self.buyLemonsLessButton.center = CGPoint(x: containerView.frame.width * 1 * kSixth, y: containerView.frame.height * 4 * kFifth)
        self.buyLemonsLessButton.addTarget(self, action: "buyLemonsLessButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.buyLemonsLessButton)
        
        self.buyIceCubesPlusButton = UIButton()
        self.buyIceCubesPlusButton.setTitle("+", forState: UIControlState.Normal)
        self.buyIceCubesPlusButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.buyIceCubesPlusButton.backgroundColor = UIColor.whiteColor()
        self.buyIceCubesPlusButton.sizeToFit()
        self.buyIceCubesPlusButton.center = CGPoint(x: containerView.frame.width * 5 * kSixth, y: containerView.frame.height * 3 * kFifth)
        self.buyIceCubesPlusButton.addTarget(self, action: "buyIceCubesPlusButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.buyIceCubesPlusButton)
        
        self.buyIceCubesLessButton = UIButton()
        self.buyIceCubesLessButton.setTitle("-", forState: UIControlState.Normal)
        self.buyIceCubesLessButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.buyIceCubesLessButton.backgroundColor = UIColor.whiteColor()
        self.buyIceCubesLessButton.sizeToFit()
        self.buyIceCubesLessButton.center = CGPoint(x: containerView.frame.width * 5 * kSixth, y: containerView.frame.height * 4 * kFifth)
        self.buyIceCubesLessButton.addTarget(self, action: "buyIceCubesLessButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.buyIceCubesLessButton)
        
    }
    
    func setupMixLemonadeContainer(containerView: UIView) {
        self.titleMixLabel = UILabel()
        self.titleMixLabel.text = "Step 2: Today's Mix"
        self.titleMixLabel.textColor = UIColor.blackColor()
        self.titleMixLabel.sizeToFit()
        self.titleMixLabel.center = CGPoint(x: containerView.frame.width * kHalf, y: containerView.frame.height * 1 * kSixth)
        self.titleMixLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.titleMixLabel)
        
        
        self.lemonsMixIcon = UIImageView()
        self.lemonsMixIcon.image = UIImage(named: "Lemon Icon")
        self.lemonsMixIcon.frame = CGRect(x: containerView.frame.width * 1.8/9.0, y: containerView.frame.height * 4.0/9.0, width: containerView.frame.width * kFifth, height: containerView.frame.width * kFifth * 1.08)
        containerView.addSubview(self.lemonsMixIcon)
        
        self.iceCubesMixIcon = UIImageView()
        self.iceCubesMixIcon.image = UIImage(named: "Ice Icon")
        self.iceCubesMixIcon.frame = CGRect(x: containerView.frame.width * 5.5/9.0, y: containerView.frame.height * 4.3/9.0, width: containerView.frame.width * kFifth, height: containerView.frame.width * kFifth * 1.02)
        containerView.addSubview(self.iceCubesMixIcon)
        
        self.mixLemonsPlusButton = UIButton()
        self.mixLemonsPlusButton.setTitle("+", forState: UIControlState.Normal)
        self.mixLemonsPlusButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.mixLemonsPlusButton.backgroundColor = UIColor.whiteColor()
        self.mixLemonsPlusButton.sizeToFit()
        self.mixLemonsPlusButton.center = CGPoint(x: containerView.frame.width * 1.0/9.0, y: containerView.frame.height * 3 * kFifth)
        self.mixLemonsPlusButton.addTarget(self, action: "mixLemonsPlusButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.mixLemonsPlusButton)
        
        self.mixLemonsLessButton = UIButton()
        self.mixLemonsLessButton.setTitle("-", forState: UIControlState.Normal)
        self.mixLemonsLessButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.mixLemonsLessButton.backgroundColor = UIColor.whiteColor()
        self.mixLemonsLessButton.sizeToFit()
        self.mixLemonsLessButton.center = CGPoint(x: containerView.frame.width * 1.0/9.0, y: containerView.frame.height * 4 * kFifth)
        self.mixLemonsLessButton.addTarget(self, action: "mixLemonsLessButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.mixLemonsLessButton)
        
        self.mixIceCubesPlusButton = UIButton()
        self.mixIceCubesPlusButton.setTitle("+", forState: UIControlState.Normal)
        self.mixIceCubesPlusButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.mixIceCubesPlusButton.backgroundColor = UIColor.whiteColor()
        self.mixIceCubesPlusButton.sizeToFit()
        self.mixIceCubesPlusButton.center = CGPoint(x: containerView.frame.width * 8.0/9.0, y: containerView.frame.height * 3 * kFifth)
        self.mixIceCubesPlusButton.addTarget(self, action: "mixIceCubesPlusButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.mixIceCubesPlusButton)
        
        self.mixIceCubeLessButton = UIButton()
        self.mixIceCubeLessButton.setTitle("-", forState: UIControlState.Normal)
        self.mixIceCubeLessButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.mixIceCubeLessButton.backgroundColor = UIColor.whiteColor()
        self.mixIceCubeLessButton.sizeToFit()
        self.mixIceCubeLessButton.center = CGPoint(x: containerView.frame.width * 8.0/9.0, y: containerView.frame.height * 4 * kFifth)
        self.mixIceCubeLessButton.addTarget(self, action: "mixIceCubesLessButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.mixIceCubeLessButton)
        
    }
    
    func setupStartSellingContainer(containerView: UIView) {
        
        self.startSellingTitleLabel = UILabel()
        self.startSellingTitleLabel.text = "Step 3: Start Selling"
        self.startSellingTitleLabel.textColor = UIColor.redColor()
        self.startSellingTitleLabel.sizeToFit()
        self.startSellingTitleLabel.center = CGPoint(x: containerView.frame.width * kHalf, y: containerView.frame.height / 30.0)
        self.startSellingTitleLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.startSellingTitleLabel)
        
        self.startSellingButton = UIButton()
        self.startSellingButton.setTitle("Open Shop for the Day", forState: UIControlState.Normal)
        self.startSellingButton.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        self.startSellingButton.backgroundColor = UIColor.whiteColor()
        self.startSellingButton.sizeToFit()
        self.startSellingButton.center = CGPoint(x: containerView.frame.width * kThird, y: containerView.frame.height * 4 / 20.0)
        self.startSellingButton.addTarget(self, action: "startSellingButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        containerView.addSubview(self.startSellingButton)
        
        self.resetLemonadeButton = UIButton()
        self.resetLemonadeButton.setTitle("Reset Game", forState: UIControlState.Normal)
        self.resetLemonadeButton.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        self.resetLemonadeButton.backgroundColor = UIColor.whiteColor()
        self.resetLemonadeButton.sizeToFit()
        self.resetLemonadeButton.center = CGPoint(x: containerView.frame.width * 3 * kFourth, y: containerView.frame.height * 4 / 20.0)
        self.resetLemonadeButton.addTarget(self, action: "resetLemonadeStandButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.resetLemonadeButton)
        
        self.customersIcon = UIImageView()
        self.customersIcon.image = UIImage(named: "customers-icon")
        self.customersIcon.frame = CGRect(x: containerView.frame.width * 1.3/10.0, y: containerView.frame.height * 1.0/17.0, width: containerView.frame.width * 1.0/7.0, height: containerView.frame.width * 1.0/7.0 * 0.93)
        containerView.addSubview(self.customersIcon)
        
        self.startSellingResultCustomersLabel = UILabel()
        self.startSellingResultCustomersLabel.text = "ØØ"
        self.startSellingResultCustomersLabel.textColor = UIColor.blackColor()
        self.startSellingResultCustomersLabel.sizeToFit()
        self.startSellingResultCustomersLabel.center = CGPoint(x: containerView.frame.width * 1 * kFifth, y: containerView.frame.height / 6.5)
        self.startSellingResultCustomersLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.startSellingResultCustomersLabel)
        
        self.earnCashIcon = UIImageView()
        self.earnCashIcon.image = UIImage(named: "money_icon")
        self.earnCashIcon.frame = CGRect(x: containerView.frame.width * 3.3/10.0, y: containerView.frame.height * 1.3/17.0, width: containerView.frame.width * 1.0/7.0, height: containerView.frame.width * 1.0/7.0 * 0.58)
        containerView.addSubview(self.earnCashIcon)
        
        self.startSellingResultWinningsLabel = UILabel()
        self.startSellingResultWinningsLabel.text = "$ Ø"
        self.startSellingResultWinningsLabel.textColor = UIColor.blackColor()
        self.startSellingResultWinningsLabel.sizeToFit()
        self.startSellingResultWinningsLabel.center = CGPoint(x: containerView.frame.width * 2 * kFifth, y: containerView.frame.height / 6.5)
        self.startSellingResultWinningsLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.startSellingResultWinningsLabel)
        
        self.mixResultIcon = UIImageView()
        self.mixResultIcon.image = UIImage(named: "Lemonade Icon (small)")
        self.mixResultIcon.frame = CGRect(x: containerView.frame.width * 5.3/10.0, y: containerView.frame.height * 1.0/17.0, width: containerView.frame.width * 1.0/7.0, height: containerView.frame.width * 1.0/7.0 * 0.96)
        containerView.addSubview(self.mixResultIcon)
        
        self.startSellingResultMixLabel = UILabel()
        self.startSellingResultMixLabel.text = "tastylicious"
        self.startSellingResultMixLabel.textColor = UIColor.blackColor()
        self.startSellingResultMixLabel.sizeToFit()
        self.startSellingResultMixLabel.center = CGPoint(x: containerView.frame.width * 3 * kFifth, y: containerView.frame.height / 6.5)
        self.startSellingResultMixLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.startSellingResultMixLabel)
        
        self.previousWeatherIcon = UIImageView()
        self.previousWeatherIcon.image = UIImage(named: "")
        self.previousWeatherIcon.frame = CGRect(x: containerView.frame.width * 7.3/10.0, y: containerView.frame.height * 1.0/17.0, width: containerView.frame.width * 1.0/7.0, height: containerView.frame.width * 1.0/7.0 * 0.96)
        containerView.addSubview(self.previousWeatherIcon)
        
        self.startSellingResultWeatherLabel = UILabel()
        self.startSellingResultWeatherLabel.text = "weather"
        self.startSellingResultWeatherLabel.textColor = UIColor.blackColor()
        self.startSellingResultWeatherLabel.sizeToFit()
        self.startSellingResultWeatherLabel.center = CGPoint(x: containerView.frame.width * 4 * kFifth, y: containerView.frame.height / 6.5)
        self.startSellingResultWeatherLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.startSellingResultWeatherLabel)
        
    }
    
    func showAlertWithText (header : String = "Warning", message : String) {
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

}

