module 0x80e12980ac74e31421ff0029a5a2caf22826484fb5194ab6de9cbc58524d3e63::price {
    fun assert_protocol_version(arg0: &0x80e12980ac74e31421ff0029a5a2caf22826484fb5194ab6de9cbc58524d3e63::pool_registry::PoolRegistry) {
        assert!(0x80e12980ac74e31421ff0029a5a2caf22826484fb5194ab6de9cbc58524d3e63::pool_registry::protocol_version(arg0) == 1, 10);
    }

    public fun oracle_price<T0, T1, T2>(arg0: &0x80e12980ac74e31421ff0029a5a2caf22826484fb5194ab6de9cbc58524d3e63::pool::Pool<T0>, arg1: &0x80e12980ac74e31421ff0029a5a2caf22826484fb5194ab6de9cbc58524d3e63::pool_registry::PoolRegistry) : u128 {
        assert_protocol_version(arg1);
        let v0 = 0x80e12980ac74e31421ff0029a5a2caf22826484fb5194ab6de9cbc58524d3e63::math::calc_oracle_price<T0, T1, T2>(arg0);
        0x80e12980ac74e31421ff0029a5a2caf22826484fb5194ab6de9cbc58524d3e63::events::emit_oracle_price_event<T0, T1, T2>(arg0, v0);
        v0
    }

    public fun spot_price<T0, T1, T2>(arg0: &0x80e12980ac74e31421ff0029a5a2caf22826484fb5194ab6de9cbc58524d3e63::pool::Pool<T0>, arg1: &0x80e12980ac74e31421ff0029a5a2caf22826484fb5194ab6de9cbc58524d3e63::pool_registry::PoolRegistry) : u128 {
        assert_protocol_version(arg1);
        let v0 = 0x80e12980ac74e31421ff0029a5a2caf22826484fb5194ab6de9cbc58524d3e63::math::calc_spot_price<T0, T1, T2>(arg0);
        0x80e12980ac74e31421ff0029a5a2caf22826484fb5194ab6de9cbc58524d3e63::events::emit_spot_price_event<T0, T1, T2>(arg0, v0);
        v0
    }

    // decompiled from Move bytecode v6
}

