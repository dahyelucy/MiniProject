//
//  CartViewController.swift
//  MiniProject
//
//  Created by 최다혜 on 2022/11/10.
//

import UIKit

public class CartViewController:
    UIViewController,
    UITableViewDelegate,
    UITableViewDataSource
{
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "장바구니"
        label.font = .systemFont(ofSize: 25)
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellType: CartProductCell.self)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 60
        tableView.separatorInset = .zero
        return tableView
    }()
    
    private let guideLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "배송비 3,000원 (총 상품금액 5만원 이상 무료 배송)"
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let totalProductPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "총 상품 금액"
        return label
    }()
    
    private let totalProductPriceNumLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let shippingChargeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "배송비"
        return label
    }()
    
    private let shippingChargeNumLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let totalPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "총 결제금액"
        return label
    }()
    
    private let totalPriceNumLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var productList = [Product]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        fetchDatas()
    }

    private func setupViews() {
        
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(guideLabel)
        view.addSubview(stackView)
 
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaTopInset() + 15),
            titleLabel.widthAnchor.constraint(equalToConstant: titleLabel.intrinsicContentSize.width),
            titleLabel.heightAnchor.constraint(equalToConstant: titleLabel.intrinsicContentSize.height),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 200),
            
            guideLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            guideLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            guideLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 15),
            
            stackView.widthAnchor.constraint(equalToConstant: 200),
            stackView.heightAnchor.constraint(equalToConstant: 150),
            stackView.topAnchor.constraint(equalTo: guideLabel.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
        ])
        
        stackView.addArrangedSubview(
            UIStackView(arrangedSubviews: [totalProductPriceLabel, totalProductPriceNumLabel])
        )
        stackView.addArrangedSubview(
            UIStackView(arrangedSubviews: [shippingChargeLabel, shippingChargeNumLabel])
        )
        stackView.addArrangedSubview(
            UIStackView(arrangedSubviews: [totalPriceLabel, totalPriceNumLabel])
        )

    }
    
    private func fetchDatas() {
        let urlString = "http://localhost:3301/v1/product/"
        ProductList.request(urlString: urlString) { [weak self] productList in
            guard let self = self else {
                return
            }
            self.productList = productList.productList
            
            let totalProductValue = self.productList.map {
                return $0.price
            }.reduce(0, +)
            let totalProductCount = self.productList.count
            let shippingCharge: Int = totalProductValue > 50000 ? 0 : 3000
            let totalPrice: Int = totalProductValue + shippingCharge
            
            self.totalProductPriceNumLabel.text = Formatter.balanceFormatter.string(from: NSNumber(value: totalProductValue))
            self.shippingChargeNumLabel.text = "\(shippingCharge)"
            self.totalPriceNumLabel.text = "(\(totalProductCount)개) \(totalPrice)"
        }
    }

}

// MARK: - UITableViewDelegate
extension CartViewController {
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartProductCell", for: indexPath) as? CartProductCell else {
            return UITableViewCell()
        }
        cell.updateCell(with: productList[indexPath.row])
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("💚 \(#function)")
        
        let detailViewController = CartDetailViewController()
        detailViewController.setCartDetailID(indexPath.row + 1)
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension CartViewController {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
}
