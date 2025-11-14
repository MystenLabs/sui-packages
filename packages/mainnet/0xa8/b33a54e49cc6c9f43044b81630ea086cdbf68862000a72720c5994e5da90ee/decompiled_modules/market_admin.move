module 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market_admin {
    struct MarketRegisteredEvent has copy, drop {
        market_id: 0x2::object::ID,
        market_type: 0x1::type_name::TypeName,
        sender: address,
        timestamp_ms: u64,
    }

    struct MarketUpdatedEvent has copy, drop {
        config: 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::MarketConfiguration,
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

    public fun discharge_circuit_break<T0>(arg0: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::app::AdminCap, arg1: &mut 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::Market<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::discharge_circuit_break<T0>(arg1);
        let v0 = MarketCircuiBreakChanged{
            market_type  : 0x1::type_name::get<T0>(),
            sender       : 0x2::tx_context::sender(arg3),
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
            is_triggered : false,
        };
        0x2::event::emit<MarketCircuiBreakChanged>(v0);
    }

    public fun trigger_circuit_break<T0>(arg0: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::app::AdminCap, arg1: &mut 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::Market<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::trigger_circuit_break<T0>(arg1);
        let v0 = MarketCircuiBreakChanged{
            market_type  : 0x1::type_name::get<T0>(),
            sender       : 0x2::tx_context::sender(arg3),
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
            is_triggered : true,
        };
        0x2::event::emit<MarketCircuiBreakChanged>(v0);
    }

    public fun create_market_config(arg0: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::app::AdminCap, arg1: u64, arg2: u64) : 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::MarketConfiguration {
        assert!(arg1 > 0, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::error::invalid_params_error());
        assert!(arg1 <= 100, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::error::invalid_params_error());
        assert!(arg2 != 0, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::error::invalid_params_error());
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::new_market_configuration(0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::from_quotient(arg1, 100), arg2)
    }

    public fun register_market<T0>(arg0: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::app::AdminCap, arg1: &mut 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::app::ProtocolApp, arg2: 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::MarketConfiguration, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(!0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::app::is_market_registered<T0>(arg1), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::error::market_already_exists());
        let v0 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::new<T0>(arg2, arg4);
        let v1 = 0x2::object::id<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::Market<T0>>(&v0);
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::app::add_market<T0>(arg1, v1);
        0x2::transfer::public_share_object<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::Market<T0>>(v0);
        let v2 = MarketRegisteredEvent{
            market_id    : v1,
            market_type  : 0x1::type_name::get<T0>(),
            sender       : 0x2::tx_context::sender(arg4),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<MarketRegisteredEvent>(v2);
        v1
    }

    public fun update_market<T0>(arg0: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::app::AdminCap, arg1: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::app::ProtocolApp, arg2: &mut 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::Market<T0>, arg3: 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::MarketConfiguration, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::app::is_market_registered<T0>(arg1), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::error::market_not_found());
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::update_market_config<T0>(arg2, arg3);
        let v0 = MarketUpdatedEvent{
            config       : arg3,
            market_type  : 0x1::type_name::get<T0>(),
            sender       : 0x2::tx_context::sender(arg5),
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<MarketUpdatedEvent>(v0);
    }

    public fun update_market_ema_spot_tolerance<T0, T1>(arg0: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::app::AdminCap, arg1: &mut 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::Market<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::set_ema_spot_tolerance<T0, T1>(arg1, arg2);
        let v0 = EmaSpotToleranceChanged{
            market_type  : 0x1::type_name::get<T0>(),
            asset_type   : 0x1::type_name::get<T1>(),
            sender       : 0x2::tx_context::sender(arg4),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
            tolerance    : arg2,
        };
        0x2::event::emit<EmaSpotToleranceChanged>(v0);
    }

    // decompiled from Move bytecode v6
}

