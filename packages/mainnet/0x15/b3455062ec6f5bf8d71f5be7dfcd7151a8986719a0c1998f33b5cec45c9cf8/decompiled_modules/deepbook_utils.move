module 0x15b3455062ec6f5bf8d71f5be7dfcd7151a8986719a0c1998f33b5cec45c9cf8::deepbook_utils {
    public fun place_limit_order_ask<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::coin::Coin<T0>, arg6: &mut 0xdee9::custodian_v2::AccountCap, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1 - arg1 % arg4;
        assert!(v0 > 0, 0);
        let (_, _, v3, _) = 0xdee9::clob_v2::account_balance<T0, T1>(arg0, arg6);
        assert!(v3 + 0x2::coin::value<T0>(arg5) >= v0, 0);
        if (v3 >= v0) {
            let (_, _, _, _) = 0xdee9::clob_v2::place_limit_order<T0, T1>(arg0, 20082022, arg2 - arg2 % arg3, v0, 0, false, 0x2::clock::timestamp_ms(arg7) + 864000000, 0, arg7, arg6, arg8);
        } else {
            0xdee9::clob_v2::deposit_base<T0, T1>(arg0, 0x2::coin::split<T0>(arg5, v0, arg8), arg6);
            let (_, _, _, _) = 0xdee9::clob_v2::place_limit_order<T0, T1>(arg0, 20082022, arg2 - arg2 % arg3, v0, 0, true, 0x2::clock::timestamp_ms(arg7) + 864000000, 0, arg7, arg6, arg8);
        };
    }

    public fun place_limit_order_bid<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::coin::Coin<T1>, arg6: &mut 0xdee9::custodian_v2::AccountCap, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1 - arg1 % arg4;
        let v1 = arg2 - arg2 % arg3;
        let v2 = v0 * v1;
        assert!(v2 > 0, 0);
        let (_, _, v5, _) = 0xdee9::clob_v2::account_balance<T0, T1>(arg0, arg6);
        assert!(v5 + 0x2::coin::value<T1>(arg5) >= v2, 0);
        if (v5 >= v2) {
            let (_, _, _, _) = 0xdee9::clob_v2::place_limit_order<T0, T1>(arg0, 20082022, v1, v0, 0, true, 0x2::clock::timestamp_ms(arg7) + 864000000, 0, arg7, arg6, arg8);
        } else {
            0xdee9::clob_v2::deposit_quote<T0, T1>(arg0, 0x2::coin::split<T1>(arg5, v2 - v5, arg8), arg6);
            let (_, _, _, _) = 0xdee9::clob_v2::place_limit_order<T0, T1>(arg0, 20082022, v1, v0, 0, true, 0x2::clock::timestamp_ms(arg7) + 864000000, 0, arg7, arg6, arg8);
        };
    }

    public fun place_market_order_ask<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::coin::Coin<T0>, arg6: &mut 0xdee9::custodian_v2::AccountCap, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = arg1 - arg1 % arg4;
        assert!(v0 > 0, 0);
        let (v1, _, _, _) = 0xdee9::clob_v2::account_balance<T0, T1>(arg0, arg6);
        assert!(v1 + 0x2::coin::value<T0>(arg5) >= v0, 0);
        if (v1 >= v0) {
            let (v5, v6, _) = 0xdee9::clob_v2::swap_exact_base_for_quote<T0, T1>(arg0, 20082022, arg6, v0, 0xdee9::clob_v2::withdraw_base<T0, T1>(arg0, v0, arg6, arg8), 0x2::coin::zero<T1>(arg8), arg7, arg8);
            return (v5, v6)
        };
        if (v1 > 0) {
            0x2::coin::join<T0>(arg5, 0xdee9::clob_v2::withdraw_base<T0, T1>(arg0, v1, arg6, arg8));
        };
        let (v8, v9, _) = 0xdee9::clob_v2::swap_exact_base_for_quote<T0, T1>(arg0, 20082022, arg6, v0, 0x2::coin::split<T0>(arg5, v0, arg8), 0x2::coin::zero<T1>(arg8), arg7, arg8);
        (v8, v9)
    }

    public fun place_market_order_bid<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::coin::Coin<T1>, arg6: &mut 0xdee9::custodian_v2::AccountCap, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = arg1 - arg1 % arg4;
        let v1 = v0 * (arg2 - arg2 % arg3);
        assert!(v1 > 0, 0);
        let (_, _, v4, _) = 0xdee9::clob_v2::account_balance<T0, T1>(arg0, arg6);
        assert!(v4 + 0x2::coin::value<T1>(arg5) >= v1, 0);
        if (v4 >= v1) {
            let (v6, v7, _) = 0xdee9::clob_v2::swap_exact_quote_for_base<T0, T1>(arg0, 20082022, arg6, v0, arg7, 0xdee9::clob_v2::withdraw_quote<T0, T1>(arg0, v1, arg6, arg8), arg8);
            return (v6, v7)
        };
        if (v4 > 0) {
            0x2::coin::join<T1>(arg5, 0xdee9::clob_v2::withdraw_quote<T0, T1>(arg0, v4, arg6, arg8));
        };
        let (v9, v10, _) = 0xdee9::clob_v2::swap_exact_quote_for_base<T0, T1>(arg0, 20082022, arg6, v0, arg7, 0x2::coin::split<T1>(arg5, v0, arg8), arg8);
        (v9, v10)
    }

    // decompiled from Move bytecode v6
}

