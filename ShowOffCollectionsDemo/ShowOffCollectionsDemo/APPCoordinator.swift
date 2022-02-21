//
//  APPCoordinator.swift
//  ShowOffCollectionsDemo
//
//  Created by DinDin on 2022/2/18.
//

import UIKit

protocol APPCoordinatorProtocol  {
    
    func start(with type: PageType)
    func showTo(_ type: PageType)
    func back()
    
}

class APPCoordinator: APPCoordinatorProtocol {
    
    var nav: UINavigationController? = nil
    var window: UIWindow
    init(window: UIWindow, nav: UINavigationController? = nil) {
        self.window = window
        self.nav = nav
    }
    
    func start(with type: PageType) {
        let vc = type.makeVC(api: APIService.shared, coordinator: self)
        if let navController = nav {
            var vcs: [UIViewController] = navController.viewControllers
            vcs.insert(vc, at: vcs.count - 1)
        }else {
            self.nav = UINavigationController.init(rootViewController: vc)
        }
        self.window.rootViewController = self.nav
        self.window.makeKeyAndVisible()
    }
    func showTo(_ type: PageType) {
        let vc = type.makeVC(api: APIService.shared, coordinator: self)
        if let nav = nav {
            nav.pushViewController(vc, animated: true)
        }
    }
    func back() {
        if let _nav = nav {
            _nav.popViewController(animated: true)
        }
    }
}

enum PageType {
    
    case SOListVC
    case SOListDetailVC(data: AssetElement)
    
    func makeVC(api: APIService? = nil, coordinator: APPCoordinator? = nil) -> UIViewController {
        switch self {
        case .SOListVC:
            if let api = api,let coordinator = coordinator {
                let vm = SOListViewModel(apiService: api, coordinator: coordinator)
                return SOListViewController(vm: vm)
            } else {
                fatalError()
            }
        case .SOListDetailVC(let data):
            return SOListDetailViewController(data: data)
        }
    }
}

