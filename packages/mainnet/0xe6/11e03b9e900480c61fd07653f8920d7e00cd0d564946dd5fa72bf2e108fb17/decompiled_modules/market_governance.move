module 0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::market_governance {
    struct UpdateMarketWish<phantom T0> has copy, drop, store {
        market_config: 0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::market::MarketConfiguration,
    }

    public fun discharge_circuit_break<T0>(arg0: &0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::roles::SuperAdminRole, arg1: &0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::DragonBallCollector, arg2: &mut 0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::ensure_can_summon_shenron(arg1);
        0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::market_admin::discharge_circuit_break<T0>(0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::lending_admin_cap(arg1), arg2, arg3, arg4);
    }

    public fun trigger_circuit_break<T0>(arg0: &0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::DragonBallCollector, arg1: &mut 0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::market::Market<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::ensure_can_summon_shenron(arg0);
        0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::ensure_watcher_allowed(arg0, 0x2::tx_context::sender(arg3));
        0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::market_admin::trigger_circuit_break<T0>(0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::lending_admin_cap(arg0), arg1, arg2, arg3);
    }

    public fun update_market_ema_spot_tolerance<T0, T1>(arg0: &0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::DragonBallCollector, arg1: &mut 0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::market::Market<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::ensure_can_summon_shenron(arg0);
        0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::market_admin::update_market_ema_spot_tolerance<T0, T1>(0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::lending_admin_cap(arg0), arg1, arg2, arg3, arg4);
    }

    public fun fulfill_register_market_wish<T0>(arg0: &mut 0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::DragonBallCollector, arg1: &mut 0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::app::ProtocolApp, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::ensure_can_summon_shenron(arg0);
        0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::take_locked_update<0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::time_lock::TimeLock<UpdateMarketWish<T0>>>(arg0, 0x1::type_name::with_defining_ids<UpdateMarketWish<T0>>());
        assert!(0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::time_lock::is_active<UpdateMarketWish<T0>>(&v0, arg2), 0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::errors::time_locked_not_active());
        let v1 = 0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::time_lock::into_inner<UpdateMarketWish<T0>>(v0);
        0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::wish_event::emit_fulfill_wish_event<UpdateMarketWish<T0>>(v1);
        let UpdateMarketWish { market_config: v2 } = v1;
        0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::market_admin::register_market<T0>(0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::lending_admin_cap(arg0), arg1, v2, arg2, arg3)
    }

    public fun fulfill_update_market_wish<T0>(arg0: &mut 0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::DragonBallCollector, arg1: &mut 0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::app::ProtocolApp, arg2: &mut 0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::ensure_can_summon_shenron(arg0);
        0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::take_locked_update<0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::time_lock::TimeLock<UpdateMarketWish<T0>>>(arg0, 0x1::type_name::with_defining_ids<UpdateMarketWish<T0>>());
        assert!(0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::time_lock::is_active<UpdateMarketWish<T0>>(&v0, arg3), 0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::errors::time_locked_not_active());
        let v1 = 0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::time_lock::into_inner<UpdateMarketWish<T0>>(v0);
        0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::wish_event::emit_fulfill_wish_event<UpdateMarketWish<T0>>(v1);
        let UpdateMarketWish { market_config: v2 } = v1;
        0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::market_admin::update_market<T0>(0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::lending_admin_cap(arg0), arg1, arg2, v2, arg3, arg4);
    }

    public fun wish_update_market<T0>(arg0: &mut 0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::DragonBallCollector, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::ensure_can_summon_shenron(arg0);
        0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = UpdateMarketWish<T0>{market_config: 0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::market_admin::create_market_config(0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::lending_admin_cap(arg0), arg1, arg2)};
        0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::wish_event::emit_new_wish_event<UpdateMarketWish<T0>>(v0);
        0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::store_locked_update<0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::time_lock::TimeLock<UpdateMarketWish<T0>>>(arg0, 0x1::type_name::with_defining_ids<UpdateMarketWish<T0>>(), 0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::time_lock::new_time_locked<UpdateMarketWish<T0>>(v0, arg3, 0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::time_lock_duration_seconds(arg0), 0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

