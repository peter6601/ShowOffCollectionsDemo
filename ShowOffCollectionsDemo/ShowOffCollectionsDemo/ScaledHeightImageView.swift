//
//  ScaledHeightImageView.swift
//  ShowOffCollectionsDemo
//
//  Created by DinDin on 2022/2/18.
//

import UIKit

class ScaledHeightImageView: UIImageView {

    override var intrinsicContentSize: CGSize {

        if let myImage = self.image {
            let myImageWidth = myImage.size.width
            let myImageHeight = myImage.size.height
            let myViewWidth = self.frame.size.width
            let ratio = myViewWidth/myImageWidth
            let scaledHeight = myImageHeight * ratio
            return CGSize(width: myViewWidth, height: scaledHeight)
        } else {
            return CGSize(width: -1.0, height: -1.0)
        }
    }

}
