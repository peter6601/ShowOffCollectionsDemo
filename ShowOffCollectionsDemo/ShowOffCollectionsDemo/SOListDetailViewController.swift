//
//  SOListDetailViewController.swift
//  ShowOffCollectionsDemo
//
//  Created by DinDin on 2022/2/18.
//

import UIKit
import Alamofire


class SOListDetailViewController: UIViewController {
    
    
    private var vMain: UIView = {
       let v = UIView()
        return v
    }()
    
    private var scMain: UIScrollView = {
       let sv = UIScrollView()
        sv.isScrollEnabled = true
        sv.bounces = false
        return sv
    }()
    
    private var imgvMain: UIImageView = {
       let imgv = ScaledHeightImageView()
        imgv.contentMode = .scaleAspectFit
        imgv.backgroundColor = .white
        return imgv
    }()
    
    private var llName: UILabel = {
        let ll = UILabel()
        ll.numberOfLines = 0
        ll.textColor = .white
        ll.textAlignment = .center
        ll.font = UIFont.systemFont(ofSize: 18)
        ll.backgroundColor = .blue
        return ll
    }()
    
    private var llDescription: UILabel = {
        let ll = UILabel()
        ll.numberOfLines = 0
        ll.textColor = .white
        ll.font = UIFont.systemFont(ofSize: 12)
        ll.backgroundColor = .blue

        return ll
    }()
    
    private var assetElement: AssetElement

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scMain.contentSize = vMain.frame.size

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    init(data: AssetElement) {
        self.assetElement = data
        super.init(nibName: nil, bundle: nil)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
  
    
    private func initUI() {
        self.view.addSubview(scMain)
        self.scMain.addSubview(vMain)
        self.vMain.addSubview(imgvMain)
        self.vMain.addSubview(llName)
        self.vMain.addSubview(llDescription)
        self.scMain.snp.makeConstraints { m in
            m.top.leading.trailing.equalToSuperview()
            m.height.equalTo(self.view.frame.height)
        }
        self.vMain.snp.makeConstraints { m in
            m.leading.trailing.equalTo(self.view)
            m.top.equalToSuperview()
        }
        self.imgvMain.snp.makeConstraints { m in
            m.top.leading.equalToSuperview().offset(5)
            m.trailing.equalToSuperview().offset(-5)
            m.height.equalTo(self.imgvMain.snp.width)
        }
        self.llName.snp.makeConstraints { m in
            m.leading.equalToSuperview().offset(10)
            m.trailing.equalToSuperview().offset(-10)
            m.top.equalTo(self.imgvMain.snp.bottom).offset(10)
            m.height.equalTo(20)
        }
        self.llDescription.snp.makeConstraints { m in
            m.leading.equalToSuperview().offset(10)
            m.trailing.equalToSuperview().offset(-10)
            m.top.equalTo(self.llName.snp.bottom).offset(10)
            m.bottom.equalToSuperview()
        }
    }
    
    private func updateUI() {
        self.llName.text = assetElement.collection.name
        if let url = URL(string: assetElement.imageURL) {
            imgvMain.kf.setImage(with: url)
        }
        self.view.backgroundColor = .white
        self.llDescription.text = assetElement.assetDescription
 
    }
}
