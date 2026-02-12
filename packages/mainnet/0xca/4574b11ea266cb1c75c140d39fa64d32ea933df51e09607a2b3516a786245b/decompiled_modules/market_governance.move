module 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::market_governance {
    struct UpdateMarketWish<phantom T0> has copy, drop, store {
        market_config: 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::MarketConfiguration,
    }

    public fun discharge_circuit_break<T0>(arg0: &0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::roles::SuperAdminRole, arg1: &0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::DragonBallCollector, arg2: &mut 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::ensure_can_summon_shenron(arg1);
        0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market_admin::discharge_circuit_break<T0>(0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::lending_admin_cap(arg1), arg2, arg3, arg4);
    }

    public fun trigger_circuit_break<T0>(arg0: &0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::DragonBallCollector, arg1: &mut 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::Market<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::ensure_can_summon_shenron(arg0);
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::ensure_watcher_allowed(arg0, 0x2::tx_context::sender(arg3));
        0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market_admin::trigger_circuit_break<T0>(0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::lending_admin_cap(arg0), arg1, arg2, arg3);
    }

    public fun update_market_ema_spot_tolerance<T0, T1>(arg0: &0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::DragonBallCollector, arg1: &mut 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::Market<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::ensure_can_summon_shenron(arg0);
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market_admin::update_market_ema_spot_tolerance<T0, T1>(0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::lending_admin_cap(arg0), arg1, arg2, arg3, arg4);
    }

    public fun fulfill_register_market_wish<T0>(arg0: &mut 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::DragonBallCollector, arg1: &mut 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::app::ProtocolApp, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::ensure_can_summon_shenron(arg0);
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::take_locked_update<0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::time_lock::TimeLock<UpdateMarketWish<T0>>>(arg0, 0x1::type_name::with_defining_ids<UpdateMarketWish<T0>>());
        assert!(0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::time_lock::is_active<UpdateMarketWish<T0>>(&v0, arg2), 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::errors::time_locked_not_active());
        let v1 = 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::time_lock::into_inner<UpdateMarketWish<T0>>(v0);
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::wish_event::emit_fulfill_wish_event<UpdateMarketWish<T0>>(v1);
        let UpdateMarketWish { market_config: v2 } = v1;
        0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market_admin::register_market<T0>(0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::lending_admin_cap(arg0), arg1, v2, arg2, arg3)
    }

    public fun fulfill_update_market_wish<T0>(arg0: &mut 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::DragonBallCollector, arg1: &mut 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::app::ProtocolApp, arg2: &mut 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::ensure_can_summon_shenron(arg0);
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::take_locked_update<0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::time_lock::TimeLock<UpdateMarketWish<T0>>>(arg0, 0x1::type_name::with_defining_ids<UpdateMarketWish<T0>>());
        assert!(0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::time_lock::is_active<UpdateMarketWish<T0>>(&v0, arg3), 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::errors::time_locked_not_active());
        let v1 = 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::time_lock::into_inner<UpdateMarketWish<T0>>(v0);
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::wish_event::emit_fulfill_wish_event<UpdateMarketWish<T0>>(v1);
        let UpdateMarketWish { market_config: v2 } = v1;
        0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market_admin::update_market<T0>(0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::lending_admin_cap(arg0), arg1, arg2, v2, arg3, arg4);
    }

    public fun wish_update_market<T0>(arg0: &mut 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::DragonBallCollector, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::ensure_can_summon_shenron(arg0);
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = UpdateMarketWish<T0>{market_config: 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market_admin::create_market_config(0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::lending_admin_cap(arg0), arg1, arg2)};
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::wish_event::emit_new_wish_event<UpdateMarketWish<T0>>(v0);
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::store_locked_update<0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::time_lock::TimeLock<UpdateMarketWish<T0>>>(arg0, 0x1::type_name::with_defining_ids<UpdateMarketWish<T0>>(), 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::time_lock::new_time_locked<UpdateMarketWish<T0>>(v0, arg3, 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::time_lock_duration_seconds(arg0), 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

