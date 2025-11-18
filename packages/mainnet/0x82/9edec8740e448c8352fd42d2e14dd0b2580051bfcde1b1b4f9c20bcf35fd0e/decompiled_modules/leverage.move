module 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::leverage {
    struct OnboardLeverageMarketWish has copy, drop, store {
        market_type: 0x1::type_name::TypeName,
        market_id: 0x2::object::ID,
        emode_group: u8,
    }

    public fun fulfill_onboard_leverage_market_wish<T0>(arg0: &mut 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::DragonBallCollector, arg1: &0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::market::Market<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::ensure_can_summon_shenron(arg0);
        0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::take_locked_update<0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::time_lock::TimeLock<OnboardLeverageMarketWish>>(arg0, 0x1::type_name::with_defining_ids<OnboardLeverageMarketWish>());
        assert!(0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::time_lock::is_active<OnboardLeverageMarketWish>(&v0, arg2), 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::errors::time_locked_not_active());
        let OnboardLeverageMarketWish {
            market_type : v1,
            market_id   : v2,
            emode_group : v3,
        } = 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::time_lock::into_inner<OnboardLeverageMarketWish>(v0);
        assert!(v1 == 0x1::type_name::with_defining_ids<T0>(), 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::errors::invalid_market_type());
        assert!(v2 == 0x2::object::id<0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::market::Market<T0>>(arg1), 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::errors::invalid_market_id());
        0x4c9b1f0090c48491fa382c98802ad12bacc6d66b1739c842d38a63a19d1a0315::leverage_admin::onboard_market<T0>(0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::lending_admin_cap(arg0), arg1, v3, arg3);
    }

    public fun wish_onboard_leverage_market<T0>(arg0: &mut 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::DragonBallCollector, arg1: &0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::market::Market<T0>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::ensure_can_summon_shenron(arg0);
        0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = OnboardLeverageMarketWish{
            market_type : 0x1::type_name::with_defining_ids<T0>(),
            market_id   : 0x2::object::id<0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::market::Market<T0>>(arg1),
            emode_group : arg2,
        };
        0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::store_locked_update<0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::time_lock::TimeLock<OnboardLeverageMarketWish>>(arg0, 0x1::type_name::with_defining_ids<OnboardLeverageMarketWish>(), 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::time_lock::new_time_locked<OnboardLeverageMarketWish>(v0, arg3, 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::time_lock_duration_seconds(arg0), 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

