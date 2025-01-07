module 0xdf405c7fb5f345e94365e56baecd8c97762673838f7ad16413a60e0588ea0455::market_maker {
    fun place_limit_order<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: &0xdee9::custodian_v2::AccountCap, arg2: bool, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, _) = 0xdee9::clob_v2::place_limit_order<T0, T1>(arg0, 201314, arg3, arg4, 0, arg2, 0x2::clock::timestamp_ms(arg5) + 3600000, 0, arg5, arg1, arg6);
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun place_optimal_order<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: &0xdee9::custodian_v2::AccountCap, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, _, v2, _) = 0xdee9::clob_v2::account_balance<T0, T1>(arg0, arg1);
        let (v4, v5) = 0xdee9::clob_v2::get_market_price<T0, T1>(arg0);
        let v6 = v5;
        let v7 = v4;
        assert!(0x1::option::is_some<u64>(&v7) && 0x1::option::is_some<u64>(&v6), 404);
        let v8 = 0x1::option::destroy_some<u64>(v7);
        let v9 = 0x1::option::destroy_some<u64>(v6);
        let v10 = 0xdee9::clob_v2::tick_size<T0, T1>(arg0);
        assert!(v9 - v8 > v10, 408);
        if (arg2) {
            let v11 = v8 + v10;
            let v12 = mul_div(v2, 1000000000, v11) - 100;
            if (v12 / arg3 > 0) {
                place_limit_order<T0, T1>(arg0, arg1, true, v11, v12 / arg3 * arg3, arg4, arg5);
            };
        } else if (v0 / arg3 > 0) {
            place_limit_order<T0, T1>(arg0, arg1, false, v9 - v10, v0 / arg3 * arg3, arg4, arg5);
        };
    }

    public fun place_optimal_order_ask<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0xdee9::custodian_v2::AccountCap {
        let v0 = 0xdee9::clob_v2::create_account(arg4);
        0xdee9::clob_v2::deposit_base<T0, T1>(arg0, arg1, &v0);
        place_optimal_order<T0, T1>(arg0, &v0, false, arg2, arg3, arg4);
        v0
    }

    public fun place_optimal_order_bid<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0xdee9::custodian_v2::AccountCap {
        let v0 = 0xdee9::clob_v2::create_account(arg4);
        0xdee9::clob_v2::deposit_quote<T0, T1>(arg0, arg1, &v0);
        place_optimal_order<T0, T1>(arg0, &v0, true, arg2, arg3, arg4);
        v0
    }

    // decompiled from Move bytecode v6
}

