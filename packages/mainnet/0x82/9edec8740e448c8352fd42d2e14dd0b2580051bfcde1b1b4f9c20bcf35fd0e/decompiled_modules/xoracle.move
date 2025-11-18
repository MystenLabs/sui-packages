module 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::xoracle {
    struct RegisterPythFeedWish has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
        spot_confidence_tolerance_bps: u64,
        ema_confidence_tolerance_bps: u64,
    }

    public fun fulfill_register_pyth_feed_wish<T0>(arg0: &mut 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::DragonBallCollector, arg1: &mut 0x1ffc803db455f688a4dc9d515c6245d3f1cdb67874a3a6fdc2fa21598bfd15f9::x_oracle::XOracle, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::ensure_can_summon_shenron(arg0);
        0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::take_locked_update<0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::time_lock::TimeLock<RegisterPythFeedWish>>(arg0, 0x1::type_name::with_defining_ids<RegisterPythFeedWish>());
        assert!(0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::time_lock::is_active<RegisterPythFeedWish>(&v0, arg3), 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::errors::time_locked_not_active());
        let RegisterPythFeedWish {
            coin_type                     : v1,
            spot_confidence_tolerance_bps : v2,
            ema_confidence_tolerance_bps  : v3,
        } = 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::time_lock::into_inner<RegisterPythFeedWish>(v0);
        assert!(v1 == 0x1::type_name::with_defining_ids<T0>(), 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::errors::invalid_coin_type());
        0x1ffc803db455f688a4dc9d515c6245d3f1cdb67874a3a6fdc2fa21598bfd15f9::oracle_admin::register_pyth_feed<T0>(0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::x_oracle_admin_cap(arg0), arg1, arg2, v2, v3);
    }

    public fun wish_register_pyth_feed<T0>(arg0: &mut 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::DragonBallCollector, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::ensure_can_summon_shenron(arg0);
        let v0 = RegisterPythFeedWish{
            coin_type                     : 0x1::type_name::with_defining_ids<T0>(),
            spot_confidence_tolerance_bps : arg1,
            ema_confidence_tolerance_bps  : arg2,
        };
        0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::store_locked_update<0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::time_lock::TimeLock<RegisterPythFeedWish>>(arg0, 0x1::type_name::with_defining_ids<RegisterPythFeedWish>(), 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::time_lock::new_time_locked<RegisterPythFeedWish>(v0, arg3, 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::time_lock_duration_seconds(arg0), 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

