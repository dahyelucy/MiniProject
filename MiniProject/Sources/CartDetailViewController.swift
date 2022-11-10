//
//  CartDetailViewController.swift
//  MiniProject
//
//  Created by 최다혜 on 2022/11/10.
//

import UIKit

public class CartDetailViewController: UIViewController {

    private let productLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 25)
        return label
    }()
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "판매가"
        return label
    }()
    
    private let priceValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let makerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "제조사"
        return label
    }()
    
    private let makerValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let modelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "모델명"
        return label
    }()
    
    private let modelValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        fetchDatas()
    }
    
    private var detailID: Int = 0
    
    public func setCartDetailID(_ id: Int) {
        self.detailID = id
    }

    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(productLabel)
        view.addSubview(productImageView)
        view.addSubview(stackView)
 
        NSLayoutConstraint.activate([
            productLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaTopInset() + 20),
            productLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            productImageView.topAnchor.constraint(equalTo: productLabel.bottomAnchor, constant: 20),
            productImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 200),
            productImageView.heightAnchor.constraint(equalToConstant: 200),
            
            stackView.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 20),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 200),
            stackView.heightAnchor.constraint(equalToConstant: 200),
        ])
        
        stackView.addArrangedSubview(
            UIStackView(arrangedSubviews: [priceLabel, priceValueLabel])
        )
        stackView.addArrangedSubview(
            UIStackView(arrangedSubviews: [makerLabel, makerValueLabel])
        )
        stackView.addArrangedSubview(
            UIStackView(arrangedSubviews: [modelLabel, modelValueLabel])
        )
    }
    
    private func fetchDatas() {
        let urlString = "http://localhost:3301/v1/product/detail/\(self.detailID)"
        ProductDetail.request(urlString: urlString) { [weak self] product in
            guard let self = self else {
                return
            }
            
            self.productLabel.text = product.productName
            self.priceValueLabel.text = Formatter.balanceFormatter.string(from: NSNumber(value: product.price))
            self.makerValueLabel.text = product.maker
            self.modelValueLabel.text = product.model
        }
    }

}
