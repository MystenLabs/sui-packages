module 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::leverage {
    struct OnboardLeverageMarketWish<phantom T0> has copy, drop, store {
        market_id: 0x2::object::ID,
        emode_group: u8,
    }

    public fun fulfill_onboard_leverage_market_wish<T0>(arg0: &mut 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::DragonBallCollector, arg1: &0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::Market<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::ensure_can_summon_shenron(arg0);
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::take_locked_update<0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::time_lock::TimeLock<OnboardLeverageMarketWish<T0>>>(arg0, 0x1::type_name::with_defining_ids<OnboardLeverageMarketWish<T0>>());
        assert!(0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::time_lock::is_active<OnboardLeverageMarketWish<T0>>(&v0, arg2), 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::errors::time_locked_not_active());
        let v1 = 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::time_lock::into_inner<OnboardLeverageMarketWish<T0>>(v0);
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::wish_event::emit_fulfill_wish_event<OnboardLeverageMarketWish<T0>>(v1);
        let OnboardLeverageMarketWish {
            market_id   : v2,
            emode_group : v3,
        } = v1;
        assert!(v2 == 0x2::object::id<0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::Market<T0>>(arg1), 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::errors::invalid_market_id());
        0xb24d2c9ae39a07cabfeaa8afa89fc99b87486ee329ae3d99816bcdd2c5c6351d::leverage_admin::onboard_market<T0>(0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::lending_admin_cap(arg0), arg1, v3, arg3);
    }

    public fun wish_onboard_leverage_market<T0>(arg0: &mut 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::DragonBallCollector, arg1: &0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::Market<T0>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::ensure_can_summon_shenron(arg0);
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = OnboardLeverageMarketWish<T0>{
            market_id   : 0x2::object::id<0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::Market<T0>>(arg1),
            emode_group : arg2,
        };
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::wish_event::emit_new_wish_event<OnboardLeverageMarketWish<T0>>(v0);
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::store_locked_update<0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::time_lock::TimeLock<OnboardLeverageMarketWish<T0>>>(arg0, 0x1::type_name::with_defining_ids<OnboardLeverageMarketWish<T0>>(), 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::time_lock::new_time_locked<OnboardLeverageMarketWish<T0>>(v0, arg3, 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::time_lock_duration_seconds(arg0), 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

