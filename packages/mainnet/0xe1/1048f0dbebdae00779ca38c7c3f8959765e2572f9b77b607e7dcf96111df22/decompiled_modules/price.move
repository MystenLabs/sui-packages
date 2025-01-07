module 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::price {
    fun assert_protocol_version(arg0: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry) {
        assert!(0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::protocol_version(arg0) == 1, 10);
    }

    public fun oracle_price<T0, T1, T2>(arg0: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry) : u128 {
        assert_protocol_version(arg1);
        let v0 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::math::calc_oracle_price<T0, T1, T2>(arg0);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::events::emit_oracle_price_event<T0, T1, T2>(arg0, v0);
        v0
    }

    public fun spot_price<T0, T1, T2>(arg0: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry) : u128 {
        assert_protocol_version(arg1);
        let v0 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::math::calc_spot_price<T0, T1, T2>(arg0);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::events::emit_spot_price_event<T0, T1, T2>(arg0, v0);
        v0
    }

    // decompiled from Move bytecode v6
}

