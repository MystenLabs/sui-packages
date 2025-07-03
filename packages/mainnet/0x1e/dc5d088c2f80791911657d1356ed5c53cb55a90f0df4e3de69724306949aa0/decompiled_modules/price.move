module 0x1edc5d088c2f80791911657d1356ed5c53cb55a90f0df4e3de69724306949aa0::price {
    public fun add_spread(arg0: &0x1edc5d088c2f80791911657d1356ed5c53cb55a90f0df4e3de69724306949aa0::config::Config, arg1: u64) : u64 {
        let v0 = 0x1edc5d088c2f80791911657d1356ed5c53cb55a90f0df4e3de69724306949aa0::config::get_spread(arg0);
        let v1 = 0x1edc5d088c2f80791911657d1356ed5c53cb55a90f0df4e3de69724306949aa0::config::get_current_count(arg0);
        if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v1)) {
            arg1 + take_percent_base_18(arg1, v0) - take_percent_base_18(arg1, take_percent_base_18(v0, 0x1edc5d088c2f80791911657d1356ed5c53cb55a90f0df4e3de69724306949aa0::curve::curve(0x1edc5d088c2f80791911657d1356ed5c53cb55a90f0df4e3de69724306949aa0::config::get_k_scaled(arg0), 0x1edc5d088c2f80791911657d1356ed5c53cb55a90f0df4e3de69724306949aa0::config::get_magnitude(&v1), true)))
        } else {
            arg1 + take_percent_base_18(arg1, v0) + take_percent_base_18(arg1, take_percent_base_18(v0, 0x1edc5d088c2f80791911657d1356ed5c53cb55a90f0df4e3de69724306949aa0::curve::curve(0x1edc5d088c2f80791911657d1356ed5c53cb55a90f0df4e3de69724306949aa0::config::get_k_scaled(arg0), 0x1edc5d088c2f80791911657d1356ed5c53cb55a90f0df4e3de69724306949aa0::config::get_magnitude(&v1), true)))
        }
    }

    public fun ask_price(arg0: &0x1edc5d088c2f80791911657d1356ed5c53cb55a90f0df4e3de69724306949aa0::config::Config, arg1: vector<u8>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) : (u64, u64) {
        let (v0, v1, _) = 0x1edc5d088c2f80791911657d1356ed5c53cb55a90f0df4e3de69724306949aa0::oracle::get_price(arg0, arg1, arg2, arg3);
        let v3 = v1;
        let v4 = v0;
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v4) == false, 0);
        (add_spread(arg0, 0x1edc5d088c2f80791911657d1356ed5c53cb55a90f0df4e3de69724306949aa0::config::get_magnitude(&v4)), 0x1edc5d088c2f80791911657d1356ed5c53cb55a90f0df4e3de69724306949aa0::config::get_magnitude(&v3))
    }

    public fun bid_price(arg0: &0x1edc5d088c2f80791911657d1356ed5c53cb55a90f0df4e3de69724306949aa0::config::Config, arg1: vector<u8>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) : (u64, u64) {
        let (v0, v1, _) = 0x1edc5d088c2f80791911657d1356ed5c53cb55a90f0df4e3de69724306949aa0::oracle::get_price(arg0, arg1, arg2, arg3);
        let v3 = v1;
        let v4 = v0;
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v4) == false, 1);
        (sub_spread(arg0, 0x1edc5d088c2f80791911657d1356ed5c53cb55a90f0df4e3de69724306949aa0::config::get_magnitude(&v4)), 0x1edc5d088c2f80791911657d1356ed5c53cb55a90f0df4e3de69724306949aa0::config::get_magnitude(&v3))
    }

    public fun sub_spread(arg0: &0x1edc5d088c2f80791911657d1356ed5c53cb55a90f0df4e3de69724306949aa0::config::Config, arg1: u64) : u64 {
        let v0 = 0x1edc5d088c2f80791911657d1356ed5c53cb55a90f0df4e3de69724306949aa0::config::get_spread(arg0);
        let v1 = 0x1edc5d088c2f80791911657d1356ed5c53cb55a90f0df4e3de69724306949aa0::config::get_current_count(arg0);
        if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v1)) {
            arg1 - take_percent_base_18(arg1, v0) + take_percent_base_18(arg1, take_percent_base_18(v0, 0x1edc5d088c2f80791911657d1356ed5c53cb55a90f0df4e3de69724306949aa0::curve::curve(0x1edc5d088c2f80791911657d1356ed5c53cb55a90f0df4e3de69724306949aa0::config::get_k_scaled(arg0), 0x1edc5d088c2f80791911657d1356ed5c53cb55a90f0df4e3de69724306949aa0::config::get_magnitude(&v1), true)))
        } else {
            arg1 - take_percent_base_18(arg1, v0) - take_percent_base_18(arg1, take_percent_base_18(v0, 0x1edc5d088c2f80791911657d1356ed5c53cb55a90f0df4e3de69724306949aa0::curve::curve(0x1edc5d088c2f80791911657d1356ed5c53cb55a90f0df4e3de69724306949aa0::config::get_k_scaled(arg0), 0x1edc5d088c2f80791911657d1356ed5c53cb55a90f0df4e3de69724306949aa0::config::get_magnitude(&v1), true)))
        }
    }

    public fun take_percent_base_18(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 1000000000000000000) as u64)
    }

    // decompiled from Move bytecode v6
}

