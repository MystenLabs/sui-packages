module 0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::xoracle {
    struct RegisterPythFeedWish<phantom T0> has copy, drop, store {
        spot_confidence_tolerance_bps: u64,
        ema_confidence_tolerance_bps: u64,
    }

    public fun fulfill_register_pyth_feed_wish<T0>(arg0: &mut 0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::governance::DragonBallCollector, arg1: &mut 0xa6ee3c6b4b6c0fb4e3240716afda5bdd23939dfdb9ef1e5a6055d038265077ad::x_oracle::XOracle, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::governance::ensure_can_summon_shenron(arg0);
        0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::governance::take_locked_update<0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::time_lock::TimeLock<RegisterPythFeedWish<T0>>>(arg0, 0x1::type_name::with_defining_ids<RegisterPythFeedWish<T0>>());
        assert!(0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::time_lock::is_active<RegisterPythFeedWish<T0>>(&v0, arg3), 0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::errors::time_locked_not_active());
        let v1 = 0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::time_lock::into_inner<RegisterPythFeedWish<T0>>(v0);
        0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::wish_event::emit_fulfill_wish_event<RegisterPythFeedWish<T0>>(v1);
        let RegisterPythFeedWish {
            spot_confidence_tolerance_bps : v2,
            ema_confidence_tolerance_bps  : v3,
        } = v1;
        0xa6ee3c6b4b6c0fb4e3240716afda5bdd23939dfdb9ef1e5a6055d038265077ad::oracle_admin::register_pyth_feed<T0>(0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::governance::x_oracle_admin_cap(arg0), arg1, arg2, v2, v3);
    }

    public fun wish_register_pyth_feed<T0>(arg0: &mut 0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::governance::DragonBallCollector, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::governance::ensure_can_summon_shenron(arg0);
        let v0 = RegisterPythFeedWish<T0>{
            spot_confidence_tolerance_bps : arg1,
            ema_confidence_tolerance_bps  : arg2,
        };
        0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::wish_event::emit_new_wish_event<RegisterPythFeedWish<T0>>(v0);
        0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::governance::store_locked_update<0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::time_lock::TimeLock<RegisterPythFeedWish<T0>>>(arg0, 0x1::type_name::with_defining_ids<RegisterPythFeedWish<T0>>(), 0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::time_lock::new_time_locked<RegisterPythFeedWish<T0>>(v0, arg3, 0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::governance::time_lock_duration_seconds(arg0), 0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

