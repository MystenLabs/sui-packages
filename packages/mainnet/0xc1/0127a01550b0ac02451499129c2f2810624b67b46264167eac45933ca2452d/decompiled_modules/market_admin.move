module 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market_admin {
    struct MarketRegisteredEvent has copy, drop {
        market_id: 0x2::object::ID,
        market_type: 0x1::type_name::TypeName,
        sender: address,
        timestamp_ms: u64,
    }

    struct MarketUpdatedEvent has copy, drop {
        config: 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::MarketConfiguration,
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

    public fun discharge_circuit_break<T0>(arg0: &0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::app::AdminCap, arg1: &mut 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::Market<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::discharge_circuit_break<T0>(arg1);
        let v0 = MarketCircuiBreakChanged{
            market_type  : 0x1::type_name::get<T0>(),
            sender       : 0x2::tx_context::sender(arg3),
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
            is_triggered : false,
        };
        0x2::event::emit<MarketCircuiBreakChanged>(v0);
    }

    public fun trigger_circuit_break<T0>(arg0: &0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::app::AdminCap, arg1: &mut 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::Market<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::trigger_circuit_break<T0>(arg1);
        let v0 = MarketCircuiBreakChanged{
            market_type  : 0x1::type_name::get<T0>(),
            sender       : 0x2::tx_context::sender(arg3),
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
            is_triggered : true,
        };
        0x2::event::emit<MarketCircuiBreakChanged>(v0);
    }

    public fun create_market_config(arg0: &0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::app::AdminCap, arg1: u64, arg2: u64) : 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::MarketConfiguration {
        assert!(arg1 > 0, 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::error::invalid_params_error());
        assert!(arg2 > 0, 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::error::invalid_params_error());
        assert!(arg1 <= arg2, 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::error::invalid_params_error());
        0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::new_market_configuration(0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::from_quotient(arg1, arg2))
    }

    public fun register_market<T0>(arg0: &0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::app::AdminCap, arg1: &mut 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::app::ProtocolApp, arg2: 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::MarketConfiguration, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(!0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::app::is_market_registered<T0>(arg1), 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::error::market_already_exists());
        let v0 = 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::new<T0>(arg2, arg4);
        let v1 = 0x2::object::id<0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::Market<T0>>(&v0);
        0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::app::add_market<T0>(arg1, v1);
        0x2::transfer::public_share_object<0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::Market<T0>>(v0);
        let v2 = MarketRegisteredEvent{
            market_id    : v1,
            market_type  : 0x1::type_name::get<T0>(),
            sender       : 0x2::tx_context::sender(arg4),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<MarketRegisteredEvent>(v2);
        v1
    }

    public fun update_market<T0>(arg0: &0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::app::AdminCap, arg1: &0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::app::ProtocolApp, arg2: &mut 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::Market<T0>, arg3: 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::MarketConfiguration, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::app::is_market_registered<T0>(arg1), 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::error::market_not_found());
        0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::update_market_config<T0>(arg2, arg3);
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

