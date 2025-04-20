module 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::price {
    fun assert_protocol_version(arg0: &0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool_registry::PoolRegistry) {
        assert!(0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool_registry::protocol_version(arg0) == 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool_registry::current_protocol_version(), 10);
    }

    public fun oracle_price<T0, T1, T2>(arg0: &0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::Pool<T0>, arg1: &0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool_registry::PoolRegistry) : u128 {
        assert_protocol_version(arg1);
        let v0 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::math::calc_oracle_price<T0, T1, T2>(arg0);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::events::emit_oracle_price_event<T0, T1, T2>(arg0, v0);
        v0
    }

    public fun spot_price<T0, T1, T2>(arg0: &0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::Pool<T0>, arg1: &0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool_registry::PoolRegistry) : u128 {
        assert_protocol_version(arg1);
        let v0 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::math::calc_spot_price<T0, T1, T2>(arg0);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::events::emit_spot_price_event<T0, T1, T2>(arg0, v0);
        v0
    }

    // decompiled from Move bytecode v6
}

