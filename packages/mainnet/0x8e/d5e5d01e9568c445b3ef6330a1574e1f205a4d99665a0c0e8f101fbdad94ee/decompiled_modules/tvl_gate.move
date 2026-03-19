module 0x8ed5e5d01e9568c445b3ef6330a1574e1f205a4d99665a0c0e8f101fbdad94ee::tvl_gate {
    public fun assert_default_min_tvl(arg0: &0xb9253f7f79c412eec2275b91824de2ec59f6b1e589de8a23dc19de3448ceaf9e::tvl_store::TvlStore, arg1: u8) {
        assert_min_tvl(arg0, arg1, 100000000);
    }

    public fun assert_min_tvl(arg0: &0xb9253f7f79c412eec2275b91824de2ec59f6b1e589de8a23dc19de3448ceaf9e::tvl_store::TvlStore, arg1: u8, arg2: u64) {
        assert!(0xb9253f7f79c412eec2275b91824de2ec59f6b1e589de8a23dc19de3448ceaf9e::tvl_store::get_tvl(arg0, arg1) >= arg2, 500);
    }

    // decompiled from Move bytecode v6
}

