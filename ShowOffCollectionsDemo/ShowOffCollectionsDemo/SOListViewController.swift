//
//  ListViewController.swift
//  ShowOffCollectionsDemo
//
//  Created by DinDin on 2022/2/13.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift


class SOListViewController: UIViewController {

    private var viewModel: SOListViewModelBinding!
    private lazy var cvMain: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        var cv = UICollectionView(frame:.zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    private let disposeBag = DisposeBag()
    
    init(vm: SOListViewModelBinding) {
        super.init(nibName: nil, bundle: nil)
        viewModel = vm
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewBinding()
        viewModel.viewDidLoad()
    }
    
    private func initUI() {
        self.view.addSubview(cvMain)
        self.cvMain.snp.makeConstraints { m in
            m.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    private func collectionViewBinding() {
        self.cvMain.register(SOCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: SOCollectionViewCell.self))
        self.cvMain.delegate = self
        self.viewModel.list.bind(to: cvMain.rx.items(cellIdentifier: String(describing: SOCollectionViewCell.self), cellType: SOCollectionViewCell.self)) { (row, asset , cell) in
            cell.bind(data: asset)
        }.disposed(by: disposeBag)
        self.cvMain.rx.willDisplayCell.subscribe { (cell, indexPath) in
            self.viewModel.checkToNextPage(indexPath.row)
        }.disposed(by: disposeBag)
    }
}

extension SOListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.didSelected(indexPath: indexPath)
    }
}

extension SOListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewStyle = viewModel.viewStyle
        let totslWidth =  self.cvMain.frame.width
        let cellPerLine: CGFloat =  CGFloat(viewStyle.cellPerLine)
        let width =  floor((totslWidth - CGFloat(viewStyle.cellPadding) * (cellPerLine + 1) ) / cellPerLine)
        let height = floor((width) * CGFloat(viewStyle.cellHeightRatio))
        return CGSize(width: width, height: height )
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(viewModel.viewStyle.cellPadding)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(viewModel.viewStyle.cellPadding)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let cellPadding = viewModel.viewStyle.cellPadding
        return UIEdgeInsets(top: CGFloat(cellPadding), left: CGFloat(cellPadding), bottom: CGFloat(cellPadding), right: CGFloat(cellPadding))
    }

}

