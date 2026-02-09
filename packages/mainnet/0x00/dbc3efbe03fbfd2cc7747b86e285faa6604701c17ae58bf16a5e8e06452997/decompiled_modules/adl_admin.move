module 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::adl_admin {
    struct NewADLSetEvent has copy, drop {
        market: 0x1::type_name::TypeName,
        coin: 0x1::type_name::TypeName,
        is_borrow: bool,
        emode_group_id: 0x1::option::Option<u8>,
        params: 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::adl::DeleverageParams,
        activation_timestamp: u64,
        time: u64,
        operator: address,
    }

    struct ADLCancelEvent has copy, drop {
        market: 0x1::type_name::TypeName,
        coin: 0x1::type_name::TypeName,
        is_borrow: bool,
        emode_group_id: 0x1::option::Option<u8>,
        time: u64,
        operator: address,
    }

    public fun cancel_collateral_adl<T0, T1>(arg0: &0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::app::AdminCap, arg1: &0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::app::ProtocolApp, arg2: &mut 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        check_market<T0>(arg1, arg2);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::adl::stop_collateral_deleverage<T1>(0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::market::adl_registry_mut<T0>(arg2), v0);
        let v1 = ADLCancelEvent{
            market         : v0,
            coin           : 0x1::type_name::with_defining_ids<T1>(),
            is_borrow      : false,
            emode_group_id : 0x1::option::none<u8>(),
            time           : 0x2::clock::timestamp_ms(arg3),
            operator       : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<ADLCancelEvent>(v1);
    }

    public fun cancel_debt_adl<T0, T1>(arg0: &0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::app::AdminCap, arg1: &0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::app::ProtocolApp, arg2: &mut 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::market::Market<T0>, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        check_market<T0>(arg1, arg2);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::adl::stop_borrow_deleverage<T1>(0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::market::adl_registry_mut<T0>(arg2), v0, arg3);
        let v1 = ADLCancelEvent{
            market         : v0,
            coin           : 0x1::type_name::with_defining_ids<T1>(),
            is_borrow      : true,
            emode_group_id : 0x1::option::some<u8>(arg3),
            time           : 0x2::clock::timestamp_ms(arg4) / 1000,
            operator       : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<ADLCancelEvent>(v1);
    }

    fun check_market<T0>(arg0: &0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::app::ProtocolApp, arg1: &0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::market::Market<T0>) {
        assert!(!0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::market::has_circuit_break_triggered<T0>(arg1), 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::error::market_under_circuit_break());
        0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::app::validate_market<T0>(arg0, arg1);
    }

    public fun enable_collateral_adl<T0, T1>(arg0: &0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::app::AdminCap, arg1: &0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::app::ProtocolApp, arg2: &mut 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::market::Market<T0>, arg3: 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::adl::DeleverageParams, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(arg4 <= 259200, 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::error::invalid_params_error());
        check_market<T0>(arg1, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg5) / 1000;
        let v1 = v0 + arg4;
        0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::adl::enable_collateral_deleverage<T1>(0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::market::adl_registry_mut<T0>(arg2), arg3, v1);
        let v2 = NewADLSetEvent{
            market               : 0x1::type_name::with_defining_ids<T0>(),
            coin                 : 0x1::type_name::with_defining_ids<T1>(),
            is_borrow            : false,
            emode_group_id       : 0x1::option::none<u8>(),
            params               : arg3,
            activation_timestamp : v1,
            time                 : v0,
            operator             : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<NewADLSetEvent>(v2);
    }

    public fun enable_debt_adl<T0, T1>(arg0: &0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::app::AdminCap, arg1: &0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::app::ProtocolApp, arg2: &mut 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::market::Market<T0>, arg3: u8, arg4: 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::adl::DeleverageParams, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 <= 259200, 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::error::invalid_params_error());
        check_market<T0>(arg1, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg6) / 1000;
        let v1 = v0 + arg5;
        0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::adl::enable_debt_deleverage<T1>(0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::market::adl_registry_mut<T0>(arg2), arg3, arg4, v1, arg7);
        let v2 = NewADLSetEvent{
            market               : 0x1::type_name::with_defining_ids<T0>(),
            coin                 : 0x1::type_name::with_defining_ids<T1>(),
            is_borrow            : true,
            emode_group_id       : 0x1::option::some<u8>(arg3),
            params               : arg4,
            activation_timestamp : v1,
            time                 : v0,
            operator             : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<NewADLSetEvent>(v2);
    }

    public fun new_adl_params<T0>(arg0: &0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::app::AdminCap, arg1: &0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::app::ProtocolApp, arg2: &0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::market::Market<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) : 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::adl::DeleverageParams {
        assert!(0 < arg4 && arg4 <= 10000, 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::error::invalid_params_error());
        assert!(0 < arg8 && arg8 <= 10000, 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::error::invalid_params_error());
        check_market<T0>(arg1, arg2);
        0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::adl::new_auto_deleverage_params(arg3, 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::from_quotient(arg4, 10000), 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::from_quotient(arg5, 1000000000000000000), 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::from_quotient(arg6, 10000), 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::from_quotient(arg7, 1000000000000000000), 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::from_quotient(arg8, 10000))
    }

    // decompiled from Move bytecode v6
}

