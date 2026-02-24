module 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market_admin {
    struct MarketRegisteredEvent has copy, drop {
        market_id: 0x2::object::ID,
        market_type: 0x1::type_name::TypeName,
        sender: address,
        timestamp_ms: u64,
    }

    struct MarketUpdatedEvent has copy, drop {
        config: 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::MarketConfiguration,
        market_type: 0x1::type_name::TypeName,
        sender: address,
        timestamp_ms: u64,
    }

    struct MarketCircuiBreakChanged has copy, drop {
        market_type: 0x1::type_name::TypeName,
        sender: address,
        timestamp_ms: u64,
        is_triggered: bool,
    }

    struct EmaSpotToleranceChanged has copy, drop {
        market_type: 0x1::type_name::TypeName,
        asset_type: 0x1::type_name::TypeName,
        sender: address,
        timestamp_ms: u64,
        tolerance: u64,
    }

    public fun discharge_circuit_break<T0>(arg0: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::AdminCap, arg1: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ProtocolApp, arg2: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::validate_market<T0>(arg1, arg2);
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ensure_version_matches(arg1);
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::discharge_circuit_break<T0>(arg2);
        let v0 = MarketCircuiBreakChanged{
            market_type  : 0x1::type_name::with_defining_ids<T0>(),
            sender       : 0x2::tx_context::sender(arg4),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
            is_triggered : false,
        };
        0x2::event::emit<MarketCircuiBreakChanged>(v0);
    }

    public fun trigger_circuit_break<T0>(arg0: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::AdminCap, arg1: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ProtocolApp, arg2: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::validate_market<T0>(arg1, arg2);
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ensure_version_matches(arg1);
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::trigger_circuit_break<T0>(arg2);
        let v0 = MarketCircuiBreakChanged{
            market_type  : 0x1::type_name::with_defining_ids<T0>(),
            sender       : 0x2::tx_context::sender(arg4),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
            is_triggered : true,
        };
        0x2::event::emit<MarketCircuiBreakChanged>(v0);
    }

    public fun create_market_config(arg0: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::AdminCap, arg1: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ProtocolApp, arg2: u64, arg3: u64) : 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::MarketConfiguration {
        assert!(arg2 > 0, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::invalid_params_error());
        assert!(arg2 <= 100, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::invalid_params_error());
        assert!(arg3 != 0, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::invalid_params_error());
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ensure_version_matches(arg1);
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::new_market_configuration(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::from_quotient(arg2, 100), arg3)
    }

    public fun register_market<T0>(arg0: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::AdminCap, arg1: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ProtocolApp, arg2: 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::MarketConfiguration, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(!0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::is_market_registered<T0>(arg1), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::market_already_exists());
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ensure_version_matches(arg1);
        let v0 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::new<T0>(arg2, arg4);
        let v1 = 0x2::object::id<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<T0>>(&v0);
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::add_market<T0>(arg1, v1);
        0x2::transfer::public_share_object<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<T0>>(v0);
        let v2 = MarketRegisteredEvent{
            market_id    : v1,
            market_type  : 0x1::type_name::with_defining_ids<T0>(),
            sender       : 0x2::tx_context::sender(arg4),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<MarketRegisteredEvent>(v2);
        v1
    }

    public fun update_market<T0>(arg0: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::AdminCap, arg1: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ProtocolApp, arg2: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<T0>, arg3: 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::MarketConfiguration, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::validate_market<T0>(arg1, arg2);
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ensure_version_matches(arg1);
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::update_market_config<T0>(arg2, arg3);
        let v0 = MarketUpdatedEvent{
            config       : arg3,
            market_type  : 0x1::type_name::with_defining_ids<T0>(),
            sender       : 0x2::tx_context::sender(arg5),
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<MarketUpdatedEvent>(v0);
    }

    public fun update_market_ema_spot_tolerance<T0, T1>(arg0: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::AdminCap, arg1: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ProtocolApp, arg2: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::validate_market<T0>(arg1, arg2);
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ensure_version_matches(arg1);
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::set_ema_spot_tolerance<T0, T1>(arg2, arg3);
        let v0 = EmaSpotToleranceChanged{
            market_type  : 0x1::type_name::with_defining_ids<T0>(),
            asset_type   : 0x1::type_name::with_defining_ids<T1>(),
            sender       : 0x2::tx_context::sender(arg5),
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
            tolerance    : arg3,
        };
        0x2::event::emit<EmaSpotToleranceChanged>(v0);
    }

    // decompiled from Move bytecode v6
}

