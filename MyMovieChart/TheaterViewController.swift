//
//  TheaterViewController.swift
//  MyMovieChart
//
//  Created by doyun on 2021/11/15.
//

import UIKit
import MapKit

class TheaterViewController: UIViewController {

    var param:NSDictionary!
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = self.param["상영관명"] as? String
        
        let lat = (param?["위도"] as! NSString).doubleValue
        
        let lng = (param?["경도"] as! NSString).doubleValue
        
        let location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        
        let regionRadius: CLLocationDistance = 100
        
        let cordinateRegion = MKCoordinateRegion(center: location, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        
        map.setRegion(cordinateRegion, animated: true)
        // Do any additional setup after loading the view.
        
        let point = MKPointAnnotation()
        point.coordinate = location
        map.addAnnotation(point)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
