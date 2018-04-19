//
//  ViewController.swift
//  SunsetAndSunrise
//
//  Created by Dima Paliychuk on 4/18/18.
//  Copyright © 2018 Dima Paliychuk. All rights reserved.
//

import UIKit
import GooglePlaces
import PKHUD

class SunsetAndSunriseViewController: UIViewController {
    
    @IBOutlet private weak var informationLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var currentLocationButton: UIButton!
    @IBOutlet private weak var selectLocationButton: UIButton!
    
    private var placesClient: GMSPlacesClient!
    private var locationManager = LocationManager()
    
    
    //MARK: life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setup()
    }
    
    
    //MARK: private
    
    private func setupUI() {
        informationLabel.text = "select_location".localized
        currentLocationButton.setTitle("current_location".localized, for: .normal)
        selectLocationButton.setTitle("select_location".localized, for: .normal)
    }
    
    private func setup() {
        locationManager.requestAuthorization()
        placesClient = GMSPlacesClient.shared()
    }
    
    private func getInfoModelForm(place: GMSPlace) {
        informationLabel.text = "sunrise_sunset_information".localized + place.name
        API.shared.getDescriptionFor(coordinate: place.coordinate,
                                     completion: { [weak self] (result) in
                                        guard let infoModel = result.value?.results else {
                                            HUD.flash(.error, delay: 1.0)
                                            return
                                        }
                                        HUD.flash(.success, delay: 1.0)
                                        self?.setDescriptionFrom(infoModel: infoModel)
        })
    }
    
    private func setDescriptionFrom(infoModel: InfoModel) {
        var description = ""
        
        description += "sunrise".localized + " : " + infoModel.sunrise + "\n"
        description += "sunset".localized + " : " + infoModel.sunset + "\n"
        description += "solar_noon".localized + " : " + infoModel.solarNoon + "\n"
        description += "day_length".localized + " : " + infoModel.dayLength + "\n"
        description += "civil_twilight_begin".localized + " : " +
            infoModel.civilTwilightBegin + "\n"
        description += "civil_twilight_end".localized + " : " + infoModel.civilTwilightEnd + "\n"
        description += "nautical_twilight_begin".localized + " : " +
            infoModel.nauticalTwilightBegin + "\n"
        description += "nautical_twilight_end".localized + " : " +
            infoModel.nauticalTwilightEnd + "\n"
        description += "astronomical_twilight_begin".localized + " : " +
            infoModel.astronomicalTwilightBegin + "\n"
        description += "astronomical_twilight_end".localized + " : " +
            infoModel.astronomicalTwilightEnd + "\n"
        
        descriptionLabel.text = description
    }
    
    
    //MARK: actions
    
    @IBAction func selectPlaceAction(_ sender: Any) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }
    
    @IBAction func getCurrentPlaceAction(_ sender: Any) {
        HUD.show(.progress)
        placesClient.currentPlace(callback: { [weak self] (placeLikelihoodList, error) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                HUD.flash(.error, delay: 1.0)
                return
            }
            
            guard let placeLikelihoodList = placeLikelihoodList,
                let place = placeLikelihoodList.likelihoods.first?.place else {
                    HUD.flash(.error, delay: 1.0)
                    return
            }
            
            self?.getInfoModelForm(place: place)
        })
    }
}


extension SunsetAndSunriseViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController,
                        didAutocompleteWith place: GMSPlace) {
        getInfoModelForm(place: place)
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
        HUD.flash(.error, delay: 1.0)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
        HUD.hide()
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
