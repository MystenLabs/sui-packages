module 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::emode_admin {
    struct NewEModeGroupEvent has copy, drop {
        market: 0x1::type_name::TypeName,
        emode_group_id: u8,
        oracle_base_token: u8,
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

    public fun create_emode_params(arg0: &0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::app::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::limiter::NewLimiter, arg8: 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::limiter::NewLimiter) : 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::emode::NewEMode {
        assert!(arg1 < 10000, 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::error::invalid_params_error());
        assert!(arg2 < 10000, 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::error::invalid_params_error());
        assert!(arg3 < 10000, 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::error::invalid_params_error());
        assert!(arg5 >= 10000, 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::error::invalid_params_error());
        assert!(arg6 < 10000, 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::error::invalid_params_error());
        0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::emode::new_emode_params(0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::from_quotient(arg1, 10000), 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::from_quotient(arg2, 10000), 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::from_quotient(arg3, 10000), arg4, 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::from_quotient(arg5, 10000), 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::from_quotient(arg6, 10000), arg7, arg8)
    }

    public fun create_limiter(arg0: &0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::app::AdminCap, arg1: u64, arg2: u32, arg3: u32) : 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::limiter::NewLimiter {
        0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::limiter::create_new_limiter_change(arg1, arg2, arg3)
    }

    public fun onboard_asset_to_emode_group<T0, T1>(arg0: &0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::app::AdminCap, arg1: &0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::app::ProtocolApp, arg2: &mut 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::market::Market<T0>, arg3: u8, arg4: 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::emode::NewEMode, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::market::has_circuit_break_triggered<T0>(arg2), 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::error::market_under_circuit_break());
        0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::app::validate_market<T0>(arg1, arg2);
        0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::emode::support_asset<T1>(0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::market::emode_registry_mut<T0>(arg2), arg3, arg4, arg5);
        let v0 = EModeUpdated<0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::emode::NewEMode>{
            who    : 0x2::tx_context::sender(arg5),
            what   : 0,
            market : 0x1::type_name::get<T0>(),
            asset  : 0x1::type_name::get<T1>(),
            new    : arg4,
        };
        0x2::event::emit<EModeUpdated<0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::emode::NewEMode>>(v0);
    }

    public fun onboard_new_emode_group<T0>(arg0: &0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::app::AdminCap, arg1: &0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::app::ProtocolApp, arg2: &mut 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::market::Market<T0>, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::market::has_circuit_break_triggered<T0>(arg2), 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::error::market_under_circuit_break());
        0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::app::validate_market<T0>(arg1, arg2);
        let v0 = NewEModeGroupEvent{
            market            : 0x1::type_name::get<T0>(),
            emode_group_id    : 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::emode::new_emode_group(0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::market::emode_registry_mut<T0>(arg2), arg3, arg5),
            oracle_base_token : arg3,
            time              : 0x2::clock::timestamp_ms(arg4) / 1000,
            operator          : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<NewEModeGroupEvent>(v0);
    }

    public fun update_asset_in_emode_group<T0, T1>(arg0: &0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::app::AdminCap, arg1: &0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::app::ProtocolApp, arg2: &mut 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::market::Market<T0>, arg3: u8, arg4: 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::emode::NewEMode, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::market::has_circuit_break_triggered<T0>(arg2), 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::error::market_under_circuit_break());
        0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::app::validate_market<T0>(arg1, arg2);
        let v0 = 0x1::type_name::get<T1>();
        0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::emode::update(0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::emode::borrow_mut_emode(0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::market::emode_registry_mut<T0>(arg2), arg3, v0), arg4);
        let v1 = EModeUpdated<0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::emode::NewEMode>{
            who    : 0x2::tx_context::sender(arg5),
            what   : 0,
            market : 0x1::type_name::get<T0>(),
            asset  : v0,
            new    : arg4,
        };
        0x2::event::emit<EModeUpdated<0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::emode::NewEMode>>(v1);
    }

    // decompiled from Move bytecode v6
}

