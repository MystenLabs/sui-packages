module 0x10b30bb10ebc6b2fd3c9b435946c6a96745c10d3e3dd83a0778d378211c02bfc::oracle {
    public fun get_price(arg0: &0x10b30bb10ebc6b2fd3c9b435946c6a96745c10d3e3dd83a0778d378211c02bfc::config::Config, arg1: vector<u8>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) : (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64, u64) {
        0x10b30bb10ebc6b2fd3c9b435946c6a96745c10d3e3dd83a0778d378211c02bfc::config::check_version(arg0);
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg2, arg3, 0x10b30bb10ebc6b2fd3c9b435946c6a96745c10d3e3dd83a0778d378211c02bfc::config::get_max_age(arg0));
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg2);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v1);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v2) == arg1, 0);
        (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v0))
    }

    // decompiled from Move bytecode v6
}

