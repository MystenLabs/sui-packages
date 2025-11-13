module 0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::leverage {
    struct OnboardLeverageMarketWish has copy, drop, store {
        market_type: 0x1::type_name::TypeName,
        market_id: 0x2::object::ID,
        emode_group: u8,
    }

    public fun fulfill_onboard_leverage_market_wish<T0>(arg0: &mut 0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::governance::DragonBallCollector, arg1: &0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::Market<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::governance::ensure_can_summon_shenron(arg0);
        0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::governance::take_locked_update<0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::time_lock::TimeLock<OnboardLeverageMarketWish>>(arg0, 0x1::type_name::with_defining_ids<OnboardLeverageMarketWish>());
        assert!(0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::time_lock::is_active<OnboardLeverageMarketWish>(&v0, arg2), 0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::errors::time_locked_not_active());
        let OnboardLeverageMarketWish {
            market_type : v1,
            market_id   : v2,
            emode_group : v3,
        } = 0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::time_lock::into_inner<OnboardLeverageMarketWish>(v0);
        assert!(v1 == 0x1::type_name::with_defining_ids<T0>(), 0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::errors::invalid_market_type());
        assert!(v2 == 0x2::object::id<0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::Market<T0>>(arg1), 0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::errors::invalid_market_id());
        0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_admin::onboard_market<T0>(0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::governance::lending_admin_cap(arg0), arg1, v3, arg3);
    }

    public fun wish_onboard_leverage_market<T0>(arg0: &mut 0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::governance::DragonBallCollector, arg1: &0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::Market<T0>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::governance::ensure_can_summon_shenron(arg0);
        0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = OnboardLeverageMarketWish{
            market_type : 0x1::type_name::with_defining_ids<T0>(),
            market_id   : 0x2::object::id<0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::Market<T0>>(arg1),
            emode_group : arg2,
        };
        0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::governance::store_locked_update<0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::time_lock::TimeLock<OnboardLeverageMarketWish>>(arg0, 0x1::type_name::with_defining_ids<OnboardLeverageMarketWish>(), 0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::time_lock::new_time_locked<OnboardLeverageMarketWish>(v0, arg3, 0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::governance::time_lock_duration_seconds(arg0), 0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

