module 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market_admin {
    struct MarketRegisteredEvent has copy, drop {
        market_id: 0x2::object::ID,
        market_type: 0x1::type_name::TypeName,
        sender: address,
        timestamp_ms: u64,
    }

    struct MarketUpdatedEvent has copy, drop {
        config: 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::MarketConfiguration,
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

    public fun discharge_circuit_break<T0>(arg0: &0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::app::AdminCap, arg1: &mut 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::Market<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::discharge_circuit_break<T0>(arg1);
        let v0 = MarketCircuiBreakChanged{
            market_type  : 0x1::type_name::get<T0>(),
            sender       : 0x2::tx_context::sender(arg3),
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
            is_triggered : false,
        };
        0x2::event::emit<MarketCircuiBreakChanged>(v0);
    }

    public fun trigger_circuit_break<T0>(arg0: &0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::app::AdminCap, arg1: &mut 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::Market<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::trigger_circuit_break<T0>(arg1);
        let v0 = MarketCircuiBreakChanged{
            market_type  : 0x1::type_name::get<T0>(),
            sender       : 0x2::tx_context::sender(arg3),
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
            is_triggered : true,
        };
        0x2::event::emit<MarketCircuiBreakChanged>(v0);
    }

    public fun create_market_config(arg0: &0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::app::AdminCap, arg1: u64, arg2: u64) : 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::MarketConfiguration {
        assert!(arg1 > 0, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::error::invalid_params_error());
        assert!(arg2 > 0, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::error::invalid_params_error());
        assert!(arg1 <= arg2, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::error::invalid_params_error());
        0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::new_market_configuration(0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::from_quotient(arg1, arg2))
    }

    public fun register_market<T0>(arg0: &0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::app::AdminCap, arg1: &mut 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::app::ProtocolApp, arg2: 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::MarketConfiguration, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(!0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::app::is_market_registered<T0>(arg1), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::error::market_already_exists());
        let v0 = 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::new<T0>(arg2, arg4);
        let v1 = 0x2::object::id<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::Market<T0>>(&v0);
        0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::app::add_market<T0>(arg1, v1);
        0x2::transfer::public_share_object<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::Market<T0>>(v0);
        let v2 = MarketRegisteredEvent{
            market_id    : v1,
            market_type  : 0x1::type_name::get<T0>(),
            sender       : 0x2::tx_context::sender(arg4),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<MarketRegisteredEvent>(v2);
        v1
    }

    public fun update_market<T0>(arg0: &0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::app::AdminCap, arg1: &0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::app::ProtocolApp, arg2: &mut 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::Market<T0>, arg3: 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::MarketConfiguration, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::app::is_market_registered<T0>(arg1), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::error::market_not_found());
        0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::update_market_config<T0>(arg2, arg3);
        let v0 = MarketUpdatedEvent{
            config       : arg3,
            market_type  : 0x1::type_name::get<T0>(),
            sender       : 0x2::tx_context::sender(arg5),
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<MarketUpdatedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

