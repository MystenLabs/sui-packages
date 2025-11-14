module 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::adl_admin {
    struct NewADLSetEvent has copy, drop {
        market: 0x1::type_name::TypeName,
        coin: 0x1::type_name::TypeName,
        is_borrow: bool,
        emode_group_id: 0x1::option::Option<u8>,
        params: 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::adl::DeleverageParams,
        activation_timestamp: u64,
        time: u64,
        operator: address,
    }

    public fun enable_collateral_adl<T0, T1>(arg0: &0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::app::AdminCap, arg1: &0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::app::ProtocolApp, arg2: &mut 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::market::Market<T0>, arg3: 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::adl::DeleverageParams, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::market::has_circuit_break_triggered<T0>(arg2), 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::error::market_under_circuit_break());
        0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::app::validate_market<T0>(arg1, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg5) / 1000;
        let v1 = v0 + arg4;
        0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::adl::enable_collateral_deleverage<T1>(0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::market::adl_registry_mut<T0>(arg2), arg3, v1);
        let v2 = NewADLSetEvent{
            market               : 0x1::type_name::get<T0>(),
            coin                 : 0x1::type_name::get<T1>(),
            is_borrow            : false,
            emode_group_id       : 0x1::option::none<u8>(),
            params               : arg3,
            activation_timestamp : v1,
            time                 : v0,
            operator             : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<NewADLSetEvent>(v2);
    }

    public fun enable_debt_adl<T0, T1>(arg0: &0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::app::AdminCap, arg1: &0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::app::ProtocolApp, arg2: &mut 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::market::Market<T0>, arg3: u8, arg4: 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::adl::DeleverageParams, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::market::has_circuit_break_triggered<T0>(arg2), 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::error::market_under_circuit_break());
        0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::app::validate_market<T0>(arg1, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg6) / 1000;
        let v1 = v0 + arg5;
        0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::adl::enable_debt_deleverage<T1>(0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::market::adl_registry_mut<T0>(arg2), arg3, arg4, v1, arg7);
        let v2 = NewADLSetEvent{
            market               : 0x1::type_name::get<T0>(),
            coin                 : 0x1::type_name::get<T1>(),
            is_borrow            : true,
            emode_group_id       : 0x1::option::some<u8>(arg3),
            params               : arg4,
            activation_timestamp : v1,
            time                 : v0,
            operator             : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<NewADLSetEvent>(v2);
    }

    public fun new_adl_params<T0>(arg0: &0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::app::AdminCap, arg1: &0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::app::ProtocolApp, arg2: &mut 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::market::Market<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) : 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::adl::DeleverageParams {
        assert!(!0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::market::has_circuit_break_triggered<T0>(arg2), 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::error::market_under_circuit_break());
        0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::app::validate_market<T0>(arg1, arg2);
        0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::adl::new_auto_deleverage_params(arg3, 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::from_quotient(arg4, 10000), 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::from_quotient(arg5, 1000000000000000000), 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::from_quotient(arg6, 10000), 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::from_quotient(arg7, 1000000000000000000), 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::from_quotient(arg8, 10000))
    }

    // decompiled from Move bytecode v6
}

