module 0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::leverage {
    struct OnboardLeverageMarketWish<phantom T0> has copy, drop, store {
        market_id: 0x2::object::ID,
        emode_group: u8,
    }

    public fun fulfill_onboard_leverage_market_wish<T0>(arg0: &mut 0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::DragonBallCollector, arg1: &0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::market::Market<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::ensure_can_summon_shenron(arg0);
        0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::take_locked_update<0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::time_lock::TimeLock<OnboardLeverageMarketWish<T0>>>(arg0, 0x1::type_name::with_defining_ids<OnboardLeverageMarketWish<T0>>());
        assert!(0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::time_lock::is_active<OnboardLeverageMarketWish<T0>>(&v0, arg2), 0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::errors::time_locked_not_active());
        let v1 = 0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::time_lock::into_inner<OnboardLeverageMarketWish<T0>>(v0);
        0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::wish_event::emit_fulfill_wish_event<OnboardLeverageMarketWish<T0>>(v1);
        let OnboardLeverageMarketWish {
            market_id   : v2,
            emode_group : v3,
        } = v1;
        assert!(v2 == 0x2::object::id<0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::market::Market<T0>>(arg1), 0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::errors::invalid_market_id());
        0xdc815c5b6818f80cba2ae0124a06b129b88c6edc76fde209c0a3ac937b86b43c::leverage_admin::onboard_market<T0>(0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::lending_admin_cap(arg0), arg1, v3, arg3);
    }

    public fun wish_onboard_leverage_market<T0>(arg0: &mut 0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::DragonBallCollector, arg1: &0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::market::Market<T0>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::ensure_can_summon_shenron(arg0);
        0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = OnboardLeverageMarketWish<T0>{
            market_id   : 0x2::object::id<0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::market::Market<T0>>(arg1),
            emode_group : arg2,
        };
        0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::wish_event::emit_new_wish_event<OnboardLeverageMarketWish<T0>>(v0);
        0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::store_locked_update<0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::time_lock::TimeLock<OnboardLeverageMarketWish<T0>>>(arg0, 0x1::type_name::with_defining_ids<OnboardLeverageMarketWish<T0>>(), 0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::time_lock::new_time_locked<OnboardLeverageMarketWish<T0>>(v0, arg3, 0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::time_lock_duration_seconds(arg0), 0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

