module 0x2328394b747206cf1111a020ae0eb6cf68fc33cb9ca435183d9c950c6c08a8ab::price {
    fun assert_protocol_version(arg0: &0x2328394b747206cf1111a020ae0eb6cf68fc33cb9ca435183d9c950c6c08a8ab::pool_registry::PoolRegistry) {
        assert!(0x2328394b747206cf1111a020ae0eb6cf68fc33cb9ca435183d9c950c6c08a8ab::pool_registry::protocol_version(arg0) == 1, 10);
    }

    public fun oracle_price<T0, T1, T2>(arg0: &0x2328394b747206cf1111a020ae0eb6cf68fc33cb9ca435183d9c950c6c08a8ab::pool::Pool<T0>, arg1: &0x2328394b747206cf1111a020ae0eb6cf68fc33cb9ca435183d9c950c6c08a8ab::pool_registry::PoolRegistry) : u128 {
        assert_protocol_version(arg1);
        let v0 = 0x2328394b747206cf1111a020ae0eb6cf68fc33cb9ca435183d9c950c6c08a8ab::math::calc_oracle_price<T0, T1, T2>(arg0);
        0x2328394b747206cf1111a020ae0eb6cf68fc33cb9ca435183d9c950c6c08a8ab::events::emit_oracle_price_event<T0, T1, T2>(arg0, v0);
        v0
    }

    public fun spot_price<T0, T1, T2>(arg0: &0x2328394b747206cf1111a020ae0eb6cf68fc33cb9ca435183d9c950c6c08a8ab::pool::Pool<T0>, arg1: &0x2328394b747206cf1111a020ae0eb6cf68fc33cb9ca435183d9c950c6c08a8ab::pool_registry::PoolRegistry) : u128 {
        assert_protocol_version(arg1);
        let v0 = 0x2328394b747206cf1111a020ae0eb6cf68fc33cb9ca435183d9c950c6c08a8ab::math::calc_spot_price<T0, T1, T2>(arg0);
        0x2328394b747206cf1111a020ae0eb6cf68fc33cb9ca435183d9c950c6c08a8ab::events::emit_spot_price_event<T0, T1, T2>(arg0, v0);
        v0
    }

    // decompiled from Move bytecode v6
}

