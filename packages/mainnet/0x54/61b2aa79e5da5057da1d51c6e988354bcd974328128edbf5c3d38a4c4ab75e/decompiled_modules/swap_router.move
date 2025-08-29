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
        let (v0, v1) = swap_a_b_with_return_<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let v2 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, arg6);
        if (0x2::coin::value<T0>(&v2) == 0) {
            0x2::coin::destroy_zero<T0>(v2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg10));
        };
    }

    public entry fun swap_a_b_b_c<T0, T1, T2, T3, T4>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T2, T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T4, T3>, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: bool, arg8: address, arg9: u64, arg10: &0x2::clock::Clock, arg11: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg12: &mut 0x2::tx_context::TxContext) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg11);
        let (v0, v1) = swap_a_b_b_c_with_return_<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        let v2 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(v0, arg8);
        if (0x2::coin::value<T0>(&v2) == 0) {
            0x2::coin::destroy_zero<T0>(v2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg12));
        };
    }

    public fun swap_a_b_b_c_with_return_<T0, T1, T2, T3, T4>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T2, T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T4, T3>, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: bool, arg8: address, arg9: u64, arg10: &0x2::clock::Clock, arg11: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T4>, 0x2::coin::Coin<T0>) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg11);
        assert!(0x2::clock::timestamp_ms(arg10) <= arg9, 2);
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::merge_coin<T0>(arg2);
        if (arg7) {
            assert!(0x2::coin::value<T0>(&v0) >= arg3, 7);
        };
        let (v1, v2, v3) = if (arg7) {
            let (v4, v5) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap<T0, T2, T1>(arg0, arg8, true, (arg3 as u128), arg7, arg5, arg10, arg12);
            let (v6, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap<T2, T4, T3>(arg1, arg8, true, v5, arg7, arg6, arg10, arg12);
            assert!(v5 == v6, 6);
            let v8 = (v7 as u64);
            assert!(arg4 <= v8, 4);
            ((v4 as u64), (v5 as u64), v8)
        } else {
            let (v9, v10) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap<T2, T4, T3>(arg1, arg8, true, (arg3 as u128), arg7, arg6, arg10, arg12);
            let (v11, v12) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap<T0, T2, T1>(arg0, arg8, true, v9, arg7, arg5, arg10, arg12);
            assert!(v12 == v9, 6);
            let v13 = (v11 as u64);
            assert!(arg4 >= v13, 5);
            (v13, (v12 as u64), (v10 as u64))
        };
        if (!arg7) {
            assert!(0x2::coin::value<T0>(&v0) >= v1, 7);
        };
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap_coin_a_b_b_c_with_return_<T0, T1, T2, T3, T4>(arg0, arg1, v0, v1, v2, v3, arg12)
    }

    public entry fun swap_a_b_c_b<T0, T1, T2, T3, T4>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T2, T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T4, T2, T3>, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: bool, arg8: address, arg9: u64, arg10: &0x2::clock::Clock, arg11: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg12: &mut 0x2::tx_context::TxContext) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg11);
        let (v0, v1) = swap_a_b_c_b_with_return_<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        let v2 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(v0, arg8);
        if (0x2::coin::value<T0>(&v2) == 0) {
            0x2::coin::destroy_zero<T0>(v2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg12));
        };
    }

    public fun swap_a_b_c_b_with_return_<T0, T1, T2, T3, T4>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T2, T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T4, T2, T3>, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: bool, arg8: address, arg9: u64, arg10: &0x2::clock::Clock, arg11: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T4>, 0x2::coin::Coin<T0>) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg11);
        assert!(0x2::clock::timestamp_ms(arg10) <= arg9, 2);
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::merge_coin<T0>(arg2);
        if (arg7) {
            assert!(0x2::coin::value<T0>(&v0) >= arg3, 7);
        };
        let (v1, v2, v3) = if (arg7) {
            let (v4, v5) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap<T0, T2, T1>(arg0, arg8, true, (arg3 as u128), arg7, arg5, arg10, arg12);
            let (v6, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap<T4, T2, T3>(arg1, arg8, false, v5, arg7, arg6, arg10, arg12);
            assert!(v5 == v7, 6);
            let v8 = (v6 as u64);
            assert!(arg4 <= v8, 4);
            ((v4 as u64), (v5 as u64), v8)
        } else {
            let (v9, v10) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap<T4, T2, T3>(arg1, arg8, false, (arg3 as u128), arg7, arg6, arg10, arg12);
            let (v11, v12) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap<T0, T2, T1>(arg0, arg8, true, v10, arg7, arg5, arg10, arg12);
            assert!(v12 == v10, 6);
            let v13 = (v11 as u64);
            assert!(arg4 >= v13, 5);
            (v13, (v12 as u64), (v9 as u64))
        };
        if (!arg7) {
            assert!(0x2::coin::value<T0>(&v0) >= v1, 7);
        };
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap_coin_a_b_c_b_with_return_<T0, T1, T2, T3, T4>(arg0, arg1, v0, v1, v2, v3, arg12)
    }

    public fun swap_a_b_with_partner<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::partner::Partner, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u128, arg6: bool, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::zero<T1>(arg10);
        swap_with_partner<T0, T1, T2>(arg0, arg1, arg2, v0, true, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    public fun swap_a_b_with_return_<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: u64, arg4: u128, arg5: bool, arg6: address, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg9);
        assert!(0x2::clock::timestamp_ms(arg8) <= arg7, 2);
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::merge_coin<T0>(arg1);
        if (arg5) {
            assert!(0x2::coin::value<T0>(&v0) >= arg2, 7);
        };
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap<T0, T1, T2>(arg0, arg6, true, (arg2 as u128), arg5, arg4, arg8, arg10);
        let v3 = (v1 as u64);
        let v4 = (v2 as u64);
        check_amount_threshold(arg5, true, v3, v4, arg3);
        if (!arg5) {
            assert!(0x2::coin::value<T0>(&v0) >= v3, 7);
        };
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap_coin_a_b_with_return_<T0, T1, T2>(arg0, v0, v3, v4, arg10)
    }

    public entry fun swap_b_a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: vector<0x2::coin::Coin<T1>>, arg2: u64, arg3: u64, arg4: u128, arg5: bool, arg6: address, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x2::tx_context::TxContext) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg9);
        let (v0, v1) = swap_b_a_with_return_<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let v2 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg6);
        if (0x2::coin::value<T1>(&v2) == 0) {
            0x2::coin::destroy_zero<T1>(v2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg10));
        };
    }

    public entry fun swap_b_a_b_c<T0, T1, T2, T3, T4>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T0, T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T4, T3>, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: bool, arg8: address, arg9: u64, arg10: &0x2::clock::Clock, arg11: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg12: &mut 0x2::tx_context::TxContext) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg11);
        let (v0, v1) = swap_b_a_b_c_with_return_<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        let v2 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(v0, arg8);
        if (0x2::coin::value<T0>(&v2) == 0) {
            0x2::coin::destroy_zero<T0>(v2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg12));
        };
    }

    public fun swap_b_a_b_c_with_return_<T0, T1, T2, T3, T4>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T0, T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T4, T3>, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: bool, arg8: address, arg9: u64, arg10: &0x2::clock::Clock, arg11: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T4>, 0x2::coin::Coin<T0>) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg11);
        assert!(0x2::clock::timestamp_ms(arg10) <= arg9, 2);
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::merge_coin<T0>(arg2);
        if (arg7) {
            assert!(0x2::coin::value<T0>(&v0) >= arg3, 7);
        };
        let (v1, v2, v3) = if (arg7) {
            let (v4, v5) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap<T2, T0, T1>(arg0, arg8, false, (arg3 as u128), arg7, arg5, arg10, arg12);
            let (v6, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap<T2, T4, T3>(arg1, arg8, true, v4, arg7, arg6, arg10, arg12);
            assert!(v4 == v6, 6);
            let v8 = (v7 as u64);
            assert!(arg4 <= v8, 4);
            ((v5 as u64), (v4 as u64), v8)
        } else {
            let (v9, v10) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap<T2, T4, T3>(arg1, arg8, true, (arg3 as u128), arg7, arg6, arg10, arg12);
            let (v11, v12) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap<T2, T0, T1>(arg0, arg8, false, v9, arg7, arg5, arg10, arg12);
            assert!(v11 == v9, 6);
            let v13 = (v12 as u64);
            assert!(arg4 >= v13, 5);
            (v13, (v11 as u64), (v10 as u64))
        };
        if (!arg7) {
            assert!(0x2::coin::value<T0>(&v0) >= v1, 7);
        };
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap_coin_b_a_b_c_with_return_<T0, T1, T2, T3, T4>(arg0, arg1, v0, v1, v2, v3, arg12)
    }

    public entry fun swap_b_a_c_b<T0, T1, T2, T3, T4>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T0, T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T4, T2, T3>, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: bool, arg8: address, arg9: u64, arg10: &0x2::clock::Clock, arg11: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg12: &mut 0x2::tx_context::TxContext) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg11);
        let (v0, v1) = swap_b_a_c_b_with_return_<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        let v2 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(v0, arg8);
        if (0x2::coin::value<T0>(&v2) == 0) {
            0x2::coin::destroy_zero<T0>(v2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg12));
        };
    }

    public fun swap_b_a_c_b_with_return_<T0, T1, T2, T3, T4>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T0, T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T4, T2, T3>, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: bool, arg8: address, arg9: u64, arg10: &0x2::clock::Clock, arg11: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T4>, 0x2::coin::Coin<T0>) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg11);
        assert!(0x2::clock::timestamp_ms(arg10) <= arg9, 2);
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::merge_coin<T0>(arg2);
        if (arg7) {
            assert!(0x2::coin::value<T0>(&v0) >= arg3, 7);
        };
        let (v1, v2, v3) = if (arg7) {
            let (v4, v5) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap<T2, T0, T1>(arg0, arg8, false, (arg3 as u128), arg7, arg5, arg10, arg12);
            let (v6, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap<T4, T2, T3>(arg1, arg8, false, v4, arg7, arg6, arg10, arg12);
            assert!(v4 == v7, 6);
            let v8 = (v6 as u64);
            assert!(arg4 <= v8, 4);
            ((v5 as u64), (v4 as u64), v8)
        } else {
            let (v9, v10) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap<T4, T2, T3>(arg1, arg8, false, (arg3 as u128), arg7, arg6, arg10, arg12);
            let (v11, v12) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap<T2, T0, T1>(arg0, arg8, false, v10, arg7, arg5, arg10, arg12);
            assert!(v11 == v10, 6);
            let v13 = (v12 as u64);
            assert!(arg4 >= v13, 5);
            (v13, (v11 as u64), (v9 as u64))
        };
        if (!arg7) {
            assert!(0x2::coin::value<T0>(&v0) >= v1, 7);
        };
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap_coin_b_a_c_b_with_return_<T0, T1, T2, T3, T4>(arg0, arg1, v0, v1, v2, v3, arg12)
    }

    public fun swap_b_a_with_partner<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::partner::Partner, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: u128, arg6: bool, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::zero<T0>(arg10);
        swap_with_partner<T0, T1, T2>(arg0, arg1, v0, arg2, false, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    public fun swap_b_a_with_return_<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: vector<0x2::coin::Coin<T1>>, arg2: u64, arg3: u64, arg4: u128, arg5: bool, arg6: address, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg9);
        assert!(0x2::clock::timestamp_ms(arg8) <= arg7, 2);
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::merge_coin<T1>(arg1);
        if (arg5) {
            assert!(0x2::coin::value<T1>(&v0) >= arg2, 7);
        };
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap<T0, T1, T2>(arg0, arg6, false, (arg2 as u128), arg5, arg4, arg8, arg10);
        let v3 = (v1 as u64);
        let v4 = (v2 as u64);
        check_amount_threshold(arg5, false, v3, v4, arg3);
        if (!arg5) {
            assert!(0x2::coin::value<T1>(&v0) >= v4, 7);
        };
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::swap_coin_b_a_with_return_<T0, T1, T2>(arg0, v0, v4, v3, arg10)
    }

    public fun swap_with_partner<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::partner::Partner, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: u64, arg6: u64, arg7: u128, arg8: bool, arg9: u64, arg10: &0x2::clock::Clock, arg11: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg11);
        assert!(0x2::clock::timestamp_ms(arg10) <= arg9, 2);
        let (v0, v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap_partner<T0, T1, T2>(arg0, arg1, arg4, (arg5 as u128), arg8, arg7, arg10, arg11, arg12);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap_pay_amount<T0, T1>(&v3);
        let v7 = if (arg4) {
            0x2::coin::value<T1>(&v4)
        } else {
            0x2::coin::value<T0>(&v5)
        };
        if (arg8) {
            assert!(v6 == arg5, 7);
            assert!(v7 >= arg6, 4);
        } else {
            assert!(v7 == arg5, 7);
            assert!(v6 <= arg6, 5);
        };
        let (v8, v9) = if (arg4) {
            (0x2::coin::split<T0>(&mut arg2, v6, arg12), 0x2::coin::zero<T1>(arg12))
        } else {
            (0x2::coin::zero<T0>(arg12), 0x2::coin::split<T1>(&mut arg3, v6, arg12))
        };
        0x2::coin::join<T1>(&mut arg3, v4);
        0x2::coin::join<T0>(&mut arg2, v5);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap_partner<T0, T1, T2>(arg0, arg1, v8, v9, v3, arg11);
        (arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

