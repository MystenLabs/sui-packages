module 0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::leverage {
    struct OnboardLeverageMarketWish has copy, drop, store {
        market_type: 0x1::type_name::TypeName,
        market_id: 0x2::object::ID,
        emode_group: u8,
    }

    public fun fulfill_onboard_leverage_market_wish<T0>(arg0: &mut 0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::DragonBallCollector, arg1: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::Market<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::ensure_can_summon_shenron(arg0);
        0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::take_locked_update<0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::time_lock::TimeLock<OnboardLeverageMarketWish>>(arg0, 0x1::type_name::with_defining_ids<OnboardLeverageMarketWish>());
        assert!(0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::time_lock::is_active<OnboardLeverageMarketWish>(&v0, arg2), 0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::errors::time_locked_not_active());
        let OnboardLeverageMarketWish {
            market_type : v1,
            market_id   : v2,
            emode_group : v3,
        } = 0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::time_lock::into_inner<OnboardLeverageMarketWish>(v0);
        assert!(v1 == 0x1::type_name::with_defining_ids<T0>(), 0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::errors::invalid_market_type());
        assert!(v2 == 0x2::object::id<0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::Market<T0>>(arg1), 0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::errors::invalid_market_id());
        0x87d4b98f0005479b277e6859d2dacbb9102b813c0ff485b2d22016180fe1cbf4::leverage_admin::onboard_market<T0>(0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::lending_admin_cap(arg0), arg1, v3, arg3);
    }

    public fun wish_onboard_leverage_market<T0>(arg0: &mut 0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::DragonBallCollector, arg1: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::Market<T0>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::ensure_can_summon_shenron(arg0);
        0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = OnboardLeverageMarketWish{
            market_type : 0x1::type_name::with_defining_ids<T0>(),
            market_id   : 0x2::object::id<0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::Market<T0>>(arg1),
            emode_group : arg2,
        };
        0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::store_locked_update<0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::time_lock::TimeLock<OnboardLeverageMarketWish>>(arg0, 0x1::type_name::with_defining_ids<OnboardLeverageMarketWish>(), 0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::time_lock::new_time_locked<OnboardLeverageMarketWish>(v0, arg3));
    }

    // decompiled from Move bytecode v6
}

