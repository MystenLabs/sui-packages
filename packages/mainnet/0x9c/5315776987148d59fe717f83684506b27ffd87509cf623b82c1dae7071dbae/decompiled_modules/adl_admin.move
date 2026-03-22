module 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::adl_admin {
    struct NewADLSetEvent has copy, drop {
        market: 0x1::type_name::TypeName,
        coin: 0x1::type_name::TypeName,
        is_borrow: bool,
        emode_group_id: 0x1::option::Option<u8>,
        params: 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::adl::DeleverageParams,
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

    public fun cancel_collateral_adl<T0, T1>(arg0: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::AdminCap, arg1: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ProtocolApp, arg2: &mut 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        check_market<T0>(arg1, arg2);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::adl::stop_collateral_deleverage<T1>(0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::adl_registry_mut<T0>(arg2), v0);
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

    public fun cancel_debt_adl<T0, T1>(arg0: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::AdminCap, arg1: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ProtocolApp, arg2: &mut 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::Market<T0>, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        check_market<T0>(arg1, arg2);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::adl::stop_borrow_deleverage<T1>(0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::adl_registry_mut<T0>(arg2), v0, arg3);
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

    fun check_market<T0>(arg0: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ProtocolApp, arg1: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::Market<T0>) {
        assert!(!0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::has_circuit_break_triggered<T0>(arg1), 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::error::market_under_circuit_break());
        0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::validate_market<T0>(arg0, arg1);
        0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ensure_version_matches(arg0);
    }

    public fun enable_collateral_adl<T0, T1>(arg0: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::AdminCap, arg1: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ProtocolApp, arg2: &mut 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::Market<T0>, arg3: 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::adl::DeleverageParams, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(arg4 <= 259200, 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::error::invalid_params_error());
        check_market<T0>(arg1, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg5) / 1000;
        let v1 = v0 + arg4;
        0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::adl::enable_collateral_deleverage<T1>(0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::adl_registry_mut<T0>(arg2), arg3, v1);
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

    public fun enable_debt_adl<T0, T1>(arg0: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::AdminCap, arg1: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ProtocolApp, arg2: &mut 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::Market<T0>, arg3: u8, arg4: 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::adl::DeleverageParams, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 <= 259200, 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::error::invalid_params_error());
        check_market<T0>(arg1, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg6) / 1000;
        let v1 = v0 + arg5;
        0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::adl::enable_debt_deleverage<T1>(0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::adl_registry_mut<T0>(arg2), arg3, arg4, v1, arg7);
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

    public fun new_adl_params<T0>(arg0: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::AdminCap, arg1: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ProtocolApp, arg2: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::Market<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) : 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::adl::DeleverageParams {
        assert!(0 < arg4 && arg4 <= 10000, 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::error::invalid_params_error());
        assert!(0 < arg8 && arg8 <= 10000, 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::error::invalid_params_error());
        check_market<T0>(arg1, arg2);
        0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::adl::new_auto_deleverage_params(arg3, 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::from_quotient(arg4, 10000), 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::from_quotient(arg5, 1000000000000000000), 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::from_quotient(arg6, 10000), 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::from_quotient(arg7, 1000000000000000000), 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::from_quotient(arg8, 10000))
    }

    // decompiled from Move bytecode v6
}

