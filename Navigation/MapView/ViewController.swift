

import MapKit
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager?
    private let annotationIdentifier = "com.prrane.MapAnnotationIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupViewController()
    }
    
    private func setupViewController() {
        navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))
        
        setupLocationManager()
        setupMap()
    }
    
    private func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.startUpdatingLocation()
        locationManager?.activityType = .otherNavigation
        locationManager?.pausesLocationUpdatesAutomatically = true
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager?.requestWhenInUseAuthorization()
        }
    }
    
    private func setupMap() {
        mapView?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}


// MARK:- CLLocationManagerDelegate

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined, .denied, .restricted, .authorizedWhenInUse:
            // Don't do anything.
            break
            
        case .authorizedAlways:
            break
        }
    }
    
    func locationManagerDidPauseLocationUpdates(_ manager: CLLocationManager) {
        print("location manager paused updates")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else {
            print("failed to get user's coordinate")
            return
        }
        
        print("updated user's coordinate")
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.0025, longitudeDelta: 0.0025))
        
        self.mapView.setRegion(region, animated: true)
        
        updateCars()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error retrieving user's coordinate: \(error)")
    }
}


// MARK:- MKMapViewDelegate

extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // Skip user's location.
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
        
        guard let _ = annotationView else {
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView.annotation = annotation
            annotationView.image = UIImage(named: "ridecell_pin")
            return annotationView
        }
        
        return annotationView
    }
    
}


// MARK: - Helpers

// Update Data/Annotations
extension ViewController {
    
    private func updateCars() {
        DispatchQueue.global(qos: .default).async {
            do {
                let cars = try DataManager.shared.fetchCars()
                let annotations: [MKPointAnnotation] = cars.flatMap { car in
                    if let lat = car.gpsposition?.location?.lat, let lng = car.gpsposition?.location?.lng {
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                        return annotation
                    }
                    return nil
                }
                
                DispatchQueue.main.async {
                    if annotations.isEmpty {
                        print("No cars available")
                        // Show user an error
                    }
                    
                    self.mapView?.addAnnotations(annotations)
                }
            }
            catch let error {
                print("failed to display cars on map: \(error)")
            }
        }
    }
    
}
