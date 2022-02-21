//
//  SOListViewModel.swift
//  ShowOffCollectionsDemo
//
//  Created by DinDin on 2022/2/17.
//

import Foundation
import RxSwift
import RxRelay

struct SOListViewStyle {
    var cellHeightRatio: Float = 1
    var cellPadding: Float = 5
    var cellPerLine: Int = 2
}


protocol SOListViewModelBinding {
    var list: BehaviorRelay<[AssetElement]> {get}
    var loading: BehaviorRelay<Bool> {get}
    var viewStyle: SOListViewStyle {get}
    func checkToNextPage(_ index: Int)
    func didSelected(indexPath: IndexPath)
    func viewDidLoad()
}


class SOListViewModel: SOListViewModelBinding {
    var loading: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var list: BehaviorRelay<[AssetElement]> = BehaviorRelay(value: [])
    var viewStyle: SOListViewStyle = SOListViewStyle()
    private var offset: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    private var limit: Int = 20
    private var apiService: APIService
    private var appCoordinator: APPCoordinatorProtocol
    private let disposeBag = DisposeBag()

    init(apiService: APIService, coordinator: APPCoordinatorProtocol) {
        self.apiService = apiService
        self.appCoordinator = coordinator
    }
    
    func checkToNextPage(_ index: Int) {
        guard loading.value == false else { return }
        guard (limit - (list.value.count % limit)) < 5 else { return }
        guard index >= limit - 4 else { return }
        self.offset.accept(offset.value + 1)
    }
    
    func viewDidLoad() {
        self.setUpBinding()
    }
    
    func didSelected(indexPath: IndexPath) {
        let item = self.list.value[indexPath.row]
        self.appCoordinator.showTo(.SOListDetailVC(data: item))
    }
    
    private func setUpBinding() {
        self.offset.subscribe { _ in
            self.requestAPI()
        }.disposed(by: disposeBag)
    }
    
    private func requestAPI() {
        loading.accept(true)
        self.apiService.request(target: .assets(offet: self.offset.value, limit: self.limit))
        {[weak self] (result: Result<AssetsRoot, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let assetRoot):
                let temp = self.list.value + assetRoot.assets
                self.list.accept(temp)
                self.loading.accept(false)
            case .failure(let error):
                break
            }
        }
    }
}
