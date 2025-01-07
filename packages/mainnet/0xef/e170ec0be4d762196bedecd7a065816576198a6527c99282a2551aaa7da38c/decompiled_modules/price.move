module 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::price {
    fun assert_protocol_version(arg0: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry) {
        assert!(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::protocol_version(arg0) == 1, 10);
    }

    public fun oracle_price<T0, T1, T2>(arg0: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry) : u128 {
        assert_protocol_version(arg1);
        let v0 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::math::calc_oracle_price<T0, T1, T2>(arg0);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::events::emit_oracle_price_event<T0, T1, T2>(arg0, v0);
        v0
    }

    public fun spot_price<T0, T1, T2>(arg0: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry) : u128 {
        assert_protocol_version(arg1);
        let v0 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::math::calc_spot_price<T0, T1, T2>(arg0);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::events::emit_spot_price_event<T0, T1, T2>(arg0, v0);
        v0
    }

    // decompiled from Move bytecode v6
}

