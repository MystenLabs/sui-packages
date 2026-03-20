module 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::market_admin {
    struct MarketRegisteredEvent has copy, drop {
        market_id: 0x2::object::ID,
        market_type: 0x1::type_name::TypeName,
        sender: address,
        timestamp_ms: u64,
    }

    struct MarketUpdatedEvent has copy, drop {
        config: 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::market::MarketConfiguration,
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

    public fun discharge_circuit_break<T0>(arg0: &0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::app::AdminCap, arg1: &0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::app::ProtocolApp, arg2: &mut 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::app::validate_market<T0>(arg1, arg2);
        0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::app::ensure_version_matches(arg1);
        0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::market::discharge_circuit_break<T0>(arg2);
        let v0 = MarketCircuiBreakChanged{
            market_type  : 0x1::type_name::with_defining_ids<T0>(),
            market_id    : 0x2::object::id<0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::market::Market<T0>>(arg2),
            sender       : 0x2::tx_context::sender(arg4),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
            is_triggered : false,
        };
        0x2::event::emit<MarketCircuiBreakChanged>(v0);
    }

    public fun trigger_circuit_break<T0>(arg0: &0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::app::AdminCap, arg1: &0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::app::ProtocolApp, arg2: &mut 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::app::validate_market<T0>(arg1, arg2);
        0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::app::ensure_version_matches(arg1);
        0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::market::trigger_circuit_break<T0>(arg2);
        let v0 = MarketCircuiBreakChanged{
            market_type  : 0x1::type_name::with_defining_ids<T0>(),
            market_id    : 0x2::object::id<0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::market::Market<T0>>(arg2),
            sender       : 0x2::tx_context::sender(arg4),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
            is_triggered : true,
        };
        0x2::event::emit<MarketCircuiBreakChanged>(v0);
    }

    public fun create_market_config(arg0: &0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::app::AdminCap, arg1: &0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::app::ProtocolApp, arg2: u64, arg3: u64) : 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::market::MarketConfiguration {
        assert!(arg2 > 0, 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::error::invalid_params_error());
        assert!(arg2 <= 100, 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::error::invalid_params_error());
        assert!(arg3 != 0, 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::error::invalid_params_error());
        0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::app::ensure_version_matches(arg1);
        0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::market::new_market_configuration(0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::from_quotient(arg2, 100), arg3)
    }

    public fun register_market<T0>(arg0: &0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::app::AdminCap, arg1: &mut 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::app::ProtocolApp, arg2: 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::market::MarketConfiguration, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::app::is_market_registered<T0>(arg1), 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::error::market_already_exists());
        0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::app::ensure_version_matches(arg1);
        let v1 = 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::market::new<T0>(arg2, arg4);
        let v2 = 0x2::object::id<0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::market::Market<T0>>(&v1);
        0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::app::add_market<T0>(arg1, v2);
        0x2::transfer::public_share_object<0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::market::Market<T0>>(v1);
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

    public fun update_market<T0>(arg0: &0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::app::AdminCap, arg1: &0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::app::ProtocolApp, arg2: &mut 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::market::Market<T0>, arg3: 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::market::MarketConfiguration, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::app::validate_market<T0>(arg1, arg2);
        0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::app::ensure_version_matches(arg1);
        0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::market::update_market_config<T0>(arg2, arg3);
        let v0 = MarketUpdatedEvent{
            config       : arg3,
            market_type  : 0x1::type_name::with_defining_ids<T0>(),
            market_id    : 0x2::object::id<0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::market::Market<T0>>(arg2),
            sender       : 0x2::tx_context::sender(arg5),
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<MarketUpdatedEvent>(v0);
    }

    public fun update_market_ema_spot_tolerance<T0, T1>(arg0: &0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::app::AdminCap, arg1: &0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::app::ProtocolApp, arg2: &mut 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::market::Market<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::app::validate_market<T0>(arg1, arg2);
        0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::app::ensure_version_matches(arg1);
        0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::market::set_ema_spot_tolerance<T0, T1>(arg2, arg3);
        let v0 = EmaSpotToleranceChanged{
            market_type  : 0x1::type_name::with_defining_ids<T0>(),
            market_id    : 0x2::object::id<0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::market::Market<T0>>(arg2),
            asset_type   : 0x1::type_name::with_defining_ids<T1>(),
            sender       : 0x2::tx_context::sender(arg5),
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
            tolerance    : arg3,
        };
        0x2::event::emit<EmaSpotToleranceChanged>(v0);
    }

    // decompiled from Move bytecode v6
}

