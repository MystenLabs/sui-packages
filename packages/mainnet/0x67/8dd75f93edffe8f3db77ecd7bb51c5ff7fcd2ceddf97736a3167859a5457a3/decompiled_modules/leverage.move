module 0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::leverage {
    struct OnboardLeverageMarketWish<phantom T0> has copy, drop, store {
        market_id: 0x2::object::ID,
        emode_group: u8,
    }

    public fun fulfill_onboard_leverage_market_wish<T0>(arg0: &mut 0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::DragonBallCollector, arg1: &mut 0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_app::LeverageApp, arg2: &0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::ensure_functional(arg0);
        0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::take_locked_update<0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::time_lock::TimeLock<OnboardLeverageMarketWish<T0>>>(arg0, 0x1::type_name::with_defining_ids<OnboardLeverageMarketWish<T0>>());
        assert!(0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::time_lock::is_active<OnboardLeverageMarketWish<T0>>(&v0, arg3), 0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::errors::time_locked_not_active());
        let v1 = 0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::time_lock::into_inner<OnboardLeverageMarketWish<T0>>(v0);
        0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::wish_event::emit_fulfill_wish_event<OnboardLeverageMarketWish<T0>>(v1);
        let OnboardLeverageMarketWish {
            market_id   : v2,
            emode_group : v3,
        } = v1;
        assert!(v2 == 0x2::object::id<0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::market::Market<T0>>(arg2), 0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::errors::invalid_market_id());
        0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_admin::onboard_market<T0>(0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::lending_admin_cap(arg0), arg1, arg2, v3, arg4);
    }

    public fun grant_leverage_app_permissions(arg0: &mut 0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::DragonBallCollector, arg1: &mut 0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::app::ProtocolApp, arg2: &mut 0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_app::LeverageApp, arg3: &mut 0x2::tx_context::TxContext) {
        0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::ensure_functional(arg0);
        0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::whitelist_admin::mint_new_whitelist(0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::lending_admin_cap(arg0), arg1, arg3);
        let v1 = 0x2::object::id<0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::app::PackageCallerCap>(&v0);
        0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::whitelist_admin::update_permission(0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::lending_admin_cap(arg0), arg1, v1, 0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::whitelist_admin::enter_market_with_emode(), true);
        0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::whitelist_admin::update_permission(0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::lending_admin_cap(arg0), arg1, v1, 0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::whitelist_admin::flash_loan(), true);
        0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_admin::inject_protocol_caller_cap(0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::lending_admin_cap(arg0), arg2, v0);
    }

    public fun wish_onboard_leverage_market<T0>(arg0: &mut 0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::DragonBallCollector, arg1: &0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::market::Market<T0>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::ensure_functional(arg0);
        0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = OnboardLeverageMarketWish<T0>{
            market_id   : 0x2::object::id<0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::market::Market<T0>>(arg1),
            emode_group : arg2,
        };
        0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::wish_event::emit_new_wish_event<OnboardLeverageMarketWish<T0>>(v0);
        0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::store_locked_update<0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::time_lock::TimeLock<OnboardLeverageMarketWish<T0>>>(arg0, 0x1::type_name::with_defining_ids<OnboardLeverageMarketWish<T0>>(), 0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::time_lock::new_time_locked<OnboardLeverageMarketWish<T0>>(v0, arg3, 0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::time_lock_duration_seconds(arg0), 0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

