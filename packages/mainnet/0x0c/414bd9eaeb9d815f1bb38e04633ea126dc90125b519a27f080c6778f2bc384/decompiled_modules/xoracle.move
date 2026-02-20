module 0xb6f15a830dd527f06a27f5bf388be79e29df8f81bee9364cc45c3ea944bc0312::xoracle {
    struct RegisterPythFeedWish<phantom T0> has copy, drop, store {
        spot_confidence_tolerance_bps: u64,
        ema_confidence_tolerance_bps: u64,
        price_info_object_id: 0x2::object::ID,
        x_oracle_id: 0x2::object::ID,
    }

    public fun fulfill_register_pyth_feed_wish<T0>(arg0: &mut 0xb6f15a830dd527f06a27f5bf388be79e29df8f81bee9364cc45c3ea944bc0312::governance::DragonBallCollector, arg1: &mut 0xb97857eb8c5b0c9aaf4ae617982a9557d5386b093a00adbc35bace8b14a6a7a6::x_oracle::XOracle, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xb6f15a830dd527f06a27f5bf388be79e29df8f81bee9364cc45c3ea944bc0312::governance::ensure_functional(arg0);
        0xb6f15a830dd527f06a27f5bf388be79e29df8f81bee9364cc45c3ea944bc0312::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0xb6f15a830dd527f06a27f5bf388be79e29df8f81bee9364cc45c3ea944bc0312::governance::take_locked_update<0xb6f15a830dd527f06a27f5bf388be79e29df8f81bee9364cc45c3ea944bc0312::time_lock::TimeLock<RegisterPythFeedWish<T0>>>(arg0, 0x1::type_name::with_defining_ids<RegisterPythFeedWish<T0>>());
        assert!(0xb6f15a830dd527f06a27f5bf388be79e29df8f81bee9364cc45c3ea944bc0312::time_lock::is_active<RegisterPythFeedWish<T0>>(&v0, arg3), 0xb6f15a830dd527f06a27f5bf388be79e29df8f81bee9364cc45c3ea944bc0312::errors::time_locked_not_active());
        let v1 = 0xb6f15a830dd527f06a27f5bf388be79e29df8f81bee9364cc45c3ea944bc0312::time_lock::into_inner<RegisterPythFeedWish<T0>>(v0);
        0xb6f15a830dd527f06a27f5bf388be79e29df8f81bee9364cc45c3ea944bc0312::governance::ensure_x_oracle_match(arg1, &v1.x_oracle_id);
        0xb6f15a830dd527f06a27f5bf388be79e29df8f81bee9364cc45c3ea944bc0312::wish_event::emit_fulfill_wish_event<RegisterPythFeedWish<T0>>(v1);
        let RegisterPythFeedWish {
            spot_confidence_tolerance_bps : v2,
            ema_confidence_tolerance_bps  : v3,
            price_info_object_id          : v4,
            x_oracle_id                   : _,
        } = v1;
        assert!(0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2) == v4, 0xb6f15a830dd527f06a27f5bf388be79e29df8f81bee9364cc45c3ea944bc0312::errors::invalid_pyth_price_info_object());
        0xb97857eb8c5b0c9aaf4ae617982a9557d5386b093a00adbc35bace8b14a6a7a6::oracle_admin::register_pyth_feed<T0>(0xb6f15a830dd527f06a27f5bf388be79e29df8f81bee9364cc45c3ea944bc0312::governance::x_oracle_admin_cap(arg0), arg1, arg2, v2, v3);
    }

    public fun update_price_delay_tolerance_ms(arg0: &mut 0xb6f15a830dd527f06a27f5bf388be79e29df8f81bee9364cc45c3ea944bc0312::governance::DragonBallCollector, arg1: &mut 0xb97857eb8c5b0c9aaf4ae617982a9557d5386b093a00adbc35bace8b14a6a7a6::x_oracle::XOracle, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xb6f15a830dd527f06a27f5bf388be79e29df8f81bee9364cc45c3ea944bc0312::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        0xb6f15a830dd527f06a27f5bf388be79e29df8f81bee9364cc45c3ea944bc0312::governance::ensure_functional(arg0);
        0xb97857eb8c5b0c9aaf4ae617982a9557d5386b093a00adbc35bace8b14a6a7a6::oracle_admin::update_price_delay_tolerance_ms(0xb6f15a830dd527f06a27f5bf388be79e29df8f81bee9364cc45c3ea944bc0312::governance::x_oracle_admin_cap(arg0), arg1, arg2, arg3, arg4);
    }

    public fun wish_register_pyth_feed<T0>(arg0: &mut 0xb6f15a830dd527f06a27f5bf388be79e29df8f81bee9364cc45c3ea944bc0312::governance::DragonBallCollector, arg1: &0xb97857eb8c5b0c9aaf4ae617982a9557d5386b093a00adbc35bace8b14a6a7a6::x_oracle::XOracle, arg2: u64, arg3: u64, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0xb6f15a830dd527f06a27f5bf388be79e29df8f81bee9364cc45c3ea944bc0312::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg6));
        0xb6f15a830dd527f06a27f5bf388be79e29df8f81bee9364cc45c3ea944bc0312::governance::ensure_functional(arg0);
        let v0 = RegisterPythFeedWish<T0>{
            spot_confidence_tolerance_bps : arg2,
            ema_confidence_tolerance_bps  : arg3,
            price_info_object_id          : 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg4),
            x_oracle_id                   : 0x2::object::id<0xb97857eb8c5b0c9aaf4ae617982a9557d5386b093a00adbc35bace8b14a6a7a6::x_oracle::XOracle>(arg1),
        };
        0xb6f15a830dd527f06a27f5bf388be79e29df8f81bee9364cc45c3ea944bc0312::wish_event::emit_new_wish_event<RegisterPythFeedWish<T0>>(v0);
        0xb6f15a830dd527f06a27f5bf388be79e29df8f81bee9364cc45c3ea944bc0312::governance::store_locked_update<0xb6f15a830dd527f06a27f5bf388be79e29df8f81bee9364cc45c3ea944bc0312::time_lock::TimeLock<RegisterPythFeedWish<T0>>>(arg0, 0x1::type_name::with_defining_ids<RegisterPythFeedWish<T0>>(), 0xb6f15a830dd527f06a27f5bf388be79e29df8f81bee9364cc45c3ea944bc0312::time_lock::new_time_locked<RegisterPythFeedWish<T0>>(v0, arg5, 0xb6f15a830dd527f06a27f5bf388be79e29df8f81bee9364cc45c3ea944bc0312::governance::time_lock_duration_seconds(arg0), 0xb6f15a830dd527f06a27f5bf388be79e29df8f81bee9364cc45c3ea944bc0312::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

