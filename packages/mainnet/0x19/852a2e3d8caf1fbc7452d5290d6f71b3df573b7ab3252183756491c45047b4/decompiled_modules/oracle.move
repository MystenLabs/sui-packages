module 0x19852a2e3d8caf1fbc7452d5290d6f71b3df573b7ab3252183756491c45047b4::oracle {
    fun add_exponents(arg0: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64, arg1: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64, arg2: u64) : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64 {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&arg1);
        let v2 = if (v0) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&arg0)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&arg0)
        };
        let v3 = if (v1) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&arg1)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&arg1)
        };
        let v4 = arg2;
        let v5 = 0;
        let v6 = v5;
        if (v0) {
            v6 = v5 + v2;
        } else {
            v4 = arg2 + v2;
        };
        if (v1) {
            v6 = v6 + v3;
        } else {
            v4 = v4 + v3;
        };
        if (v4 >= v6) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::new(v4 - v6, false)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::new(v6 - v4, true)
        }
    }

    fun adjust_for_decimals(arg0: u128, arg1: u8, arg2: u8) : u128 {
        if (arg1 == arg2) {
            arg0
        } else if (arg2 > arg1) {
            arg0 * pow10(((arg2 - arg1) as u64))
        } else {
            arg0 / pow10(((arg1 - arg2) as u64))
        }
    }

    fun adjust_for_exponents(arg0: u128, arg1: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64, arg2: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64) : u128 {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&arg1);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&arg2);
        let v2 = if (v0) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&arg1)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&arg1)
        };
        let v3 = if (v1) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&arg2)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&arg2)
        };
        let (v4, v5) = if (v0 == v1) {
            if (v0) {
                if (v2 > v3) {
                    (false, v2 - v3)
                } else {
                    (true, v3 - v2)
                }
            } else if (v2 > v3) {
                (true, v2 - v3)
            } else {
                (false, v3 - v2)
            }
        } else {
            let (v6, v7) = if (v0) {
                (v2 + v3, false)
            } else {
                (v2 + v3, true)
            };
            (v7, v6)
        };
        if (v5 == 0) {
            arg0
        } else if (v4) {
            arg0 * pow10(v5)
        } else {
            arg0 / pow10(v5)
        }
    }

    fun calculate_fair_output(arg0: u64, arg1: u64, arg2: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64, arg3: u64, arg4: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64, arg5: u8, arg6: u8) : u128 {
        adjust_for_decimals(adjust_for_exponents((arg0 as u128) * (arg1 as u128) / (arg3 as u128), arg2, arg4), arg5, arg6)
    }

    public fun calculate_min_output<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x19852a2e3d8caf1fbc7452d5290d6f71b3df573b7ab3252183756491c45047b4::config::PriceFeedRegistry, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: u64, arg7: u64, arg8: u8, arg9: u8) : u64 {
        let v0 = 0x19852a2e3d8caf1fbc7452d5290d6f71b3df573b7ab3252183756491c45047b4::config::get_price_feed<T0>(arg1);
        let v1 = 0x19852a2e3d8caf1fbc7452d5290d6f71b3df573b7ab3252183756491c45047b4::config::get_price_feed<T1>(arg1);
        assert!(0x1::option::is_some<0x19852a2e3d8caf1fbc7452d5290d6f71b3df573b7ab3252183756491c45047b4::config::PriceFeed>(&v0), 104);
        assert!(0x1::option::is_some<0x19852a2e3d8caf1fbc7452d5290d6f71b3df573b7ab3252183756491c45047b4::config::PriceFeed>(&v1), 104);
        let (v2, v3) = get_usd_price(arg0, arg2, 0x1::option::borrow<0x19852a2e3d8caf1fbc7452d5290d6f71b3df573b7ab3252183756491c45047b4::config::PriceFeed>(&v0), arg3);
        let (v4, v5) = get_usd_price(arg0, arg4, 0x1::option::borrow<0x19852a2e3d8caf1fbc7452d5290d6f71b3df573b7ab3252183756491c45047b4::config::PriceFeed>(&v1), arg5);
        ((calculate_fair_output(arg6, v2, v3, v4, v5, arg8, arg9) * (10000 - (arg7 as u128)) / 10000) as u64)
    }

    fun get_usd_price(arg0: &0x2::clock::Clock, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x19852a2e3d8caf1fbc7452d5290d6f71b3df573b7ab3252183756491c45047b4::config::PriceFeed, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) : (u64, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg1, arg0, 60);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        assert!(!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v1), 103);
        if (0x19852a2e3d8caf1fbc7452d5290d6f71b3df573b7ab3252183756491c45047b4::config::requires_routing(arg2)) {
            let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg3, arg0, 60);
            let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v4);
            assert!(!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v5), 103);
            multiply_prices(v0, v4)
        } else {
            (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0))
        }
    }

    fun multiply_prices(arg0: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price, arg1: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price) : (u64, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&arg1);
        assert!(!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v0), 103);
        assert!(!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v1), 103);
        ((((0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v0) as u128) * (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1) as u128) / 1000000000000000000) as u64), add_exponents(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&arg0), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&arg1), 18))
    }

    fun pow10(arg0: u64) : u128 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

