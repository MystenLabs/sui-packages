module 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::emode_admin {
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

    public fun create_emode_params(arg0: &0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::app::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::limiter::NewLimiter, arg8: 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::limiter::NewLimiter) : 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::emode::NewEMode {
        assert!(arg1 < arg2, 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::error::invalid_params_error());
        assert!(arg2 - arg1 < arg3, 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::error::invalid_params_error());
        assert!(arg2 * (10000 + arg3) / 10000 < 10000, 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::error::invalid_params_error());
        create_emode_params_inner(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    fun create_emode_params_inner(arg0: &0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::app::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::limiter::NewLimiter, arg8: 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::limiter::NewLimiter) : 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::emode::NewEMode {
        assert!(arg1 < 10000, 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::error::invalid_params_error());
        assert!(arg2 < 10000, 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::error::invalid_params_error());
        assert!(arg3 < 10000, 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::error::invalid_params_error());
        assert!(arg5 >= 10000, 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::error::invalid_params_error());
        assert!(arg6 < 10000, 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::error::invalid_params_error());
        0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::emode::new_emode_params(0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::from_quotient(arg1, 10000), 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::from_quotient(arg2, 10000), 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::from_quotient(arg3, 10000), arg4, 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::from_quotient(arg5, 10000), 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::from_quotient(arg6, 10000), arg7, arg8)
    }

    public fun create_limiter(arg0: &0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::app::AdminCap, arg1: u64, arg2: u32, arg3: u32) : 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::limiter::NewLimiter {
        0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::limiter::create_new_limiter_change(arg1, arg2, arg3)
    }

    public fun onboard_asset_to_emode_group<T0, T1>(arg0: &0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::app::AdminCap, arg1: &0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::app::ProtocolApp, arg2: &mut 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::Market<T0>, arg3: u8, arg4: 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::emode::NewEMode, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::has_circuit_break_triggered<T0>(arg2), 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::error::market_under_circuit_break());
        0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::app::validate_market<T0>(arg1, arg2);
        0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::emode::support_asset<T1>(0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::emode_registry_mut<T0>(arg2), arg3, arg4, arg5);
        let v0 = EModeUpdated<0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::emode::NewEMode>{
            who    : 0x2::tx_context::sender(arg5),
            what   : 0,
            market : 0x1::type_name::with_defining_ids<T0>(),
            asset  : 0x1::type_name::with_defining_ids<T1>(),
            new    : arg4,
        };
        0x2::event::emit<EModeUpdated<0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::emode::NewEMode>>(v0);
    }

    public fun onboard_new_emode_group<T0>(arg0: &0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::app::AdminCap, arg1: &0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::app::ProtocolApp, arg2: &mut 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::Market<T0>, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::has_circuit_break_triggered<T0>(arg2), 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::error::market_under_circuit_break());
        0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::app::validate_market<T0>(arg1, arg2);
        let v0 = NewEModeGroupEvent{
            market            : 0x1::type_name::with_defining_ids<T0>(),
            emode_group_id    : 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::emode::new_emode_group(0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::emode_registry_mut<T0>(arg2), arg3, arg5),
            oracle_base_token : arg3,
            time              : 0x2::clock::timestamp_ms(arg4) / 1000,
            operator          : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<NewEModeGroupEvent>(v0);
    }

    public fun update_asset_in_emode_group<T0, T1>(arg0: &0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::app::AdminCap, arg1: &0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::app::ProtocolApp, arg2: &mut 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::Market<T0>, arg3: u8, arg4: 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::emode::NewEMode, arg5: &0x2::tx_context::TxContext) {
        assert!(!0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::has_circuit_break_triggered<T0>(arg2), 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::error::market_under_circuit_break());
        0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::app::validate_market<T0>(arg1, arg2);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::emode::update(0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::emode::borrow_mut_emode(0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::emode_registry_mut<T0>(arg2), arg3, v0), arg4);
        let v1 = EModeUpdated<0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::emode::NewEMode>{
            who    : 0x2::tx_context::sender(arg5),
            what   : 1,
            market : 0x1::type_name::with_defining_ids<T0>(),
            asset  : v0,
            new    : arg4,
        };
        0x2::event::emit<EModeUpdated<0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::emode::NewEMode>>(v1);
    }

    // decompiled from Move bytecode v6
}

