//
//  InfoWindowView.swift
//  Roadbull
//
//  Created by TriNgo on 2/8/18.
//  Copyright © 2018 TriNgo. All rights reserved.
//

import UIKit

class InfoWindowView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var tvFrom: UILabel!
    @IBOutlet weak var tvAddress: UILabel!
    @IBOutlet weak var tvPostalCode: UILabel!
    @IBOutlet weak var tvParcels: UILabel!
    @IBOutlet weak var tvRemarks: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("InfoWindowView", owner: self, options: nil)
        guard let content = contentView else { return }
        content.frame = self.bounds
        content.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(content)
    }
    
    var place: Place? {
        didSet {
            if let place = place {
                tvFrom.text = "From: \(place.from)"
                tvAddress.text = "Address: \(place.address)"
                tvPostalCode.text = "Postal code: \(place.postalCode)"
                tvParcels.text = "Total parcels: \(place.parcels)"
                tvRemarks.text = "Remarks: \(place.remark)"
            }
        }
    }
}
