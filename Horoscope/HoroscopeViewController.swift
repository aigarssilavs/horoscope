//
//  ViewController.swift
//  Horoscope
//
//  Created by Aigars Silavs on 11/03/2019.
//  Copyright © 2019 Printful, Inc. All rights reserved.
//

import UIKit

class HoroscopeViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var horoscopeTextView: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    private var isLoadingHoroscope: Bool = false {
        didSet {
            self.reloadActivityIndicator()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reloadUI(withHoroscope: nil)
        self.reloadActivityIndicator()
    }

    func loadHoroscope(forSunsign sunsign: Sunsign) {
        self.reloadTitle(withSunsign: sunsign)
        self.isLoadingHoroscope = true
        horoscopeAPI.horoscope(forSunsign: sunsign) { (horoscope, error) in
            DispatchQueue.main.async {
                self.isLoadingHoroscope = false
                self.reloadUI(withHoroscope: horoscope)
                if let error = error {
                    self.alert(error: error)
                }
            }
        }
    }
    
    private func reloadUI(withHoroscope horoscope: Horoscope? = nil) {
        horoscopeTextView.text = horoscope?.description
        reloadDateLabel(withDate: horoscope?.date)
    }

    private func reloadTitle(withSunsign sunsign: Sunsign) {
        self.title = sunsign.rawValue.capitalized
    }
    
    func reloadActivityIndicator() {
        guard self.isViewLoaded else {
            return
        }
        if isLoadingHoroscope {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    private func reloadDateLabel(withDate date: Date?) {
        guard let date = date else {
            dateLabel.text = nil
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, LLLL d"
        let dateString = dateFormatter.string(from: date)
        dateLabel.text = "Horoscope for \(dateString)"
    }
    
    func alert(error: Error) {
        self.alert(title: "Error", message: String(describing: error))
    }
    
    func alert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .`default`, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
}

