//
//  TodayViewController.swift
//  CustomWidget
//
//  Created by Valzi Mattia on 22/01/2018.
//  Copyright © 2018 Valzi Mattia. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    var images : [UIImage]?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        print("widget")
        if #available(iOSApplicationExtension 10.0, *) {
            self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        } else {
            // Fallback on earlier versions
            preferredContentSize.height = 200
        }
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
        // Do any additional setup after loading the view from its nib.
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @available(iOSApplicationExtension 10.0, *)
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        
        switch activeDisplayMode {
        case .expanded: preferredContentSize.height = 200
        case .compact: preferredContentSize.height = 450
        }
    }
    
    @available(iOS, introduced: 8.0, deprecated: 10.0, message: "This method will not be called on widgets linked against iOS versions 10.0 and later.")
    func widgetMarginInsets(forProposedMarginInsets defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imagesCollectionView.dequeueReusableCell(withReuseIdentifier: WidgetCollectionViewCell.identifier, for: indexPath) as? WidgetCollectionViewCell
        cell?.config()
       // cell?.layoutIfNeeded()
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = imagesCollectionView.frame.width
        print(width)
        return CGSize(width: width / 5, height: width / 4)
    }
    
}

class WidgetCollectionViewCell : UICollectionViewCell {
    
    static let identifier = "WidgetCollectionViewCell"
    
    @IBOutlet weak var logoImage: UIImageView!
    
    let masterCardLogo = "https://image.flaticon.com/icons/png/128/196/196562.png"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       // config()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    func config() {
        let url = URL(string: masterCardLogo)
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        logoImage.image = UIImage(data: data!)
    }
    
}
