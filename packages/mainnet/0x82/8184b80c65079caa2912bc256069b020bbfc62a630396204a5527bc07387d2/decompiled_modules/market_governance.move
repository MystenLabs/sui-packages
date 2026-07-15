module 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::market_governance {
    struct RegisterMarketWish<phantom T0> has copy, drop, store {
        protocol_app_id: 0x2::object::ID,
        market_config: 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::MarketConfiguration,
    }

    struct UpdateMarketWish<phantom T0> has copy, drop, store {
        protocol_app_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        market_config: 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::MarketConfiguration,
    }

    public fun discharge_circuit_break<T0>(arg0: &0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::roles::SuperAdminRole, arg1: &0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::DragonBallCollector, arg2: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::ProtocolApp, arg3: &mut 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::Market<T0>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::ensure_functional(arg1);
        0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market_admin::discharge_circuit_break<T0>(0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::lending_admin_cap(arg1), arg2, arg3, arg4, arg5);
    }

    public fun fulfill_register_market_wish<T0>(arg0: &mut 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::DragonBallCollector, arg1: &mut 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::ProtocolApp, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::ensure_functional(arg0);
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::take_locked_update<0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::time_lock::TimeLock<RegisterMarketWish<T0>>>(arg0, 0x1::type_name::with_defining_ids<RegisterMarketWish<T0>>());
        assert!(0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::time_lock::is_active<RegisterMarketWish<T0>>(&v0, arg2), 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::errors::time_locked_not_active());
        let v1 = 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::time_lock::into_inner<RegisterMarketWish<T0>>(v0);
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::ensure_protocol_app_match(arg1, &v1.protocol_app_id);
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::wish_event::emit_fulfill_wish_event<RegisterMarketWish<T0>>(v1);
        let RegisterMarketWish {
            protocol_app_id : _,
            market_config   : v3,
        } = v1;
        0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market_admin::register_market<T0>(0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::lending_admin_cap(arg0), arg1, v3, arg2, arg3)
    }

    public fun fulfill_update_market_wish<T0>(arg0: &mut 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::DragonBallCollector, arg1: &mut 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::ProtocolApp, arg2: &mut 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::ensure_functional(arg0);
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::take_locked_update<0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::time_lock::TimeLock<UpdateMarketWish<T0>>>(arg0, 0x1::type_name::with_defining_ids<UpdateMarketWish<T0>>());
        assert!(0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::time_lock::is_active<UpdateMarketWish<T0>>(&v0, arg3), 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::errors::time_locked_not_active());
        let v1 = 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::time_lock::into_inner<UpdateMarketWish<T0>>(v0);
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::ensure_protocol_app_match(arg1, &v1.protocol_app_id);
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::ensure_market_match<T0>(arg2, &v1.market_id);
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::wish_event::emit_fulfill_wish_event<UpdateMarketWish<T0>>(v1);
        let UpdateMarketWish {
            protocol_app_id : _,
            market_id       : _,
            market_config   : v4,
        } = v1;
        0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market_admin::update_market<T0>(0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::lending_admin_cap(arg0), arg1, arg2, v4, arg3, arg4);
    }

    public fun trigger_circuit_break<T0>(arg0: &0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::DragonBallCollector, arg1: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::ProtocolApp, arg2: &mut 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::ensure_functional(arg0);
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::ensure_watcher_allowed(arg0, 0x2::tx_context::sender(arg4));
        0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market_admin::trigger_circuit_break<T0>(0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::lending_admin_cap(arg0), arg1, arg2, arg3, arg4);
    }

    public fun update_market_ema_spot_tolerance<T0, T1>(arg0: &0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::DragonBallCollector, arg1: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::ProtocolApp, arg2: &mut 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::Market<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::ensure_functional(arg0);
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg5));
        0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market_admin::update_market_ema_spot_tolerance<T0, T1>(0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::lending_admin_cap(arg0), arg1, arg2, arg3, arg4, arg5);
    }

    public fun wish_register_market<T0>(arg0: &mut 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::DragonBallCollector, arg1: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::ProtocolApp, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::ensure_functional(arg0);
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg5));
        let v0 = RegisterMarketWish<T0>{
            protocol_app_id : 0x2::object::id<0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::ProtocolApp>(arg1),
            market_config   : 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market_admin::create_market_config(0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::lending_admin_cap(arg0), arg1, arg2, arg3),
        };
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::wish_event::emit_new_wish_event<RegisterMarketWish<T0>>(v0);
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::store_locked_update<0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::time_lock::TimeLock<RegisterMarketWish<T0>>>(arg0, 0x1::type_name::with_defining_ids<RegisterMarketWish<T0>>(), 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::time_lock::new_time_locked<RegisterMarketWish<T0>>(v0, arg4, 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::time_lock_duration_seconds(arg0), 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::time_lock_expriration_seconds(arg0)));
    }

    public fun wish_update_market<T0>(arg0: &mut 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::DragonBallCollector, arg1: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::ProtocolApp, arg2: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::Market<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::ensure_functional(arg0);
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg6));
        let v0 = UpdateMarketWish<T0>{
            protocol_app_id : 0x2::object::id<0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::ProtocolApp>(arg1),
            market_id       : 0x2::object::id<0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::Market<T0>>(arg2),
            market_config   : 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market_admin::create_market_config(0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::lending_admin_cap(arg0), arg1, arg3, arg4),
        };
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::wish_event::emit_new_wish_event<UpdateMarketWish<T0>>(v0);
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::store_locked_update<0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::time_lock::TimeLock<UpdateMarketWish<T0>>>(arg0, 0x1::type_name::with_defining_ids<UpdateMarketWish<T0>>(), 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::time_lock::new_time_locked<UpdateMarketWish<T0>>(v0, arg5, 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::time_lock_duration_seconds(arg0), 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

