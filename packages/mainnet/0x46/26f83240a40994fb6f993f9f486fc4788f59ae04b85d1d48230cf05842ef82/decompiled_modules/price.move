module 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::price {
    fun assert_protocol_version(arg0: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry) {
        assert!(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::protocol_version(arg0) == 1, 10);
    }

    public fun oracle_price<T0, T1, T2>(arg0: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry) : u128 {
        assert_protocol_version(arg1);
        let v0 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::math::calc_oracle_price<T0, T1, T2>(arg0);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::events::emit_oracle_price_event<T0, T1, T2>(arg0, v0);
        v0
    }

    public fun spot_price<T0, T1, T2>(arg0: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry) : u128 {
        assert_protocol_version(arg1);
        let v0 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::math::calc_spot_price<T0, T1, T2>(arg0);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::events::emit_spot_price_event<T0, T1, T2>(arg0, v0);
        v0
    }

    // decompiled from Move bytecode v6
}

