module 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::market_governance {
    struct UpdateMarketWish has copy, drop, store {
        market_config: 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::MarketConfiguration,
        market_type: 0x1::type_name::TypeName,
    }

    public fun discharge_circuit_break<T0>(arg0: &0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::roles::SuperAdminRole, arg1: &0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::DragonBallCollector, arg2: &mut 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::ensure_can_summon_shenron(arg1);
        0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market_admin::discharge_circuit_break<T0>(0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::lending_admin_cap(arg1), arg2, arg3, arg4);
    }

    public fun fulfill_register_market_wish<T0>(arg0: &mut 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::DragonBallCollector, arg1: &mut 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::app::ProtocolApp, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::ensure_can_summon_shenron(arg0);
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::take_locked_update<0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::time_lock::TimeLock<UpdateMarketWish>>(arg0, 0x1::type_name::with_defining_ids<UpdateMarketWish>());
        assert!(0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::time_lock::is_active<UpdateMarketWish>(&v0, arg2), 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::errors::time_locked_not_active());
        let UpdateMarketWish {
            market_config : v1,
            market_type   : v2,
        } = 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::time_lock::into_inner<UpdateMarketWish>(v0);
        assert!(v2 == 0x1::type_name::with_defining_ids<T0>(), 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::errors::invalid_market_type());
        0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market_admin::register_market<T0>(0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::lending_admin_cap(arg0), arg1, v1, arg2, arg3)
    }

    public fun fulfill_update_market_wish<T0>(arg0: &mut 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::DragonBallCollector, arg1: &mut 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::app::ProtocolApp, arg2: &mut 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::ensure_can_summon_shenron(arg0);
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::take_locked_update<0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::time_lock::TimeLock<UpdateMarketWish>>(arg0, 0x1::type_name::with_defining_ids<UpdateMarketWish>());
        assert!(0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::time_lock::is_active<UpdateMarketWish>(&v0, arg3), 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::errors::time_locked_not_active());
        let UpdateMarketWish {
            market_config : v1,
            market_type   : v2,
        } = 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::time_lock::into_inner<UpdateMarketWish>(v0);
        assert!(v2 == 0x1::type_name::with_defining_ids<T0>(), 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::errors::invalid_market_type());
        0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market_admin::update_market<T0>(0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::lending_admin_cap(arg0), arg1, arg2, v1, arg3, arg4);
    }

    public fun trigger_circuit_break<T0>(arg0: &0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::DragonBallCollector, arg1: &mut 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::Market<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::ensure_can_summon_shenron(arg0);
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::ensure_watcher_allowed(arg0, 0x2::tx_context::sender(arg3));
        0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market_admin::trigger_circuit_break<T0>(0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::lending_admin_cap(arg0), arg1, arg2, arg3);
    }

    public fun update_market_ema_spot_tolerance<T0, T1>(arg0: &0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::DragonBallCollector, arg1: &mut 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::Market<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::ensure_can_summon_shenron(arg0);
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market_admin::update_market_ema_spot_tolerance<T0, T1>(0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::lending_admin_cap(arg0), arg1, arg2, arg3, arg4);
    }

    public fun wish_update_market<T0>(arg0: &mut 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::DragonBallCollector, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::ensure_can_summon_shenron(arg0);
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = UpdateMarketWish{
            market_config : 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market_admin::create_market_config(0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::lending_admin_cap(arg0), arg1, arg2),
            market_type   : 0x1::type_name::with_defining_ids<T0>(),
        };
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::store_locked_update<0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::time_lock::TimeLock<UpdateMarketWish>>(arg0, 0x1::type_name::with_defining_ids<UpdateMarketWish>(), 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::time_lock::new_time_locked<UpdateMarketWish>(v0, arg3, 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::time_lock_duration_seconds(arg0), 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

