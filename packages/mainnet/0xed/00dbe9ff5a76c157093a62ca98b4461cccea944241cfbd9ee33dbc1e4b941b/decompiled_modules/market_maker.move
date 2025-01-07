module 0xed00dbe9ff5a76c157093a62ca98b4461cccea944241cfbd9ee33dbc1e4b941b::market_maker {
    fun place_limit_order<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: &0xdee9::custodian_v2::AccountCap, arg2: bool, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, _) = 0xdee9::clob_v2::place_limit_order<T0, T1>(arg0, 201314, arg3, arg4, 0, arg2, 0x2::clock::timestamp_ms(arg5) + 3600000, 0, arg5, arg1, arg6);
    }

    public fun bootstrap<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0xdee9::custodian_v2::AccountCap {
        let v0 = 0xdee9::clob_v2::create_account(arg5);
        0xdee9::clob_v2::deposit_base<T0, T1>(arg0, arg1, &v0);
        0xdee9::clob_v2::deposit_quote<T0, T1>(arg0, arg2, &v0);
        make_market<T0, T1>(arg0, arg3, &v0, arg4, arg5);
        v0
    }

    fun cancel_far_orders<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: &0xdee9::custodian_v2::AccountCap, arg2: u64, arg3: u64) {
        let v0 = 0xdee9::clob_v2::list_open_orders<T0, T1>(arg0, arg1);
        let v1 = 0;
        let v2 = 0x1::vector::empty<u64>();
        while (v1 < 0x1::vector::length<0xdee9::clob_v2::Order>(&v0)) {
            let v3 = 0x1::vector::pop_back<0xdee9::clob_v2::Order>(&mut v0);
            let v4 = 0xdee9::clob_v2::tick_level(&v3);
            let v5 = 0xdee9::clob_v2::order_id(&v3);
            let v6 = order_is_bid(v5);
            if (v6 && v4 < arg3) {
                0x1::vector::push_back<u64>(&mut v2, v5);
            } else if (!v6 && v4 > arg2) {
                0x1::vector::push_back<u64>(&mut v2, v5);
            };
            v1 = v1 + 1;
        };
        if (0x1::vector::length<u64>(&v2) > 0) {
            0xdee9::clob_v2::batch_cancel_order<T0, T1>(arg0, v2, arg1);
        };
    }

    public entry fun make_market<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: u64, arg2: &0xdee9::custodian_v2::AccountCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xdee9::clob_v2::get_market_price<T0, T1>(arg0);
        let v2 = v1;
        let v3 = v0;
        assert!(0x1::option::is_some<u64>(&v3) && 0x1::option::is_some<u64>(&v2), 404);
        let v4 = 0x1::option::destroy_some<u64>(v3);
        let v5 = 0x1::option::destroy_some<u64>(v2);
        let v6 = 0xdee9::clob_v2::tick_size<T0, T1>(arg0);
        let (v7, v8) = if (v5 - v4 <= v6) {
            (v5, v4)
        } else if (v5 - v4 > v6 * 2) {
            (v5 - v6, v4 + v6)
        } else {
            (v5 - v6, v4)
        };
        cancel_far_orders<T0, T1>(arg0, arg2, v7, v8);
        place_optimal_orders<T0, T1>(arg0, arg2, v7, v8, arg1, arg3, arg4);
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    fun order_is_bid(arg0: u64) : bool {
        arg0 < 9223372036854775808
    }

    fun place_optimal_orders<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: &0xdee9::custodian_v2::AccountCap, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, _, v2, _) = 0xdee9::clob_v2::account_balance<T0, T1>(arg0, arg1);
        if (v0 / arg4 > 0) {
            place_limit_order<T0, T1>(arg0, arg1, false, arg2, v0 / arg4 * arg4, arg5, arg6);
        };
        let v4 = mul_div(v2, 1000000000, arg3) - 100;
        if (v4 / arg4 > 0) {
            place_limit_order<T0, T1>(arg0, arg1, true, arg3, v4 / arg4 * arg4, arg5, arg6);
        };
    }

    // decompiled from Move bytecode v6
}

