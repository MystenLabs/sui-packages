module 0xa6244236d5d19ba42f479a1444e6c24ec0ede1d2fe8f9aed562abf331b9491f2::offchain {
    struct RegistrySnapshot has copy, drop {
        registry_id: 0x2::object::ID,
        protocol_count: u64,
        series_count: u64,
        market_count: u64,
        program_count: u64,
        source_count: u64,
        market_source_count: u64,
    }

    public fun registry_snapshot(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xa6244236d5d19ba42f479a1444e6c24ec0ede1d2fe8f9aed562abf331b9491f2::market_registry::Registry) : RegistrySnapshot {
        0xa6244236d5d19ba42f479a1444e6c24ec0ede1d2fe8f9aed562abf331b9491f2::package_version::assert_current(arg0);
        let (v0, v1, v2, v3, v4, v5) = 0xa6244236d5d19ba42f479a1444e6c24ec0ede1d2fe8f9aed562abf331b9491f2::market_registry::counts(arg1);
        RegistrySnapshot{
            registry_id         : 0xa6244236d5d19ba42f479a1444e6c24ec0ede1d2fe8f9aed562abf331b9491f2::market_registry::id(arg1),
            protocol_count      : v0,
            series_count        : v1,
            market_count        : v2,
            program_count       : v3,
            source_count        : v4,
            market_source_count : v5,
        }
    }

    // decompiled from Move bytecode v7
}

