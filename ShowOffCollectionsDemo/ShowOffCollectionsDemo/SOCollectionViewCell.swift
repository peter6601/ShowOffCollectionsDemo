//
//  SOCollectionViewCell.swift
//  ShowOffCollectionsDemo
//
//  Created by DinDin on 2022/2/17.
//

import UIKit
import Kingfisher


class SOCollectionViewCell: UICollectionViewCell {
    var imgvMain: UIImageView = {
        let imgv = UIImageView()
        return imgv
    }()
    
    var llName: UILabel = {
        let ll = UILabel()
        ll.font = UIFont.systemFont(ofSize: 10)
        ll.numberOfLines = 0
        return ll
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(data: AssetElement) {
        llName.text = data.name
        if let url = URL(string: data.imageURL) {
            imgvMain.kf.setImage(with: url)
        }
    }
    
    private func initUI() {
        self.addSubview(self.imgvMain)
        self.addSubview(self.llName)
        self.imgvMain.snp.makeConstraints { m in
            m.top.leading.equalToSuperview().offset(10)
            m.trailing.equalToSuperview().offset(-10)
            m.height.equalTo(self.imgvMain.snp.width)
        }
        self.llName.snp.makeConstraints { m in
            m.centerX.equalToSuperview()
            m.top.equalTo(self.imgvMain.snp.bottom).offset(10)
        }
    }
}
