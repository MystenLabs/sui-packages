module 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::set_stale_price_threshold {
    struct StalePriceThreshold {
        threshold: u64,
    }

    public(friend) fun execute(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::LatestOnly, arg1: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: vector<u8>) {
        let StalePriceThreshold { threshold: v0 } = from_byte_vec(arg2);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::set_stale_price_threshold_secs(arg0, arg1, v0);
    }

    fun from_byte_vec(arg0: vector<u8>) : StalePriceThreshold {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg0);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v0);
        StalePriceThreshold{threshold: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u64(&mut v0)}
    }

    // decompiled from Move bytecode v6
}

