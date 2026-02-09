module 0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::leverage {
    struct OnboardLeverageMarketWish<phantom T0> has copy, drop, store {
        market_id: 0x2::object::ID,
        emode_group: u8,
    }

    public fun fulfill_onboard_leverage_market_wish<T0>(arg0: &mut 0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::DragonBallCollector, arg1: &0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::market::Market<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::ensure_can_summon_shenron(arg0);
        0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::take_locked_update<0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::time_lock::TimeLock<OnboardLeverageMarketWish<T0>>>(arg0, 0x1::type_name::with_defining_ids<OnboardLeverageMarketWish<T0>>());
        assert!(0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::time_lock::is_active<OnboardLeverageMarketWish<T0>>(&v0, arg2), 0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::errors::time_locked_not_active());
        let v1 = 0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::time_lock::into_inner<OnboardLeverageMarketWish<T0>>(v0);
        0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::wish_event::emit_fulfill_wish_event<OnboardLeverageMarketWish<T0>>(v1);
        let OnboardLeverageMarketWish {
            market_id   : v2,
            emode_group : v3,
        } = v1;
        assert!(v2 == 0x2::object::id<0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::market::Market<T0>>(arg1), 0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::errors::invalid_market_id());
        0x3c8d90788fa43a63c19a31fd6c2806f5135adc784e7e782075a203ab3b72cc4b::leverage_admin::onboard_market<T0>(0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::lending_admin_cap(arg0), arg1, v3, arg3);
    }

    public fun wish_onboard_leverage_market<T0>(arg0: &mut 0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::DragonBallCollector, arg1: &0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::market::Market<T0>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::ensure_can_summon_shenron(arg0);
        0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = OnboardLeverageMarketWish<T0>{
            market_id   : 0x2::object::id<0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::market::Market<T0>>(arg1),
            emode_group : arg2,
        };
        0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::wish_event::emit_new_wish_event<OnboardLeverageMarketWish<T0>>(v0);
        0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::store_locked_update<0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::time_lock::TimeLock<OnboardLeverageMarketWish<T0>>>(arg0, 0x1::type_name::with_defining_ids<OnboardLeverageMarketWish<T0>>(), 0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::time_lock::new_time_locked<OnboardLeverageMarketWish<T0>>(v0, arg3, 0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::time_lock_duration_seconds(arg0), 0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

