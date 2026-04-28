module 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_purchase {
    struct StoreFeeKey has copy, drop, store {
        dummy_field: bool,
    }

    struct StoreFeeConfig has store {
        platform_fee_rate: u64,
    }

    struct ProductPurchased has copy, drop {
        purchase_id: 0x2::object::ID,
        voucher_id: 0x2::object::ID,
        buyer: address,
        store_id: 0x2::object::ID,
        game_id: 0x2::object::ID,
        product_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        price_paid: u64,
        platform_fee: u64,
        game_company_revenue: u64,
    }

    struct StoreFeeConfigSet has copy, drop {
        store_id: 0x2::object::ID,
        platform_fee_rate: u64,
    }

    struct ProductPurchasedWithPoint has copy, drop {
        purchase_id: 0x2::object::ID,
        voucher_id: 0x2::object::ID,
        buyer: address,
        store_id: 0x2::object::ID,
        game_id: 0x2::object::ID,
        product_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        price: u64,
        points_used: u64,
        discount_token: u64,
        coin_paid: u64,
        platform_fee: u64,
        game_company_revenue: u64,
        payback_points: u64,
    }

    public fun calculate_game_company_revenue(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store::Store, arg1: u64) : u64 {
        arg1 - calculate_platform_fee(arg0, arg1)
    }

    public fun calculate_platform_fee(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store::Store, arg1: u64) : u64 {
        arg1 * get_store_fee_rate(arg0) / 10000
    }

    public fun get_store_fee_rate(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store::Store) : u64 {
        let v0 = 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store::store_uid(arg0);
        let v1 = StoreFeeKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<StoreFeeKey>(v0, v1)) {
            let v3 = StoreFeeKey{dummy_field: false};
            0x2::dynamic_field::borrow<StoreFeeKey, StoreFeeConfig>(v0, v3).platform_fee_rate
        } else {
            500
        }
    }

    public fun purchase_product<T0>(arg0: &mut 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::fee_manager::FeeManager, arg1: &mut 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store::Store, arg2: &mut 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_game::Game, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<T0>, arg5: vector<u8>, arg6: 0x1::string::String, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store::is_store_active(arg1), 4);
        assert!(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_game::is_game_active(arg2), 3);
        0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_game::validate_game_store(arg2, arg1);
        assert!(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_product::is_product_active(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_product::borrow_product_mut(arg2, arg3)), 2);
        let v0 = 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_product::get_product_price<T0>(arg2, arg3);
        assert!(0x2::coin::value<T0>(&arg4) >= v0, 1);
        let v1 = v0 * get_store_fee_rate(arg1) / 10000;
        let v2 = v0 - v1;
        let v3 = 0x2::coin::into_balance<T0>(arg4);
        if (v1 > 0) {
            0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::fee_manager::deposit_service_fee_by_coin_type<T0>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v3, v1), arg8), arg8);
        };
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v3, v2), arg8), 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store::store_game_company(arg1));
        };
        if (0x2::balance::value<T0>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg8), 0x2::tx_context::sender(arg8));
        } else {
            0x2::balance::destroy_zero<T0>(v3);
        };
        0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_product::increment_product_supply(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_product::borrow_product_mut(arg2, arg3));
        let v4 = 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_product::borrow_product(arg2, arg3);
        let v5 = 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_product::get_product_current_supply(v4);
        0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store::increment_store_sales(arg1);
        0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_game::increment_game_sales(arg2);
        let v6 = 0x2::object::new(arg8);
        0x2::object::delete(v6);
        let v7 = 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store::store_id(arg1);
        let v8 = 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_game::game_id(arg2);
        let v9 = 0x2::tx_context::sender(arg8);
        let v10 = 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::product_voucher::mint_product_voucher(v7, v8, arg3, v5, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_product::get_product_name(v4), arg5, arg6, v9, arg7, arg8);
        let v11 = ProductPurchased{
            purchase_id          : 0x2::object::uid_to_inner(&v6),
            voucher_id           : v10,
            buyer                : v9,
            store_id             : v7,
            game_id              : v8,
            product_id           : arg3,
            coin_type            : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            price_paid           : v0,
            platform_fee         : v1,
            game_company_revenue : v2,
        };
        0x2::event::emit<ProductPurchased>(v11);
        v10
    }

    public fun purchase_product_with_points<T0>(arg0: &mut 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::fee_manager::FeeManager, arg1: &mut 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store::Store, arg2: &mut 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_game::Game, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<T0>, arg5: 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::point::PointReceipt, arg6: &mut 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::point::PointWallet, arg7: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::point::PointConfig, arg8: vector<u8>, arg9: 0x1::string::String, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = get_store_fee_rate(arg1);
        purchase_product_with_points_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, v0, arg10, arg11)
    }

    public fun purchase_product_with_points_dynamic_fee<T0>(arg0: &mut 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::fee_manager::FeeManager, arg1: &mut 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store::Store, arg2: &mut 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_game::Game, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<T0>, arg5: 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::point::PointReceipt, arg6: &mut 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::point::PointWallet, arg7: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::point::PointConfig, arg8: vector<u8>, arg9: 0x1::string::String, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg10 <= 1000, 9);
        purchase_product_with_points_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    }

    fun purchase_product_with_points_internal<T0>(arg0: &mut 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::fee_manager::FeeManager, arg1: &mut 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store::Store, arg2: &mut 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_game::Game, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<T0>, arg5: 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::point::PointReceipt, arg6: &mut 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::point::PointWallet, arg7: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::point::PointConfig, arg8: vector<u8>, arg9: 0x1::string::String, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store::is_store_active(arg1), 4);
        assert!(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_game::is_game_active(arg2), 3);
        0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_game::validate_game_store(arg2, arg1);
        assert!(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_product::is_product_active(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_product::borrow_product_mut(arg2, arg3)), 2);
        assert!(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::point::receipt_coin_type(&arg5) == 0x1::type_name::with_defining_ids<T0>(), 7);
        let v0 = 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_product::get_product_price<T0>(arg2, arg3);
        assert!(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::point::receipt_product_price(&arg5) == v0, 8);
        let v1 = 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::point::receipt_discount_token(&arg5);
        let v2 = 0;
        if (v1 < v0) {
            v2 = v0 - v1;
        };
        assert!(0x2::coin::value<T0>(&arg4) >= v2, 1);
        let v3 = v2 * arg10 / 10000;
        let v4 = v2 - v3;
        let v5 = 0x2::coin::into_balance<T0>(arg4);
        if (v3 > 0) {
            0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::fee_manager::deposit_service_fee_by_coin_type<T0>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v5, v3), arg12), arg12);
        };
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v5, v4), arg12), 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store::store_game_company(arg1));
        };
        if (0x2::balance::value<T0>(&v5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg12), 0x2::tx_context::sender(arg12));
        } else {
            0x2::balance::destroy_zero<T0>(v5);
        };
        0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::point::finalize_receipt(arg6, arg5, arg7, arg11);
        0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_product::increment_product_supply(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_product::borrow_product_mut(arg2, arg3));
        let v6 = 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_product::borrow_product(arg2, arg3);
        let v7 = 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_product::get_product_current_supply(v6);
        0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store::increment_store_sales(arg1);
        0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_game::increment_game_sales(arg2);
        let v8 = 0x2::object::new(arg12);
        0x2::object::delete(v8);
        let v9 = 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store::store_id(arg1);
        let v10 = 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_game::game_id(arg2);
        let v11 = 0x2::tx_context::sender(arg12);
        let v12 = 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::product_voucher::mint_product_voucher(v9, v10, arg3, v7, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_product::get_product_name(v6), arg8, arg9, v11, arg11, arg12);
        let v13 = ProductPurchasedWithPoint{
            purchase_id          : 0x2::object::uid_to_inner(&v8),
            voucher_id           : v12,
            buyer                : v11,
            store_id             : v9,
            game_id              : v10,
            product_id           : arg3,
            coin_type            : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            price                : v0,
            points_used          : 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::point::receipt_points(&arg5),
            discount_token       : v1,
            coin_paid            : v2,
            platform_fee         : v3,
            game_company_revenue : v4,
            payback_points       : 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::point::receipt_payback_points(&arg5),
        };
        0x2::event::emit<ProductPurchasedWithPoint>(v13);
        v12
    }

    public fun set_store_fee_config(arg0: &mut 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store::Store, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        abort 6
    }

    public fun set_store_fee_config_by_factory(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::RoleManager, arg1: &mut 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store::Store, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, 0x2::tx_context::sender(arg3), 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::factory_role()), 6);
        assert!(arg2 <= 10000, 6);
        let v0 = StoreFeeConfig{platform_fee_rate: arg2};
        let v1 = 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store::store_uid_mut(arg1);
        let v2 = StoreFeeKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<StoreFeeKey>(v1, v2)) {
            let v3 = StoreFeeKey{dummy_field: false};
            let StoreFeeConfig {  } = 0x2::dynamic_field::remove<StoreFeeKey, StoreFeeConfig>(v1, v3);
        };
        let v4 = StoreFeeKey{dummy_field: false};
        0x2::dynamic_field::add<StoreFeeKey, StoreFeeConfig>(v1, v4, v0);
        let v5 = StoreFeeConfigSet{
            store_id          : 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store::store_id(arg1),
            platform_fee_rate : arg2,
        };
        0x2::event::emit<StoreFeeConfigSet>(v5);
    }

    // decompiled from Move bytecode v7
}

