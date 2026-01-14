module 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::adl_admin {
    struct NewADLSetEvent has copy, drop {
        market: 0x1::type_name::TypeName,
        coin: 0x1::type_name::TypeName,
        is_borrow: bool,
        emode_group_id: 0x1::option::Option<u8>,
        params: 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::adl::DeleverageParams,
        activation_timestamp: u64,
        time: u64,
        operator: address,
    }

    public fun enable_collateral_adl<T0, T1>(arg0: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::app::AdminCap, arg1: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::app::ProtocolApp, arg2: &mut 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::market::Market<T0>, arg3: 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::adl::DeleverageParams, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::market::has_circuit_break_triggered<T0>(arg2), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::error::market_under_circuit_break());
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::app::validate_market<T0>(arg1, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg5) / 1000;
        let v1 = v0 + arg4;
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::adl::enable_collateral_deleverage<T1>(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::market::adl_registry_mut<T0>(arg2), arg3, v1);
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

    public fun enable_debt_adl<T0, T1>(arg0: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::app::AdminCap, arg1: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::app::ProtocolApp, arg2: &mut 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::market::Market<T0>, arg3: u8, arg4: 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::adl::DeleverageParams, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::market::has_circuit_break_triggered<T0>(arg2), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::error::market_under_circuit_break());
        assert!(arg5 <= 259200, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::error::invalid_params_error());
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::app::validate_market<T0>(arg1, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg6) / 1000;
        let v1 = v0 + arg5;
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::adl::enable_debt_deleverage<T1>(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::market::adl_registry_mut<T0>(arg2), arg3, arg4, v1, arg7);
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

    public fun new_adl_params<T0>(arg0: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::app::AdminCap, arg1: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::app::ProtocolApp, arg2: &mut 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::market::Market<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) : 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::adl::DeleverageParams {
        assert!(0 < arg4 && arg4 <= 10000, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::error::invalid_params_error());
        assert!(0 < arg8 && arg8 <= 10000, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::error::invalid_params_error());
        assert!(!0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::market::has_circuit_break_triggered<T0>(arg2), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::error::market_under_circuit_break());
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::app::validate_market<T0>(arg1, arg2);
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::adl::new_auto_deleverage_params(arg3, 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::from_quotient(arg4, 10000), 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::from_quotient(arg5, 1000000000000000000), 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::from_quotient(arg6, 10000), 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::from_quotient(arg7, 1000000000000000000), 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::from_quotient(arg8, 10000))
    }

    // decompiled from Move bytecode v6
}

