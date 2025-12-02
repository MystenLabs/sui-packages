module 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::utils {
    public(friend) fun adjust_for_slippage(arg0: u128, arg1: u128, arg2: u128, arg3: bool) : u128 {
        assert!(arg2 > 0, 6);
        assert!(arg1 <= arg2, 5);
        if (arg3) {
            arg0 * (arg2 + arg1) / arg2
        } else {
            arg0 * arg2 / (arg2 + arg1)
        }
    }

    public(friend) fun calc_sqrt_price_max_limit(arg0: u128, arg1: u128) : u128 {
        assert!(arg1 <= 10000, 5);
        arg0 * (10000 + arg1) / 10000
    }

    fun calculate_output(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u64, u64, u64) {
        let (v0, v1) = if (arg3 >= arg2) {
            (arg0 * 0x96a0426b95bdeecca5d30a3164d1302d8de9a0aafc194543eb45cb0c2c6fab4::fast_price_feed::pow10((((arg3 - arg2) * 2) as u8)), arg1)
        } else {
            (arg0, arg1 * 0x96a0426b95bdeecca5d30a3164d1302d8de9a0aafc194543eb45cb0c2c6fab4::fast_price_feed::pow10((((arg2 - arg3) * 2) as u8)))
        };
        assert!(v0 > 0, 11);
        assert!(v1 > 0, 12);
        (arg0, arg1, 0x96a0426b95bdeecca5d30a3164d1302d8de9a0aafc194543eb45cb0c2c6fab4::fast_price_feed::safe_mul_div_u64(arg4, v0, v1))
    }

    public fun destroy_zero_or_transfer_to_receiver<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        };
    }

    public fun get_amount_out(arg0: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg4: &vector<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>, arg5: u64, arg6: &0x2::clock::Clock) : u128 {
        abort 0
    }

    public fun get_nodo_price(arg0: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg1: &0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo, arg2: &0x2::clock::Clock) : (vector<u8>, 0x1::ascii::String, u64, u64) {
        let (v0, v1, v2, v3, _) = 0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::get_price_no_older_than(arg1, 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_max_age(arg0), arg2);
        assert!(v0 == 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_price_feed(arg0, v1), 9);
        assert!(v2 > 0, 10);
        (v0, v1, (v3 as u64), v2)
    }

    public fun get_pyth_price(arg0: 0x1::ascii::String, arg1: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) : (vector<u8>, u64, u64) {
        let v0 = 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_token_decimal(arg1, arg0);
        let (v1, v2) = 0x96a0426b95bdeecca5d30a3164d1302d8de9a0aafc194543eb45cb0c2c6fab4::fast_price_feed::get_price_guarded(arg2, v0, 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_max_age(arg1), 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_max_conf(arg1), arg3);
        assert!(v1 == 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_price_feed(arg1, arg0), 9);
        assert!(v2 > 0, 10);
        (v1, v0, v2)
    }

    public fun get_token_out_amount(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String, arg2: vector<0x1::ascii::String>, arg3: vector<u64>, arg4: vector<u64>, arg5: u64) : u128 {
        let v0 = false;
        let v1 = false;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        while (v6 < 0x1::vector::length<0x1::ascii::String>(&arg2) && (!v0 || !v1)) {
            if (!v0) {
                let (v7, v8) = 0x1::vector::index_of<0x1::ascii::String>(&arg2, &arg0);
                if (v7) {
                    v4 = *0x1::vector::borrow<u64>(&arg3, v8);
                    v2 = *0x1::vector::borrow<u64>(&arg4, v8);
                    v0 = true;
                };
            };
            if (!v1) {
                let (v9, v10) = 0x1::vector::index_of<0x1::ascii::String>(&arg2, &arg1);
                if (v9) {
                    v5 = *0x1::vector::borrow<u64>(&arg3, v10);
                    v3 = *0x1::vector::borrow<u64>(&arg4, v10);
                    v1 = true;
                };
            };
            v6 = v6 + 1;
        };
        assert!(v0, 7);
        assert!(v1, 8);
        let (_, _, v13) = calculate_output(v2, v3, v4, v5, arg5);
        (v13 as u128)
    }

    public(friend) fun has_duplicates(arg0: &vector<vector<u8>>) : bool {
        let v0 = 0x1::vector::length<vector<u8>>(arg0);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = v1 + 1;
            while (v2 < v0) {
                if (0x1::vector::borrow<vector<u8>>(arg0, v1) == 0x1::vector::borrow<vector<u8>>(arg0, v2)) {
                    return true
                };
                v2 = v2 + 1;
            };
            v1 = v1 + 1;
        };
        false
    }

    public(friend) fun verify_signature(arg0: &0x2::table::Table<vector<u8>, bool>, arg1: u64, arg2: vector<u8>, arg3: vector<vector<u8>>, arg4: vector<vector<u8>>) : bool {
        let v0 = 0x1::vector::length<vector<u8>>(&arg3);
        assert!(v0 >= arg1, 1);
        assert!(!has_duplicates(&arg3), 3);
        let v1 = 0;
        while (v1 < v0) {
            assert!(0x2::table::contains<vector<u8>, bool>(arg0, *0x1::vector::borrow<vector<u8>>(&arg3, v1)), 4);
            assert!(0x2::ed25519::ed25519_verify(0x1::vector::borrow<vector<u8>>(&arg4, v1), 0x1::vector::borrow<vector<u8>>(&arg3, v1), &arg2), 2);
            v1 = v1 + 1;
        };
        true
    }

    // decompiled from Move bytecode v6
}

