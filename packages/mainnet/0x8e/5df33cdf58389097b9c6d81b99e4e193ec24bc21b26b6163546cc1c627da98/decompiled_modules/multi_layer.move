module 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::multi_layer {
    struct LayerOrderInfo has copy, drop {
        layer: u8,
        order_id: u128,
        price: u64,
        quantity: u64,
        filled_quantity: u64,
        expire_timestamp: u64,
        is_bid: bool,
    }

    fun find_layer_order(arg0: &vector<LayerOrderInfo>, arg1: u8, arg2: bool) : 0x1::option::Option<LayerOrderInfo> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<LayerOrderInfo>(arg0)) {
            let v1 = 0x1::vector::borrow<LayerOrderInfo>(arg0, v0);
            if (v1.layer == arg1 && v1.is_bid == arg2) {
                return 0x1::option::some<LayerOrderInfo>(*v1)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<LayerOrderInfo>()
    }

    fun get_orders_by_layer<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x2::clock::Clock) : vector<LayerOrderInfo> {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_account_order_details<T0, T1>(arg0, arg1);
        let v1 = 0x1::vector::empty<LayerOrderInfo>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(&v0)) {
            let v3 = 0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(&v0, v2);
            v2 = v2 + 1;
            if (0x2::clock::timestamp_ms(arg2) > 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::expire_timestamp(v3)) {
                continue
            };
            let v4 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(v3);
            let v5 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(v3);
            if (v4 >= v5) {
                continue
            };
            let (v6, v7, _) = 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::orderbook_analyzer::parse_order_id(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::order_id(v3));
            let v9 = LayerOrderInfo{
                layer            : ((0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::client_order_id(v3) & 15) as u8),
                order_id         : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::order_id(v3),
                price            : v7,
                quantity         : v5,
                filled_quantity  : v4,
                expire_timestamp : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::expire_timestamp(v3),
                is_bid           : v6,
            };
            0x1::vector::push_back<LayerOrderInfo>(&mut v1, v9);
        };
        v1
    }

    public(friend) fun process_layers<T0, T1, T2, T3>(arg0: &mut 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::mm_state::MMState, arg1: &0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::mm_registry::MMRegistry, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &vector<u64>, arg12: &vector<u64>, arg13: &vector<u64>, arg14: &vector<u64>, arg15: &vector<u64>, arg16: u64, arg17: u64, arg18: u64, arg19: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg20: &0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::config::MMConfig, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg3);
        let v1 = 0x1::vector::length<u64>(arg11);
        assert!(0x1::vector::length<u64>(arg12) == v1, 4);
        assert!(0x1::vector::length<u64>(arg13) == v1, 4);
        assert!(0x1::vector::length<u64>(arg14) == v1, 4);
        assert!(0x1::vector::length<u64>(arg15) == v1, 4);
        let v2 = 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::config::is_dry_run(arg20);
        let v3 = 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::config::enable_deep_payment(arg20);
        let v4 = get_orders_by_layer<T0, T1>(arg3, arg2, arg5);
        if (!v2 && 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::config::enable_deep_refill(arg20)) {
            let v5 = 0;
            let v6 = 0;
            while (v6 < v1) {
                let v7 = v5 + *0x1::vector::borrow<u64>(arg13, v6);
                v5 = v7 + *0x1::vector::borrow<u64>(arg14, v6);
                v6 = v6 + 1;
            };
            let (_, _) = 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::deep_manager::ensure_deep_balance<T0, T1, T2, T3>(arg3, arg4, arg2, arg19, v5, arg6, arg20, arg5, arg25);
        };
        let v10 = 0;
        while (v10 < v1) {
            let v11 = (v10 as u8);
            let v12 = 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::inv_sizing::apply_multiplier(*0x1::vector::borrow<u64>(arg13, v10), arg17, arg21, arg22);
            let v13 = 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::inv_sizing::apply_multiplier(*0x1::vector::borrow<u64>(arg14, v10), arg18, arg21, arg22);
            let v14 = *0x1::vector::borrow<u64>(arg15, v10);
            let v15 = v10 >= arg16;
            let v16 = arg9 >> 4 << 4 | v10;
            let v17 = arg6 * (100000 - *0x1::vector::borrow<u64>(arg11, v10)) / 100000;
            let v18 = arg6 * (100000 + *0x1::vector::borrow<u64>(arg12, v10)) / 100000;
            let v19 = v17;
            let v20 = v18;
            if (arg24 > 0 && v17 >= arg24) {
                v19 = arg24 * (100000 - arg7) / 100000;
            };
            if (arg23 > 0 && v18 <= arg23) {
                v20 = arg23 * (100000 + arg8) / 100000;
            };
            let v21 = 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::orders::round_bid_price(v19, arg21);
            let v22 = 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::orders::round_ask_price(v20, arg21);
            let v23 = if (v12 >= arg22) {
                if (v12 >= 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::config::min_order_size(arg20)) {
                    v21 >= 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::config::min_price(arg20)
                } else {
                    false
                }
            } else {
                false
            };
            let v24 = if (v13 >= arg22) {
                if (v13 >= 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::config::min_order_size(arg20)) {
                    v22 <= 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::config::max_price(arg20)
                } else {
                    false
                }
            } else {
                false
            };
            let v25 = find_layer_order(&v4, v11, true);
            let v26 = find_layer_order(&v4, v11, false);
            if (!v2) {
                if (v15) {
                    if (0x1::option::is_some<LayerOrderInfo>(&v25)) {
                        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg3, arg2, arg19, 0x1::option::borrow<LayerOrderInfo>(&v25).order_id, arg5, arg25);
                    };
                } else if (0x1::option::is_some<LayerOrderInfo>(&v25)) {
                    let v27 = 0x1::option::borrow<LayerOrderInfo>(&v25);
                    if (should_requote_price(v27.price, v21, v14) || should_refresh_order(v27.expire_timestamp, v0)) {
                        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg3, arg2, arg19, v27.order_id, arg5, arg25);
                        if (v23) {
                            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, arg19, v16, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v21, v12, true, v3, arg10, arg5, arg25);
                        };
                    };
                } else if (v23) {
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, arg19, v16, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v21, v12, true, v3, arg10, arg5, arg25);
                };
                if (v15) {
                    if (0x1::option::is_some<LayerOrderInfo>(&v26)) {
                        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg3, arg2, arg19, 0x1::option::borrow<LayerOrderInfo>(&v26).order_id, arg5, arg25);
                    };
                } else if (0x1::option::is_some<LayerOrderInfo>(&v26)) {
                    let v28 = 0x1::option::borrow<LayerOrderInfo>(&v26);
                    if (should_requote_price(v28.price, v22, v14) || should_refresh_order(v28.expire_timestamp, v0)) {
                        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg3, arg2, arg19, v28.order_id, arg5, arg25);
                        if (v24) {
                            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, arg19, v16, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v22, v13, false, v3, arg10, arg5, arg25);
                        };
                    };
                } else if (v24) {
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, arg19, v16, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v22, v13, false, v3, arg10, arg5, arg25);
                };
            };
            v10 = v10 + 1;
        };
        0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::mm_state::record_order_time(arg0, v0);
    }

    fun should_refresh_order(arg0: u64, arg1: u64) : bool {
        if (arg1 >= arg0) {
            return true
        };
        arg0 - arg1 <= 30000
    }

    fun should_requote_price(arg0: u64, arg1: u64, arg2: u64) : bool {
        if (arg0 == 0 || arg1 == 0) {
            return true
        };
        let v0 = if (arg0 >= arg1) {
            (arg0 - arg1) * 100000 / arg1
        } else {
            (arg1 - arg0) * 100000 / arg1
        };
        v0 > arg2
    }

    // decompiled from Move bytecode v6
}

