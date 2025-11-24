module 0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::market_governance {
    struct UpdateMarketWish<phantom T0> has copy, drop, store {
        market_config: 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::market::MarketConfiguration,
    }

    public fun discharge_circuit_break<T0>(arg0: &0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::roles::SuperAdminRole, arg1: &0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::DragonBallCollector, arg2: &mut 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::ensure_can_summon_shenron(arg1);
        0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::market_admin::discharge_circuit_break<T0>(0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::lending_admin_cap(arg1), arg2, arg3, arg4);
    }

    public fun trigger_circuit_break<T0>(arg0: &0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::DragonBallCollector, arg1: &mut 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::market::Market<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::ensure_can_summon_shenron(arg0);
        0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::ensure_watcher_allowed(arg0, 0x2::tx_context::sender(arg3));
        0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::market_admin::trigger_circuit_break<T0>(0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::lending_admin_cap(arg0), arg1, arg2, arg3);
    }

    public fun update_market_ema_spot_tolerance<T0, T1>(arg0: &0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::DragonBallCollector, arg1: &mut 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::market::Market<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::ensure_can_summon_shenron(arg0);
        0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::market_admin::update_market_ema_spot_tolerance<T0, T1>(0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::lending_admin_cap(arg0), arg1, arg2, arg3, arg4);
    }

    public fun fulfill_register_market_wish<T0>(arg0: &mut 0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::DragonBallCollector, arg1: &mut 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::app::ProtocolApp, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::ensure_can_summon_shenron(arg0);
        0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::take_locked_update<0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::time_lock::TimeLock<UpdateMarketWish<T0>>>(arg0, 0x1::type_name::with_defining_ids<UpdateMarketWish<T0>>());
        assert!(0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::time_lock::is_active<UpdateMarketWish<T0>>(&v0, arg2), 0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::errors::time_locked_not_active());
        let v1 = 0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::time_lock::into_inner<UpdateMarketWish<T0>>(v0);
        0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::wish_event::emit_fulfill_wish_event<UpdateMarketWish<T0>>(v1);
        let UpdateMarketWish { market_config: v2 } = v1;
        0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::market_admin::register_market<T0>(0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::lending_admin_cap(arg0), arg1, v2, arg2, arg3)
    }

    public fun fulfill_update_market_wish<T0>(arg0: &mut 0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::DragonBallCollector, arg1: &mut 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::app::ProtocolApp, arg2: &mut 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::ensure_can_summon_shenron(arg0);
        0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::take_locked_update<0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::time_lock::TimeLock<UpdateMarketWish<T0>>>(arg0, 0x1::type_name::with_defining_ids<UpdateMarketWish<T0>>());
        assert!(0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::time_lock::is_active<UpdateMarketWish<T0>>(&v0, arg3), 0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::errors::time_locked_not_active());
        let v1 = 0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::time_lock::into_inner<UpdateMarketWish<T0>>(v0);
        0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::wish_event::emit_fulfill_wish_event<UpdateMarketWish<T0>>(v1);
        let UpdateMarketWish { market_config: v2 } = v1;
        0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::market_admin::update_market<T0>(0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::lending_admin_cap(arg0), arg1, arg2, v2, arg3, arg4);
    }

    public fun wish_update_market<T0>(arg0: &mut 0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::DragonBallCollector, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::ensure_can_summon_shenron(arg0);
        0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = UpdateMarketWish<T0>{market_config: 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::market_admin::create_market_config(0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::lending_admin_cap(arg0), arg1, arg2)};
        0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::wish_event::emit_new_wish_event<UpdateMarketWish<T0>>(v0);
        0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::store_locked_update<0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::time_lock::TimeLock<UpdateMarketWish<T0>>>(arg0, 0x1::type_name::with_defining_ids<UpdateMarketWish<T0>>(), 0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::time_lock::new_time_locked<UpdateMarketWish<T0>>(v0, arg3, 0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::time_lock_duration_seconds(arg0), 0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

