module 0x524ac2292d0862f294f1c4973b7d83b008e40e22c333156bc9747626053293f6::panzershop {
    struct PANZERSHOP has drop {
        dummy_field: bool,
    }

    struct RoyaltyCollector has drop, store {
        collector: address,
        amountBP: u64,
    }

    struct ProductArguments has drop, store {
        objectType: 0x1::string::String,
        args: vector<0x1::string::String>,
    }

    struct Product has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        priceSui: u64,
        priceKoban: u64,
        royalties: vector<RoyaltyCollector>,
        limit: u64,
        purchases: u64,
        whitelist: vector<address>,
        productArguments: ProductArguments,
    }

    struct PanzerShop has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        products: vector<Product>,
    }

    struct PanzerShopAuth has store, key {
        id: 0x2::object::UID,
        description: 0x1::string::String,
    }

    struct ProductPurchasedEvent has copy, drop {
        productId: 0x2::object::ID,
        sender: address,
    }

    public entry fun add_product(arg0: &PanzerShopAuth, arg1: &mut PanzerShop, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: vector<address>, arg6: vector<u64>, arg7: u64, arg8: vector<address>, arg9: 0x1::string::String, arg10: vector<0x1::string::String>, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 != 0 || arg4 != 0, 3);
        assert!(arg7 > 0, 4);
        let v0 = 0x1::vector::length<address>(&arg5);
        let v1 = 0x1::vector::length<u64>(&arg6);
        assert!(&v0 == &v1, 5);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Panzerdog"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Equipment"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Cyberpill"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"TankPart"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Merch"));
        assert!(0x1::vector::contains<0x1::string::String>(&v2, &arg9), 6);
        if (arg9 == 0x1::string::utf8(b"Panzerdog")) {
            let v4 = 0x1::vector::length<0x1::string::String>(&arg10);
            let v5 = 4;
            assert!(&v4 == &v5, 2);
        } else if (arg9 == 0x1::string::utf8(b"Cyberpill")) {
            let v6 = 0x1::vector::length<0x1::string::String>(&arg10);
            let v7 = 0;
            assert!(&v6 == &v7, 2);
        } else if (arg9 == 0x1::string::utf8(b"TankPart") || arg9 == 0x1::string::utf8(b"Equipment")) {
            let v8 = 0x1::vector::length<0x1::string::String>(&arg10);
            let v9 = 5;
            assert!(&v8 == &v9, 2);
        } else if (arg9 == 0x1::string::utf8(b"Merch")) {
            let v10 = 0x1::vector::length<0x1::string::String>(&arg10);
            let v11 = 3;
            assert!(&v10 == &v11, 2);
        };
        let v12 = 0;
        let v13 = 0x1::vector::empty<RoyaltyCollector>();
        while (v12 < 0x1::vector::length<address>(&arg5)) {
            let v14 = RoyaltyCollector{
                collector : *0x1::vector::borrow<address>(&arg5, v12),
                amountBP  : *0x1::vector::borrow<u64>(&arg6, v12),
            };
            0x1::vector::push_back<RoyaltyCollector>(&mut v13, v14);
            v12 = v12 + 1;
        };
        let v15 = ProductArguments{
            objectType : arg9,
            args       : arg10,
        };
        let v16 = Product{
            id               : 0x2::object::new(arg11),
            name             : arg2,
            priceSui         : arg3,
            priceKoban       : arg4,
            royalties        : v13,
            limit            : arg7,
            purchases        : 0,
            whitelist        : arg8,
            productArguments : v15,
        };
        0x1::vector::push_back<Product>(&mut arg1.products, v16);
    }

    public entry fun create_shop(arg0: &PanzerShopAuth, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = PanzerShop{
            id       : 0x2::object::new(arg2),
            name     : arg1,
            products : 0x1::vector::empty<Product>(),
        };
        0x2::transfer::public_share_object<PanzerShop>(v0);
    }

    fun init(arg0: PANZERSHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PanzerShopAuth{
            id          : 0x2::object::new(arg1),
            description : 0x1::string::utf8(b"Master PanzerShop Authority"),
        };
        0x2::transfer::public_transfer<PanzerShopAuth>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<PANZERSHOP>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun purchase_product_sui(arg0: &mut PanzerShop, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow_mut<Product>(&mut arg0.products, arg1);
        assert!(v0.priceSui > 0, 9);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == v0.priceSui, 8);
        assert!(v0.purchases < v0.limit, 11);
        if (0x1::vector::length<address>(&v0.whitelist) > 0) {
            let v1 = 0x2::tx_context::sender(arg3);
            assert!(0x1::vector::contains<address>(&v0.whitelist, &v1), 10);
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<RoyaltyCollector>(&v0.royalties)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, 0x1::vector::borrow<RoyaltyCollector>(&v0.royalties, v2).amountBP / 1000 * v0.priceSui, arg3), 0x1::vector::borrow<RoyaltyCollector>(&v0.royalties, v2).collector);
            v2 = v2 + 1;
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, @0xc35b2c18b56cbbccb0fc44f001bedab05ffc53261ac8bb9fac23b1b06d910ad);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        let v3 = &v0.productArguments;
        if (v3.objectType == 0x1::string::utf8(b"Panzerdog")) {
            0x524ac2292d0862f294f1c4973b7d83b008e40e22c333156bc9747626053293f6::panzerdogs::mint_to_address_pkg(*0x1::vector::borrow<0x1::string::String>(&v3.args, 0), *0x1::vector::borrow<0x1::string::String>(&v3.args, 1), *0x1::vector::borrow<0x1::string::String>(&v3.args, 2), *0x1::vector::borrow<0x1::string::String>(&v3.args, 3), 1, 0x2::tx_context::sender(arg3), arg3);
        } else if (v3.objectType == 0x1::string::utf8(b"Equipment")) {
            0x524ac2292d0862f294f1c4973b7d83b008e40e22c333156bc9747626053293f6::equipment::mint_to_address_pkg(*0x1::vector::borrow<0x1::string::String>(&v3.args, 0), *0x1::vector::borrow<0x1::string::String>(&v3.args, 1), *0x1::vector::borrow<0x1::string::String>(&v3.args, 2), *0x1::vector::borrow<0x1::string::String>(&v3.args, 3), *0x1::vector::borrow<0x1::string::String>(&v3.args, 4), 0x2::tx_context::sender(arg3), arg3);
        } else if (v3.objectType == 0x1::string::utf8(b"Cyberpill")) {
            0x524ac2292d0862f294f1c4973b7d83b008e40e22c333156bc9747626053293f6::cyberpills::mint_to_address_pkg(1, 0x2::tx_context::sender(arg3), arg3);
        } else if (v3.objectType == 0x1::string::utf8(b"TankPart")) {
            0x524ac2292d0862f294f1c4973b7d83b008e40e22c333156bc9747626053293f6::tankparts::mint_to_address_pkg(*0x1::vector::borrow<0x1::string::String>(&v3.args, 0), *0x1::vector::borrow<0x1::string::String>(&v3.args, 1), *0x1::vector::borrow<0x1::string::String>(&v3.args, 2), *0x1::vector::borrow<0x1::string::String>(&v3.args, 3), *0x1::vector::borrow<0x1::string::String>(&v3.args, 4), 1, 0x2::tx_context::sender(arg3), arg3);
        } else if (v3.objectType == 0x1::string::utf8(b"Merch")) {
            0x524ac2292d0862f294f1c4973b7d83b008e40e22c333156bc9747626053293f6::merch::mint_to_address_pkg(*0x1::vector::borrow<0x1::string::String>(&v3.args, 0), *0x1::vector::borrow<0x1::string::String>(&v3.args, 1), *0x1::vector::borrow<0x1::string::String>(&v3.args, 2), 0x2::tx_context::sender(arg3), arg3);
        };
        v0.purchases = v0.purchases + 1;
        let v4 = ProductPurchasedEvent{
            productId : 0x2::object::id<Product>(v0),
            sender    : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ProductPurchasedEvent>(v4);
    }

    public entry fun remove_product(arg0: &PanzerShopAuth, arg1: &mut PanzerShop, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 < 0x1::vector::length<Product>(&arg1.products), 7);
        let Product {
            id               : v0,
            name             : _,
            priceSui         : _,
            priceKoban       : _,
            royalties        : _,
            limit            : _,
            purchases        : _,
            whitelist        : _,
            productArguments : _,
        } = 0x1::vector::remove<Product>(&mut arg1.products, arg2);
        0x2::object::delete(v0);
    }

    public entry fun shop_auth_to_address(arg0: &0x2::package::Publisher, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<PanzerShop>(arg0), 1);
        let v0 = PanzerShopAuth{
            id          : 0x2::object::new(arg2),
            description : 0x1::string::utf8(b"PanzerShop Authority"),
        };
        0x2::transfer::public_transfer<PanzerShopAuth>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

