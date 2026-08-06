module 0x4c978aae37431cb06e4784651d400f5b1c6a8f55d62a82e78fc678820ab43e88::price_feed_storage {
    public fun force_remove_price_feed<T0>(arg0: &0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::source::Source<0x4c978aae37431cb06e4784651d400f5b1c6a8f55d62a82e78fc678820ab43e88::source::SWITCHBOARD>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::authority::PACKAGE, T0>, arg2: &0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::config::Config, arg3: &mut 0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::price_feed_storage::PriceFeedStorage) {
        0x4c978aae37431cb06e4784651d400f5b1c6a8f55d62a82e78fc678820ab43e88::source::assert_version(arg0);
        0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::price_feed_storage::force_remove_price_feed<T0>(arg3, arg1, arg2, 0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::source::source_id<0x4c978aae37431cb06e4784651d400f5b1c6a8f55d62a82e78fc678820ab43e88::source::SWITCHBOARD>(arg0));
    }

    public fun new_price_feed<T0, T1>(arg0: &0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::source::Source<0x4c978aae37431cb06e4784651d400f5b1c6a8f55d62a82e78fc678820ab43e88::source::SWITCHBOARD>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::authority::VENDOR<T0>, T1>, arg2: &0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::config::Config, arg3: &mut 0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::price_feed_storage::PriceFeedStorage, arg4: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg5: u64) {
        0x4c978aae37431cb06e4784651d400f5b1c6a8f55d62a82e78fc678820ab43e88::source::assert_version(arg0);
        let v0 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::current_result(arg4);
        let v1 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::result(v0);
        assert!(!0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::neg(v1), 13835058888505819137);
        0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::price_feed_storage::new_price_feed<T0, T1, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator>(arg3, arg1, arg2, 0x4c978aae37431cb06e4784651d400f5b1c6a8f55d62a82e78fc678820ab43e88::source::source_cap(arg0), arg4, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::value(v1), 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::timestamp_ms(v0), arg5);
    }

    public fun remove_price_feed<T0>(arg0: &0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::source::Source<0x4c978aae37431cb06e4784651d400f5b1c6a8f55d62a82e78fc678820ab43e88::source::SWITCHBOARD>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::authority::VENDOR<T0>, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg2: &0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::config::Config, arg3: &mut 0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::price_feed_storage::PriceFeedStorage) {
        0x4c978aae37431cb06e4784651d400f5b1c6a8f55d62a82e78fc678820ab43e88::source::assert_version(arg0);
        0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::price_feed_storage::remove_price_feed<T0>(arg3, arg1, arg2, 0x4c978aae37431cb06e4784651d400f5b1c6a8f55d62a82e78fc678820ab43e88::source::source_cap(arg0));
    }

    public fun set_twap_period_ms<T0, T1>(arg0: &0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::source::Source<0x4c978aae37431cb06e4784651d400f5b1c6a8f55d62a82e78fc678820ab43e88::source::SWITCHBOARD>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::authority::VENDOR<T0>, T1>, arg2: &0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::config::Config, arg3: &mut 0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::price_feed_storage::PriceFeedStorage, arg4: u64) {
        0x4c978aae37431cb06e4784651d400f5b1c6a8f55d62a82e78fc678820ab43e88::source::assert_version(arg0);
        0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::price_feed_storage::set_twap_period_ms<T0, T1>(arg3, arg1, arg2, 0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::source::source_id<0x4c978aae37431cb06e4784651d400f5b1c6a8f55d62a82e78fc678820ab43e88::source::SWITCHBOARD>(arg0), arg4);
    }

    public fun update_price_feed(arg0: &0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::source::Source<0x4c978aae37431cb06e4784651d400f5b1c6a8f55d62a82e78fc678820ab43e88::source::SWITCHBOARD>, arg1: &0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::config::Config, arg2: &mut 0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::price_feed_storage::PriceFeedStorage, arg3: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator) {
        0x4c978aae37431cb06e4784651d400f5b1c6a8f55d62a82e78fc678820ab43e88::source::assert_version(arg0);
        let v0 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::current_result(arg3);
        let v1 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::result(v0);
        assert!(!0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::neg(v1), 13835058888505819137);
        0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::price_feed_storage::update_price_feed<0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator>(arg2, arg1, 0x4c978aae37431cb06e4784651d400f5b1c6a8f55d62a82e78fc678820ab43e88::source::source_cap(arg0), arg3, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::value(v1), 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::timestamp_ms(v0));
    }

    // decompiled from Move bytecode v7
}

