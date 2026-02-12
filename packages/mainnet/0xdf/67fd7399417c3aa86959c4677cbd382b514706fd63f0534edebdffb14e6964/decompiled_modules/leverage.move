module 0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::leverage {
    struct OnboardLeverageMarketWish<phantom T0> has copy, drop, store {
        market_id: 0x2::object::ID,
        emode_group: u8,
    }

    public fun fulfill_onboard_leverage_market_wish<T0>(arg0: &mut 0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::governance::DragonBallCollector, arg1: &0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::Market<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::governance::ensure_can_summon_shenron(arg0);
        0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::governance::take_locked_update<0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::time_lock::TimeLock<OnboardLeverageMarketWish<T0>>>(arg0, 0x1::type_name::with_defining_ids<OnboardLeverageMarketWish<T0>>());
        assert!(0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::time_lock::is_active<OnboardLeverageMarketWish<T0>>(&v0, arg2), 0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::errors::time_locked_not_active());
        let v1 = 0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::time_lock::into_inner<OnboardLeverageMarketWish<T0>>(v0);
        0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::wish_event::emit_fulfill_wish_event<OnboardLeverageMarketWish<T0>>(v1);
        let OnboardLeverageMarketWish {
            market_id   : v2,
            emode_group : v3,
        } = v1;
        assert!(v2 == 0x2::object::id<0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::Market<T0>>(arg1), 0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::errors::invalid_market_id());
        0xb24d2c9ae39a07cabfeaa8afa89fc99b87486ee329ae3d99816bcdd2c5c6351d::leverage_admin::onboard_market<T0>(0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::governance::lending_admin_cap(arg0), arg1, v3, arg3);
    }

    public fun wish_onboard_leverage_market<T0>(arg0: &mut 0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::governance::DragonBallCollector, arg1: &0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::Market<T0>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::governance::ensure_can_summon_shenron(arg0);
        0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = OnboardLeverageMarketWish<T0>{
            market_id   : 0x2::object::id<0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::Market<T0>>(arg1),
            emode_group : arg2,
        };
        0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::wish_event::emit_new_wish_event<OnboardLeverageMarketWish<T0>>(v0);
        0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::governance::store_locked_update<0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::time_lock::TimeLock<OnboardLeverageMarketWish<T0>>>(arg0, 0x1::type_name::with_defining_ids<OnboardLeverageMarketWish<T0>>(), 0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::time_lock::new_time_locked<OnboardLeverageMarketWish<T0>>(v0, arg3, 0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::governance::time_lock_duration_seconds(arg0), 0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

