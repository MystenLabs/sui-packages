module 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market_admin {
    struct MarketRegisteredEvent has copy, drop {
        market_id: 0x2::object::ID,
        market_type: 0x1::type_name::TypeName,
        sender: address,
        timestamp_ms: u64,
    }

    struct MarketUpdatedEvent has copy, drop {
        config: 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::MarketConfiguration,
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

    public fun discharge_circuit_break<T0>(arg0: &0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::app::AdminCap, arg1: &mut 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::Market<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::discharge_circuit_break<T0>(arg1);
        let v0 = MarketCircuiBreakChanged{
            market_type  : 0x1::type_name::get<T0>(),
            sender       : 0x2::tx_context::sender(arg3),
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
            is_triggered : false,
        };
        0x2::event::emit<MarketCircuiBreakChanged>(v0);
    }

    public fun trigger_circuit_break<T0>(arg0: &0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::app::AdminCap, arg1: &mut 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::Market<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::trigger_circuit_break<T0>(arg1);
        let v0 = MarketCircuiBreakChanged{
            market_type  : 0x1::type_name::get<T0>(),
            sender       : 0x2::tx_context::sender(arg3),
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
            is_triggered : true,
        };
        0x2::event::emit<MarketCircuiBreakChanged>(v0);
    }

    public fun create_market_config(arg0: &0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::app::AdminCap, arg1: u64, arg2: u64) : 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::MarketConfiguration {
        assert!(arg1 > 0, 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::error::invalid_params_error());
        assert!(arg2 > 0, 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::error::invalid_params_error());
        assert!(arg1 <= arg2, 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::error::invalid_params_error());
        0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::new_market_configuration(0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::from_quotient(arg1, arg2))
    }

    public fun register_market<T0>(arg0: &0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::app::AdminCap, arg1: &mut 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::app::ProtocolApp, arg2: 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::MarketConfiguration, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(!0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::app::is_market_registered<T0>(arg1), 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::error::market_already_exists());
        let v0 = 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::new<T0>(arg2, arg4);
        let v1 = 0x2::object::id<0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::Market<T0>>(&v0);
        0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::app::add_market<T0>(arg1, v1);
        0x2::transfer::public_share_object<0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::Market<T0>>(v0);
        let v2 = MarketRegisteredEvent{
            market_id    : v1,
            market_type  : 0x1::type_name::get<T0>(),
            sender       : 0x2::tx_context::sender(arg4),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<MarketRegisteredEvent>(v2);
        v1
    }

    public fun update_market<T0>(arg0: &0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::app::AdminCap, arg1: &0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::app::ProtocolApp, arg2: &mut 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::Market<T0>, arg3: 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::MarketConfiguration, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::app::is_market_registered<T0>(arg1), 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::error::market_not_found());
        0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::update_market_config<T0>(arg2, arg3);
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

