module 0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::leverage {
    struct OnboardLeverageMarketWish<phantom T0> has copy, drop, store {
        market_id: 0x2::object::ID,
        emode_group: u8,
    }

    public fun fulfill_onboard_leverage_market_wish<T0>(arg0: &mut 0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::DragonBallCollector, arg1: &mut 0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_app::LeverageApp, arg2: &0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::ensure_functional(arg0);
        0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::take_locked_update<0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::time_lock::TimeLock<OnboardLeverageMarketWish<T0>>>(arg0, 0x1::type_name::with_defining_ids<OnboardLeverageMarketWish<T0>>());
        assert!(0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::time_lock::is_active<OnboardLeverageMarketWish<T0>>(&v0, arg3), 0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::errors::time_locked_not_active());
        let v1 = 0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::time_lock::into_inner<OnboardLeverageMarketWish<T0>>(v0);
        0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::wish_event::emit_fulfill_wish_event<OnboardLeverageMarketWish<T0>>(v1);
        let OnboardLeverageMarketWish {
            market_id   : v2,
            emode_group : v3,
        } = v1;
        assert!(v2 == 0x2::object::id<0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::market::Market<T0>>(arg2), 0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::errors::invalid_market_id());
        0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_admin::onboard_market<T0>(0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::lending_admin_cap(arg0), arg1, arg2, v3, arg4);
    }

    public fun grant_leverage_app_permissions(arg0: &mut 0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::DragonBallCollector, arg1: &mut 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::app::ProtocolApp, arg2: &mut 0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_app::LeverageApp, arg3: &mut 0x2::tx_context::TxContext) {
        0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::ensure_functional(arg0);
        0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::whitelist_admin::mint_new_whitelist(0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::lending_admin_cap(arg0), arg1, arg3);
        let v1 = 0x2::object::id<0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::app::PackageCallerCap>(&v0);
        0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::whitelist_admin::update_permission(0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::lending_admin_cap(arg0), arg1, v1, 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::whitelist_admin::enter_market_with_emode(), true);
        0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::whitelist_admin::update_permission(0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::lending_admin_cap(arg0), arg1, v1, 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::whitelist_admin::flash_loan(), true);
        0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_admin::inject_protocol_caller_cap(0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::lending_admin_cap(arg0), arg2, v0);
    }

    public fun wish_onboard_leverage_market<T0>(arg0: &mut 0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::DragonBallCollector, arg1: &0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::market::Market<T0>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::ensure_functional(arg0);
        0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = OnboardLeverageMarketWish<T0>{
            market_id   : 0x2::object::id<0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::market::Market<T0>>(arg1),
            emode_group : arg2,
        };
        0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::wish_event::emit_new_wish_event<OnboardLeverageMarketWish<T0>>(v0);
        0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::store_locked_update<0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::time_lock::TimeLock<OnboardLeverageMarketWish<T0>>>(arg0, 0x1::type_name::with_defining_ids<OnboardLeverageMarketWish<T0>>(), 0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::time_lock::new_time_locked<OnboardLeverageMarketWish<T0>>(v0, arg3, 0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::time_lock_duration_seconds(arg0), 0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

