//
//  ViewController.swift
//  Map_here
//
//  Created by 前田雄亮 on 2015/06/14.
//  Copyright (c) 2015年 前田雄亮. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    var myMapView: MKMapView!
    var myLocationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //LocationManagerの生成
        myLocationManager = CLLocationManager()
        
        //Delegateの設定
        myLocationManager.delegate = self
        
        //距離のフィルタ
        myLocationManager.distanceFilter = 100.0
        
        //制度
        myLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        //セキュリティ認証のステータスを取得
        let status = CLLocationManager.authorizationStatus()
        
        //まだ認証が得られていない場合は、認証ダイアログを表示
        if(status == CLAuthorizationStatus.NotDetermined){
            //まだ認証が得られていない場合は認証ダイアログを表示
            self.myLocationManager.requestAlwaysAuthorization();
        }
        
        //位置情報の更新を開始
        myLocationManager.startUpdatingLocation()
        
        //MapViewの生成
        myMapView = MKMapView()
        
        //MapViewのサイズを画面全体に
        myMapView.frame = self.view.bounds
        
        //Delegateを設定
        myMapView.delegate = self
        
        //MapViewに追加
        myMapView.addSubview(myMapView)
        
        //中心点の緯度経度
        let myLat: CLLocationDegrees = 37.506804
        let myLon: CLLocationDegrees = 139.930531
        let myCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(myLat, myLon) as CLLocationCoordinate2D
        
        //縮尺
        let myLatDist : CLLocationDistance = 100
        let myLonDist : CLLocationDistance = 100
        
        //Regionを作成
        let myRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(myCoordinate, myLatDist, myLonDist);
        
        //MapViewに反映
        myMapView.setRegion(myRegion, animated: true)
    }
    
    //GPSから値を収得した際に呼び出されたメソッド
    func locatuionManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        //配列から現在座標を取得
        var myLocations: NSArray = locations as NSArray
        var myLastLocation: CLLocation = myLocations.lastObject as! CLLocation
        var myLocation: CLLocationCoordinate2D = myLastLocation.coordinate
        
        //縮尺
        let myLastDist: CLLocationDistance = 100
        let myLonDist: CLLocationDistance = 100
        
        //Regionを作成
        let myRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(myLocation, myLastDist, myLonDist);
        
        //MapViewに反映
        myMapView.setRegion(myRegion, animated: true)
    }
    
    //Regionが変更した時に呼び出されるメソッド
    func mapView(mapView: MKMapView!, regionDidChangeAnimated animated: Bool){
        println("regionDidChangeAnimated")
    }
    
    //認証が変更された時に呼び出されるメソッド
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status{
        case .AuthorizedWhenInUse:
            println("AuthoeizedWhenInUse")
        /*
        case .Authorized:
            println("Authorized")
        */
        case .Denied:
            println("Denied")
        case .Restricted:
            println("Resticated")
        case .NotDetermined:
            println("NotDetermined")
        default:
            println("etc.")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

