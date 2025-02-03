module 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router {
    fun check_amount_threshold(arg0: bool, arg1: bool, arg2: u64, arg3: u64, arg4: u64) {
        if (arg0) {
            if (arg1 && arg4 > arg3 || !arg1 && arg4 > arg2) {
                abort 4
            };
        } else if (arg1 && arg4 < arg2 || !arg1 && arg4 < arg3) {
            abort 5
        };
    }

    public entry fun swap_a_b<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: u64, arg4: u128, arg5: bool, arg6: address, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x2::tx_context::TxContext) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg9);
        assert!(0x2::clock::timestamp_ms(arg8) <= arg7, 2);
        let (v0, v1) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap<T0, T1, T2>(arg0, arg6, true, (arg2 as u128), arg5, arg4, arg8, arg10);
        let v2 = (v0 as u64);
        let v3 = (v1 as u64);
        check_amount_threshold(arg5, true, v2, v3, arg3);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap_coin_a_b<T0, T1, T2>(arg0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::merge_coin<T0>(arg1), v2, v3, arg6, arg10);
    }

    public entry fun swap_a_b_b_c<T0, T1, T2, T3, T4>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T2, T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T4, T3>, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: bool, arg8: address, arg9: u64, arg10: &0x2::clock::Clock, arg11: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg12: &mut 0x2::tx_context::TxContext) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg11);
        assert!(0x2::clock::timestamp_ms(arg10) <= arg9, 2);
        let (v0, v1, v2) = if (arg7) {
            let (v3, v4) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap<T0, T2, T1>(arg0, arg8, true, (arg3 as u128), arg7, arg5, arg10, arg12);
            let (v5, v6) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap<T2, T4, T3>(arg1, arg8, true, v4, arg7, arg6, arg10, arg12);
            assert!(v4 == v5, 6);
            let v7 = (v6 as u64);
            assert!(arg4 <= v7, 4);
            ((v3 as u64), (v4 as u64), v7)
        } else {
            let (v8, v9) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap<T2, T4, T3>(arg1, arg8, true, (arg3 as u128), arg7, arg6, arg10, arg12);
            let (v10, v11) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap<T0, T2, T1>(arg0, arg8, true, v8, arg7, arg5, arg10, arg12);
            assert!(v11 == v8, 6);
            let v12 = (v10 as u64);
            assert!(arg4 >= v12, 5);
            (v12, (v11 as u64), (v9 as u64))
        };
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap_coin_a_b_b_c<T0, T1, T2, T3, T4>(arg0, arg1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::merge_coin<T0>(arg2), v0, v1, v2, arg8, arg12);
    }

    public entry fun swap_a_b_c_b<T0, T1, T2, T3, T4>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T2, T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T4, T2, T3>, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: bool, arg8: address, arg9: u64, arg10: &0x2::clock::Clock, arg11: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg12: &mut 0x2::tx_context::TxContext) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg11);
        assert!(0x2::clock::timestamp_ms(arg10) <= arg9, 2);
        let (v0, v1, v2) = if (arg7) {
            let (v3, v4) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap<T0, T2, T1>(arg0, arg8, true, (arg3 as u128), arg7, arg5, arg10, arg12);
            let (v5, v6) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap<T4, T2, T3>(arg1, arg8, false, v4, arg7, arg6, arg10, arg12);
            assert!(v4 == v6, 6);
            let v7 = (v5 as u64);
            assert!(arg4 <= v7, 4);
            ((v3 as u64), (v4 as u64), v7)
        } else {
            let (v8, v9) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap<T4, T2, T3>(arg1, arg8, false, (arg3 as u128), arg7, arg6, arg10, arg12);
            let (v10, v11) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap<T0, T2, T1>(arg0, arg8, true, v9, arg7, arg5, arg10, arg12);
            assert!(v11 == v9, 6);
            let v12 = (v10 as u64);
            assert!(arg4 >= v12, 5);
            (v12, (v11 as u64), (v8 as u64))
        };
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap_coin_a_b_c_b<T0, T1, T2, T3, T4>(arg0, arg1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::merge_coin<T0>(arg2), v0, v1, v2, arg8, arg12);
    }

    public entry fun swap_b_a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: vector<0x2::coin::Coin<T1>>, arg2: u64, arg3: u64, arg4: u128, arg5: bool, arg6: address, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x2::tx_context::TxContext) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg9);
        assert!(0x2::clock::timestamp_ms(arg8) <= arg7, 2);
        let (v0, v1) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap<T0, T1, T2>(arg0, arg6, false, (arg2 as u128), arg5, arg4, arg8, arg10);
        let v2 = (v0 as u64);
        let v3 = (v1 as u64);
        check_amount_threshold(arg5, false, v2, v3, arg3);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap_coin_b_a<T0, T1, T2>(arg0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::merge_coin<T1>(arg1), v3, v2, arg6, arg10);
    }

    public entry fun swap_b_a_b_c<T0, T1, T2, T3, T4>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T0, T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T4, T3>, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: bool, arg8: address, arg9: u64, arg10: &0x2::clock::Clock, arg11: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg12: &mut 0x2::tx_context::TxContext) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg11);
        assert!(0x2::clock::timestamp_ms(arg10) <= arg9, 2);
        let (v0, v1, v2) = if (arg7) {
            let (v3, v4) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap<T2, T0, T1>(arg0, arg8, false, (arg3 as u128), arg7, arg5, arg10, arg12);
            let (v5, v6) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap<T2, T4, T3>(arg1, arg8, true, v3, arg7, arg6, arg10, arg12);
            assert!(v3 == v5, 6);
            let v7 = (v6 as u64);
            assert!(arg4 <= v7, 4);
            ((v4 as u64), (v3 as u64), v7)
        } else {
            let (v8, v9) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap<T2, T4, T3>(arg1, arg8, true, (arg3 as u128), arg7, arg6, arg10, arg12);
            let (v10, v11) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap<T2, T0, T1>(arg0, arg8, false, v8, arg7, arg5, arg10, arg12);
            assert!(v10 == v8, 6);
            let v12 = (v11 as u64);
            assert!(arg4 >= v12, 5);
            (v12, (v10 as u64), (v9 as u64))
        };
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap_coin_b_a_b_c<T0, T1, T2, T3, T4>(arg0, arg1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::merge_coin<T0>(arg2), v0, v1, v2, arg8, arg12);
    }

    public entry fun swap_b_a_c_b<T0, T1, T2, T3, T4>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T0, T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T4, T2, T3>, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: bool, arg8: address, arg9: u64, arg10: &0x2::clock::Clock, arg11: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg12: &mut 0x2::tx_context::TxContext) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg11);
        assert!(0x2::clock::timestamp_ms(arg10) <= arg9, 2);
        let (v0, v1, v2) = if (arg7) {
            let (v3, v4) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap<T2, T0, T1>(arg0, arg8, false, (arg3 as u128), arg7, arg5, arg10, arg12);
            let (v5, v6) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap<T4, T2, T3>(arg1, arg8, false, v3, arg7, arg6, arg10, arg12);
            assert!(v3 == v6, 6);
            let v7 = (v5 as u64);
            assert!(arg4 <= v7, 4);
            ((v4 as u64), (v3 as u64), v7)
        } else {
            let (v8, v9) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap<T4, T2, T3>(arg1, arg8, false, (arg3 as u128), arg7, arg6, arg10, arg12);
            let (v10, v11) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap<T2, T0, T1>(arg0, arg8, false, v9, arg7, arg5, arg10, arg12);
            assert!(v10 == v9, 6);
            let v12 = (v11 as u64);
            assert!(arg4 >= v12, 5);
            (v12, (v10 as u64), (v8 as u64))
        };
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap_coin_b_a_c_b<T0, T1, T2, T3, T4>(arg0, arg1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::merge_coin<T0>(arg2), v0, v1, v2, arg8, arg12);
    }

    // decompiled from Move bytecode v6
}

