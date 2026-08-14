module 0x473fa6a0d1b36c193a3418f5fd070baa57f8e035585e63bcd33898ecba03c711::price_feed_storage {
    public fun force_remove_price_feed<T0>(arg0: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::Source<0x473fa6a0d1b36c193a3418f5fd070baa57f8e035585e63bcd33898ecba03c711::source::PYTH>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::authority::PACKAGE, T0>, arg2: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::config::Config, arg3: &mut 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::PriceFeedStorage) {
        0x473fa6a0d1b36c193a3418f5fd070baa57f8e035585e63bcd33898ecba03c711::source::assert_version(arg0);
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::force_remove_price_feed<T0>(arg3, arg1, arg2, 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::source_id<0x473fa6a0d1b36c193a3418f5fd070baa57f8e035585e63bcd33898ecba03c711::source::PYTH>(arg0));
    }

    public fun new_price_feed<T0, T1>(arg0: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::Source<0x473fa6a0d1b36c193a3418f5fd070baa57f8e035585e63bcd33898ecba03c711::source::PYTH>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::authority::VENDOR<T0>, T1>, arg2: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::config::Config, arg3: &mut 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::PriceFeedStorage, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: u64) {
        0x473fa6a0d1b36c193a3418f5fd070baa57f8e035585e63bcd33898ecba03c711::source::assert_version(arg0);
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg4);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::new_price_feed<T0, T1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg3, arg1, arg2, 0x473fa6a0d1b36c193a3418f5fd070baa57f8e035585e63bcd33898ecba03c711::source::source_cap(arg0), arg4, scaled_by_exponent(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0)), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v0) * 1000, arg5);
    }

    public fun remove_price_feed<T0>(arg0: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::Source<0x473fa6a0d1b36c193a3418f5fd070baa57f8e035585e63bcd33898ecba03c711::source::PYTH>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::authority::VENDOR<T0>, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg2: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::config::Config, arg3: &mut 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::PriceFeedStorage) {
        0x473fa6a0d1b36c193a3418f5fd070baa57f8e035585e63bcd33898ecba03c711::source::assert_version(arg0);
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::remove_price_feed<T0>(arg3, arg1, arg2, 0x473fa6a0d1b36c193a3418f5fd070baa57f8e035585e63bcd33898ecba03c711::source::source_cap(arg0));
    }

    public(friend) fun scaled_by_exponent(arg0: u64, arg1: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64) : u128 {
        if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&arg1)) {
            let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&arg1);
            if (v0 >= 38) {
                return 0
            };
            return (((arg0 as u256) * 1000000000000000000 / 0x1::u256::pow(10, (v0 as u8))) as u128)
        };
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&arg1);
        assert!(v1 <= 20, 13835059124729020417);
        let v2 = (arg0 as u256) * 0x1::u256::pow(10, (v1 as u8)) * 1000000000000000000;
        assert!(v2 <= 340282366920938463463374607431768211455, 13835340634065600515);
        (v2 as u128)
    }

    public fun set_twap_period_ms<T0, T1>(arg0: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::Source<0x473fa6a0d1b36c193a3418f5fd070baa57f8e035585e63bcd33898ecba03c711::source::PYTH>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::authority::VENDOR<T0>, T1>, arg2: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::config::Config, arg3: &mut 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::PriceFeedStorage, arg4: u64) {
        0x473fa6a0d1b36c193a3418f5fd070baa57f8e035585e63bcd33898ecba03c711::source::assert_version(arg0);
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::set_twap_period_ms<T0, T1>(arg3, arg1, arg2, 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::source_id<0x473fa6a0d1b36c193a3418f5fd070baa57f8e035585e63bcd33898ecba03c711::source::PYTH>(arg0), arg4);
    }

    public fun update_price_feed(arg0: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::Source<0x473fa6a0d1b36c193a3418f5fd070baa57f8e035585e63bcd33898ecba03c711::source::PYTH>, arg1: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::config::Config, arg2: &mut 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::PriceFeedStorage, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        0x473fa6a0d1b36c193a3418f5fd070baa57f8e035585e63bcd33898ecba03c711::source::assert_version(arg0);
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg3);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::update_price_feed<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2, arg1, 0x473fa6a0d1b36c193a3418f5fd070baa57f8e035585e63bcd33898ecba03c711::source::source_cap(arg0), arg3, scaled_by_exponent(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0)), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v0) * 1000);
    }

    // decompiled from Move bytecode v7
}

