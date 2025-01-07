module 0x6e4273b7b260377c5e3e61752a1bf99deb3195805ab6c2b3c7ae5a79164e476d::deepbook_utils {
    fun get_market_price_ask<T0, T1>(arg0: &0xdee9::clob_v2::Pool<T0, T1>) : u64 {
        let (_, v1) = 0xdee9::clob_v2::get_market_price<T0, T1>(arg0);
        let v2 = v1;
        0x1::option::extract<u64>(&mut v2)
    }

    fun get_market_price_bid<T0, T1>(arg0: &0xdee9::clob_v2::Pool<T0, T1>) : u64 {
        let (v0, _) = 0xdee9::clob_v2::get_market_price<T0, T1>(arg0);
        let v2 = v0;
        0x1::option::extract<u64>(&mut v2)
    }

    public fun place_limit_order_ask<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::coin::Coin<T0>, arg6: &mut 0xdee9::custodian_v2::AccountCap, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1 - arg1 % arg4;
        assert!(v0 > 0, 0);
        let (v1, _, _, _) = 0xdee9::clob_v2::account_balance<T0, T1>(arg0, arg6);
        assert!(v1 + 0x2::coin::value<T0>(arg5) >= v0, 1);
        if (v1 >= v0) {
            let (_, _, _, _) = 0xdee9::clob_v2::place_limit_order<T0, T1>(arg0, 20082022, arg2 - arg2 % arg3, v0, 0, false, 0x2::clock::timestamp_ms(arg7) + 864000000, 0, arg7, arg6, arg8);
        } else {
            if (v1 > 0) {
                0x2::coin::join<T0>(arg5, 0xdee9::clob_v2::withdraw_base<T0, T1>(arg0, v1, arg6, arg8));
            };
            0xdee9::clob_v2::deposit_base<T0, T1>(arg0, 0x2::coin::split<T0>(arg5, v0, arg8), arg6);
            let (_, _, _, _) = 0xdee9::clob_v2::place_limit_order<T0, T1>(arg0, 20082022, arg2 - arg2 % arg3, v0, 0, false, 0x2::clock::timestamp_ms(arg7) + 864000000, 0, arg7, arg6, arg8);
        };
    }

    public fun place_limit_order_bid<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::coin::Coin<T1>, arg9: &mut 0xdee9::custodian_v2::AccountCap, arg10: 0x2::coin::Coin<T1>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0xdee9::clob_v2::deposit_quote<T0, T1>(arg0, arg10, arg9);
        let v0 = arg1 - arg1 % arg4;
        let v1 = arg2 - arg2 % arg3;
        let v2 = ((((((v0 as u128) * (arg6 as u128) / (arg5 as u128)) as u64) as u128) * (v1 as u128) / (arg7 as u128)) as u64);
        assert!(v2 > 0, 0);
        let (_, _, v5, _) = 0xdee9::clob_v2::account_balance<T0, T1>(arg0, arg9);
        assert!(v5 + 0x2::coin::value<T1>(arg8) >= v2, 0);
        if (v5 >= v2) {
            let (_, _, _, _) = 0xdee9::clob_v2::place_limit_order<T0, T1>(arg0, 20082022, v1, v0, 0, true, 0x2::clock::timestamp_ms(arg11) + 864000000, 0, arg11, arg9, arg12);
        } else {
            0xdee9::clob_v2::deposit_quote<T0, T1>(arg0, 0x2::coin::split<T1>(arg8, v2 - v5, arg12), arg9);
            let (_, _, _, _) = 0xdee9::clob_v2::place_limit_order<T0, T1>(arg0, 20082022, v1, v0, 0, true, 0x2::clock::timestamp_ms(arg11) + 864000000, 0, arg11, arg9, arg12);
        };
    }

    public fun place_market_order_ask<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::coin::Coin<T0>, arg5: &mut 0xdee9::custodian_v2::AccountCap, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = arg1 - arg1 % arg3;
        assert!(v0 > 0, 0);
        let (v1, _, _, _) = 0xdee9::clob_v2::account_balance<T0, T1>(arg0, arg5);
        assert!(v1 + 0x2::coin::value<T0>(arg4) >= v0, 1);
        if (v1 >= v0) {
            let (v5, v6, _) = 0xdee9::clob_v2::swap_exact_base_for_quote<T0, T1>(arg0, 20082022, arg5, v0, 0xdee9::clob_v2::withdraw_base<T0, T1>(arg0, v0, arg5, arg7), 0x2::coin::zero<T1>(arg7), arg6, arg7);
            return (v5, v6)
        };
        if (v1 > 0) {
            0x2::coin::join<T0>(arg4, 0xdee9::clob_v2::withdraw_base<T0, T1>(arg0, v1, arg5, arg7));
        };
        let (v8, v9, _) = 0xdee9::clob_v2::swap_exact_base_for_quote<T0, T1>(arg0, 20082022, arg5, v0, 0x2::coin::split<T0>(arg4, v0, arg7), 0x2::coin::zero<T1>(arg7), arg6, arg7);
        (v8, v9)
    }

    public fun place_market_order_bid<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::coin::Coin<T1>, arg8: 0x2::coin::Coin<T1>, arg9: &mut 0xdee9::custodian_v2::AccountCap, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = ((((arg1 - arg1 % arg3) as u128) * (get_market_price_bid<T0, T1>(arg0) as u128) * (arg5 as u128) / (arg6 as u128) * (arg4 as u128)) as u64);
        assert!(v0 > 0, 0);
        let (_, _, v3, _) = 0xdee9::clob_v2::account_balance<T0, T1>(arg0, arg9);
        assert!(v3 + 0x2::coin::value<T1>(arg7) >= v0, 1);
        if (v3 >= v0) {
            let v5 = 0xdee9::clob_v2::withdraw_quote<T0, T1>(arg0, v0, arg9, arg11);
            0x2::coin::join<T1>(&mut v5, arg8);
            let (v6, v7, _) = 0xdee9::clob_v2::swap_exact_quote_for_base<T0, T1>(arg0, 20082022, arg9, v0, arg10, v5, arg11);
            return (v6, v7)
        };
        if (v3 > 0) {
            0x2::coin::join<T1>(arg7, 0xdee9::clob_v2::withdraw_quote<T0, T1>(arg0, v3, arg9, arg11));
        };
        let v9 = 0x2::coin::split<T1>(arg7, v0, arg11);
        0x2::coin::join<T1>(&mut v9, arg8);
        let (v10, v11, _) = 0xdee9::clob_v2::swap_exact_quote_for_base<T0, T1>(arg0, 20082022, arg9, v0, arg10, v9, arg11);
        (v10, v11)
    }

    // decompiled from Move bytecode v6
}

