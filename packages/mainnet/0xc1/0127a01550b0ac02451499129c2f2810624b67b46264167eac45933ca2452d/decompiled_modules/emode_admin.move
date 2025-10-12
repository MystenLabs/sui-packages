module 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::emode_admin {
    struct NewEModeGroupEvent has copy, drop {
        market: 0x1::type_name::TypeName,
        emode_group_id: u8,
        time: u64,
        operator: address,
    }

    struct EModeUpdated<T0> has copy, drop {
        who: address,
        what: u8,
        market: 0x1::type_name::TypeName,
        asset: 0x1::type_name::TypeName,
        new: T0,
    }

    public fun create_emode_params(arg0: &0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::app::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::limiter::NewLimiter, arg8: 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::limiter::NewLimiter) : 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::emode::NewEMode {
        assert!(arg1 < 10000, 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::error::invalid_params_error());
        assert!(arg2 < 10000, 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::error::invalid_params_error());
        assert!(arg3 < 10000, 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::error::invalid_params_error());
        assert!(arg5 >= 10000, 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::error::invalid_params_error());
        assert!(arg6 < 10000, 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::error::invalid_params_error());
        0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::emode::new_emode_params(0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::from_quotient(arg1, 10000), 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::from_quotient(arg2, 10000), 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::from_quotient(arg3, 10000), arg4, 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::from_quotient(arg5, 10000), 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::from_quotient(arg6, 10000), arg7, arg8)
    }

    public fun create_limiter(arg0: &0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::app::AdminCap, arg1: u64, arg2: u32, arg3: u32) : 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::limiter::NewLimiter {
        0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::limiter::create_new_limiter_change(arg1, arg2, arg3)
    }

    public fun onboard_asset_to_emode_group<T0, T1>(arg0: &0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::app::AdminCap, arg1: &0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::app::ProtocolApp, arg2: &mut 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::Market<T0>, arg3: u8, arg4: 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::emode::NewEMode, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::has_circuit_break_triggered<T0>(arg2), 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::error::market_under_circuit_break());
        0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::app::validate_market<T0>(arg1, arg2);
        0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::emode::support_asset<T1>(0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::emode_registry_mut<T0>(arg2), arg3, arg4, arg5);
        let v0 = EModeUpdated<0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::emode::NewEMode>{
            who    : 0x2::tx_context::sender(arg5),
            what   : 0,
            market : 0x1::type_name::get<T0>(),
            asset  : 0x1::type_name::get<T1>(),
            new    : arg4,
        };
        0x2::event::emit<EModeUpdated<0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::emode::NewEMode>>(v0);
    }

    public fun onboard_new_emode_group<T0>(arg0: &0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::app::AdminCap, arg1: &0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::app::ProtocolApp, arg2: &mut 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::has_circuit_break_triggered<T0>(arg2), 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::error::market_under_circuit_break());
        0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::app::validate_market<T0>(arg1, arg2);
        let v0 = NewEModeGroupEvent{
            market         : 0x1::type_name::get<T0>(),
            emode_group_id : 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::emode::new_emode_group(0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::emode_registry_mut<T0>(arg2), arg4),
            time           : 0x2::clock::timestamp_ms(arg3) / 1000,
            operator       : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<NewEModeGroupEvent>(v0);
    }

    public fun update_asset_in_emode_group<T0, T1>(arg0: &0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::app::AdminCap, arg1: &0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::app::ProtocolApp, arg2: &mut 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::Market<T0>, arg3: u8, arg4: 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::emode::NewEMode, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::has_circuit_break_triggered<T0>(arg2), 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::error::market_under_circuit_break());
        0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::app::validate_market<T0>(arg1, arg2);
        let v0 = 0x1::type_name::get<T1>();
        0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::emode::borrow_mut_emode(0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::emode_registry_mut<T0>(arg2), arg3, v0);
        let v1 = EModeUpdated<0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::emode::NewEMode>{
            who    : 0x2::tx_context::sender(arg5),
            what   : 0,
            market : 0x1::type_name::get<T0>(),
            asset  : v0,
            new    : arg4,
        };
        0x2::event::emit<EModeUpdated<0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::emode::NewEMode>>(v1);
    }

    // decompiled from Move bytecode v6
}

