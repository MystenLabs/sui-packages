module 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::market_admin {
    struct MarketRegisteredEvent has copy, drop {
        market_id: 0x2::object::ID,
        market_type: 0x1::type_name::TypeName,
        sender: address,
        timestamp_ms: u64,
    }

    struct MarketUpdatedEvent has copy, drop {
        config: 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::market::MarketConfiguration,
        market_type: 0x1::type_name::TypeName,
        market_id: 0x2::object::ID,
        sender: address,
        timestamp_ms: u64,
    }

    struct MarketCircuiBreakChanged has copy, drop {
        market_type: 0x1::type_name::TypeName,
        market_id: 0x2::object::ID,
        sender: address,
        timestamp_ms: u64,
        is_triggered: bool,
    }

    struct EmaSpotToleranceChanged has copy, drop {
        market_type: 0x1::type_name::TypeName,
        market_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        sender: address,
        timestamp_ms: u64,
        tolerance: u64,
    }

    public fun discharge_circuit_break<T0>(arg0: &0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::AdminCap, arg1: &0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::ProtocolApp, arg2: &mut 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::validate_market<T0>(arg1, arg2);
        0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::ensure_version_matches(arg1);
        0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::market::discharge_circuit_break<T0>(arg2);
        let v0 = MarketCircuiBreakChanged{
            market_type  : 0x1::type_name::with_defining_ids<T0>(),
            market_id    : 0x2::object::id<0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::market::Market<T0>>(arg2),
            sender       : 0x2::tx_context::sender(arg4),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
            is_triggered : false,
        };
        0x2::event::emit<MarketCircuiBreakChanged>(v0);
    }

    public fun trigger_circuit_break<T0>(arg0: &0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::AdminCap, arg1: &0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::ProtocolApp, arg2: &mut 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::validate_market<T0>(arg1, arg2);
        0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::ensure_version_matches(arg1);
        0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::market::trigger_circuit_break<T0>(arg2);
        let v0 = MarketCircuiBreakChanged{
            market_type  : 0x1::type_name::with_defining_ids<T0>(),
            market_id    : 0x2::object::id<0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::market::Market<T0>>(arg2),
            sender       : 0x2::tx_context::sender(arg4),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
            is_triggered : true,
        };
        0x2::event::emit<MarketCircuiBreakChanged>(v0);
    }

    public fun create_market_config(arg0: &0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::AdminCap, arg1: &0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::ProtocolApp, arg2: u64, arg3: u64) : 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::market::MarketConfiguration {
        assert!(arg2 > 0, 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::error::invalid_params_error());
        assert!(arg2 <= 100, 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::error::invalid_params_error());
        assert!(arg3 != 0, 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::error::invalid_params_error());
        0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::ensure_version_matches(arg1);
        0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::market::new_market_configuration(0xa8238dcaf33f70aa16f605d4744ffa049607b2a58a6a7fc728beb2ab346ce2af::float::from_quotient(arg2, 100), arg3)
    }

    public fun register_market<T0>(arg0: &0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::AdminCap, arg1: &mut 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::ProtocolApp, arg2: 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::market::MarketConfiguration, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::is_market_registered<T0>(arg1), 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::error::market_already_exists());
        0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::ensure_version_matches(arg1);
        let v1 = 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::market::new<T0>(arg2, arg4);
        let v2 = 0x2::object::id<0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::market::Market<T0>>(&v1);
        0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::add_market<T0>(arg1, v2);
        0x2::transfer::public_share_object<0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::market::Market<T0>>(v1);
        let v3 = MarketRegisteredEvent{
            market_id    : v2,
            market_type  : v0,
            sender       : 0x2::tx_context::sender(arg4),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<MarketRegisteredEvent>(v3);
        let v4 = MarketUpdatedEvent{
            config       : arg2,
            market_type  : v0,
            market_id    : v2,
            sender       : 0x2::tx_context::sender(arg4),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<MarketUpdatedEvent>(v4);
        v2
    }

    public fun update_market<T0>(arg0: &0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::AdminCap, arg1: &0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::ProtocolApp, arg2: &mut 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::market::Market<T0>, arg3: 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::market::MarketConfiguration, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::validate_market<T0>(arg1, arg2);
        0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::ensure_version_matches(arg1);
        0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::market::update_market_config<T0>(arg2, arg3);
        let v0 = MarketUpdatedEvent{
            config       : arg3,
            market_type  : 0x1::type_name::with_defining_ids<T0>(),
            market_id    : 0x2::object::id<0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::market::Market<T0>>(arg2),
            sender       : 0x2::tx_context::sender(arg5),
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<MarketUpdatedEvent>(v0);
    }

    public fun update_market_ema_spot_tolerance<T0, T1>(arg0: &0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::AdminCap, arg1: &0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::ProtocolApp, arg2: &mut 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::market::Market<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::validate_market<T0>(arg1, arg2);
        0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::ensure_version_matches(arg1);
        0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::market::set_ema_spot_tolerance<T0, T1>(arg2, arg3);
        let v0 = EmaSpotToleranceChanged{
            market_type  : 0x1::type_name::with_defining_ids<T0>(),
            market_id    : 0x2::object::id<0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::market::Market<T0>>(arg2),
            asset_type   : 0x1::type_name::with_defining_ids<T1>(),
            sender       : 0x2::tx_context::sender(arg5),
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
            tolerance    : arg3,
        };
        0x2::event::emit<EmaSpotToleranceChanged>(v0);
    }

    // decompiled from Move bytecode v6
}

