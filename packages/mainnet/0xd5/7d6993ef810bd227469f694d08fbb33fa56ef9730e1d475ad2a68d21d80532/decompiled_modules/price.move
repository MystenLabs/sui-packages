module 0xd57d6993ef810bd227469f694d08fbb33fa56ef9730e1d475ad2a68d21d80532::price {
    public fun add_spread<T0>(arg0: &0xd57d6993ef810bd227469f694d08fbb33fa56ef9730e1d475ad2a68d21d80532::config::Config, arg1: u64) : u64 {
        let v0 = 0xd57d6993ef810bd227469f694d08fbb33fa56ef9730e1d475ad2a68d21d80532::config::get_spread<T0>(arg0);
        let v1 = 0xd57d6993ef810bd227469f694d08fbb33fa56ef9730e1d475ad2a68d21d80532::config::get_current_count(arg0);
        if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v1)) {
            arg1 + take_percent_base_18(arg1, v0) - take_percent_base_18(arg1, take_percent_base_18(v0, 0xd57d6993ef810bd227469f694d08fbb33fa56ef9730e1d475ad2a68d21d80532::curve::curve(0xd57d6993ef810bd227469f694d08fbb33fa56ef9730e1d475ad2a68d21d80532::config::get_k_scaled(arg0), 0xd57d6993ef810bd227469f694d08fbb33fa56ef9730e1d475ad2a68d21d80532::config::get_magnitude(&v1), true)))
        } else {
            arg1 + take_percent_base_18(arg1, v0) + take_percent_base_18(arg1, take_percent_base_18(v0, 0xd57d6993ef810bd227469f694d08fbb33fa56ef9730e1d475ad2a68d21d80532::curve::curve(0xd57d6993ef810bd227469f694d08fbb33fa56ef9730e1d475ad2a68d21d80532::config::get_k_scaled(arg0), 0xd57d6993ef810bd227469f694d08fbb33fa56ef9730e1d475ad2a68d21d80532::config::get_magnitude(&v1), true)))
        }
    }

    public fun ask_price<T0>(arg0: &0xd57d6993ef810bd227469f694d08fbb33fa56ef9730e1d475ad2a68d21d80532::config::Config, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : (u64, u64) {
        let (v0, v1, v2, _) = 0xd57d6993ef810bd227469f694d08fbb33fa56ef9730e1d475ad2a68d21d80532::oracle::get_price(arg0, 0xd57d6993ef810bd227469f694d08fbb33fa56ef9730e1d475ad2a68d21d80532::config::get_registry_price_id<T0>(arg0), arg1, arg2);
        let v4 = v1;
        let v5 = v0;
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v5) == false, 2000);
        (add_spread<T0>(arg0, 0xd57d6993ef810bd227469f694d08fbb33fa56ef9730e1d475ad2a68d21d80532::config::get_magnitude(&v5) + v2), 0xd57d6993ef810bd227469f694d08fbb33fa56ef9730e1d475ad2a68d21d80532::config::get_magnitude(&v4))
    }

    public fun bid_price<T0>(arg0: &0xd57d6993ef810bd227469f694d08fbb33fa56ef9730e1d475ad2a68d21d80532::config::Config, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : (u64, u64) {
        let (v0, v1, v2, _) = 0xd57d6993ef810bd227469f694d08fbb33fa56ef9730e1d475ad2a68d21d80532::oracle::get_price(arg0, 0xd57d6993ef810bd227469f694d08fbb33fa56ef9730e1d475ad2a68d21d80532::config::get_registry_price_id<T0>(arg0), arg1, arg2);
        let v4 = v1;
        let v5 = v0;
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v5) == false, 2001);
        (sub_spread<T0>(arg0, 0xd57d6993ef810bd227469f694d08fbb33fa56ef9730e1d475ad2a68d21d80532::config::get_magnitude(&v5) - v2), 0xd57d6993ef810bd227469f694d08fbb33fa56ef9730e1d475ad2a68d21d80532::config::get_magnitude(&v4))
    }

    public fun sub_spread<T0>(arg0: &0xd57d6993ef810bd227469f694d08fbb33fa56ef9730e1d475ad2a68d21d80532::config::Config, arg1: u64) : u64 {
        let v0 = 0xd57d6993ef810bd227469f694d08fbb33fa56ef9730e1d475ad2a68d21d80532::config::get_spread<T0>(arg0);
        let v1 = 0xd57d6993ef810bd227469f694d08fbb33fa56ef9730e1d475ad2a68d21d80532::config::get_current_count(arg0);
        if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v1)) {
            arg1 - take_percent_base_18(arg1, v0) + take_percent_base_18(arg1, take_percent_base_18(v0, 0xd57d6993ef810bd227469f694d08fbb33fa56ef9730e1d475ad2a68d21d80532::curve::curve(0xd57d6993ef810bd227469f694d08fbb33fa56ef9730e1d475ad2a68d21d80532::config::get_k_scaled(arg0), 0xd57d6993ef810bd227469f694d08fbb33fa56ef9730e1d475ad2a68d21d80532::config::get_magnitude(&v1), true)))
        } else {
            arg1 - take_percent_base_18(arg1, v0) - take_percent_base_18(arg1, take_percent_base_18(v0, 0xd57d6993ef810bd227469f694d08fbb33fa56ef9730e1d475ad2a68d21d80532::curve::curve(0xd57d6993ef810bd227469f694d08fbb33fa56ef9730e1d475ad2a68d21d80532::config::get_k_scaled(arg0), 0xd57d6993ef810bd227469f694d08fbb33fa56ef9730e1d475ad2a68d21d80532::config::get_magnitude(&v1), true)))
        }
    }

    public fun take_percent_base_18(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 1000000000000000000) as u64)
    }

    // decompiled from Move bytecode v6
}

