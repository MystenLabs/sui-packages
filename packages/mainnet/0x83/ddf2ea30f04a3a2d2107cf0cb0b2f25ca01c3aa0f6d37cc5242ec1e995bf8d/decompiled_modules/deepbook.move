module 0x83ddf2ea30f04a3a2d2107cf0cb0b2f25ca01c3aa0f6d37cc5242ec1e995bf8d::deepbook {
    public fun get_level2_book_status<T0, T1>(arg0: &0xdee9::clob_v2::Pool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : (vector<u64>, vector<u64>, vector<u64>, vector<u64>) {
        let (v0, v1) = 0xdee9::clob_v2::get_market_price<T0, T1>(arg0);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = if (!0x1::option::is_none<u64>(&v3)) {
            let v6 = *0x1::option::borrow<u64>(&v3);
            let v7 = if (v6 - 0 > arg1) {
                v6 - arg1
            } else {
                0
            };
            (v7, v6)
        } else {
            (0, 0)
        };
        let (v8, v9) = if (!0x1::option::is_none<u64>(&v2)) {
            let v10 = *0x1::option::borrow<u64>(&v2);
            let v11 = if (9223372036854775808 - v10 > arg1) {
                v10 + arg1
            } else {
                9223372036854775808
            };
            (v10, v11)
        } else {
            (9223372036854775808, 9223372036854775808)
        };
        let (v12, v13) = 0xdee9::clob_v2::get_level2_book_status_bid_side<T0, T1>(arg0, v4, v5, arg2);
        let (v14, v15) = 0xdee9::clob_v2::get_level2_book_status_ask_side<T0, T1>(arg0, v8, v9, arg2);
        (v12, v13, v14, v15)
    }

    public fun swap_x2y<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0xdee9::clob_v2::create_account(arg3);
        let (v1, v2) = 0xdee9::clob_v2::place_market_order<T0, T1>(arg1, &v0, 0, 0x2::coin::value<T0>(&arg0), false, arg0, 0x2::coin::zero<T1>(arg3), arg2, arg3);
        0xdee9::custodian_v2::delete_account_cap(v0);
        (v1, v2)
    }

    public fun swap_y2x<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0xdee9::clob_v2::create_account(arg3);
        let (v1, v2) = 0xdee9::clob_v2::place_market_order<T0, T1>(arg1, &v0, 0, 0x2::coin::value<T1>(&arg0), true, 0x2::coin::zero<T0>(arg3), arg0, arg2, arg3);
        0xdee9::custodian_v2::delete_account_cap(v0);
        (v1, v2)
    }

    // decompiled from Move bytecode v6
}

